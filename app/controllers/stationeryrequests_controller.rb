class StationeryrequestsController < ApplicationController
  before_filter :require_login
  # GET /stationeryrequests
  # GET /stationeryrequests.json
  def index
    @stationeryrequests = Stationeryrequest.order("id DESC").all
    
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @stationeryrequests }
    end
  end

  # GET /stationeryrequests/1
  # GET /stationeryrequests/1.json
  def show
    @stationeryrequest = Stationeryrequest.find(params[:id])
    @stationeryrequest.hotelsuppliesrequests.each do |request|
      request.hotelsupply.num -= request.num
      request.hotelsupply.save
    end
    @stationeryrequest.status = 1
    @stationeryrequest.save

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @stationeryrequest }
      format.pdf do
        pdf = StationeryrequestPdf.new(@stationeryrequest, view_context)
        send_data pdf.render, filename: "stationeryrequest_#{Time.now.strftime('%d/%m/%Y')}.pdf", type: "application/pdf"
      end
    end
  end

  # GET /stationeryrequests/new
  # GET /stationeryrequests/new.json
  def new
    @stationeryrequest = Stationeryrequest.new
    # получить список предметов на складе
    @hotelsupplies = Hotelsupply.all

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @stationeryrequest }
    end
  end

  # GET /stationeryrequests/1/edit
  def edit
    @stationeryrequest = Stationeryrequest.find(params[:id])
    
    # получить список предметов на складе
    @hotelsupplies = Hotelsupply.all
  end

  # POST /stationeryrequests
  # POST /stationeryrequests.json
  def create
    # создать новую заявку на канцелярию
    @stationeryrequest = Stationeryrequest.new
    # инициализировать значения полей заявки
    @stationeryrequest.status = 0
    @stationeryrequest.employee_id = session[:employee_id].to_i
    @stationeryrequest.save
    if(params[:selected_items] && params[:numbers])
      @selected_items = params[:selected_items]
      @numbers = params[:numbers]
      @selected_items.each do |item|
        @hotelsuppliesrequest = Hotelsuppliesrequest.new
        @hotelsuppliesrequest.stationeryrequest_id = @stationeryrequest.id
        @hotelsuppliesrequest.hotelsupply_id = item
        @hotelsuppliesrequest.num = @numbers[item]
        @hotelsuppliesrequest.save
      end
    end

    respond_to do |format|
      if true
        format.html { redirect_to '/stationeryrequests', notice: 'Stationeryrequest was successfully created.' }
        format.json { render json: @stationeryrequest, status: :created, location: @stationeryrequest }
      else
        format.html { render action: "new" }
        format.json { render json: @stationeryrequest.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /stationeryrequests/1
  # PUT /stationeryrequests/1.json
  def update
    @stationeryrequest = Stationeryrequest.find(params[:id])
    #
    @stationeryrequest.hotelsuppliesrequests.each do |hotelsuppliesrequests|
      
    end

    respond_to do |format|
      if @stationeryrequest.update_attributes(params[:stationeryrequest])
        format.html { redirect_to @stationeryrequest, notice: 'Stationeryrequest was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @stationeryrequest.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /stationeryrequests/1
  # DELETE /stationeryrequests/1.json
  def destroy
    @stationeryrequest = Stationeryrequest.find(params[:id])
    @stationeryrequest.destroy

    respond_to do |format|
      format.html { redirect_to stationeryrequests_url }
      format.json { head :no_content }
    end
  end
end
