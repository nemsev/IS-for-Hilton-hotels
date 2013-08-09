class HotelsuppliesController < ApplicationController
  before_filter :require_login
  # GET /hotelsupplies
  # GET /hotelsupplies.json
  def index
    @hotelsupplies = Hotelsupply.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @hotelsupplies }
      format.pdf do
        pdf = HotelsupplyPdf.new(@hotelsupplies, view_context)
        send_data pdf.render, filename: "hotelsupplies_#{Time.now.strftime('%d/%m/%Y')}.pdf", type: "application/pdf"
      end
    end
  end

  # GET /hotelsupplies/1
  # GET /hotelsupplies/1.json
  def show
    @hotelsupply = Hotelsupply.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @hotelsupply }
    end
  end

  # GET /hotelsupplies/new
  # GET /hotelsupplies/new.json
  def new
    @hotelsupply = Hotelsupply.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @hotelsupply }
    end
  end

  # GET /hotelsupplies/1/edit
  def edit
    @hotelsupply = Hotelsupply.find(params[:id])
  end

  # POST /hotelsupplies
  # POST /hotelsupplies.json
  def create
    @hotelsupply = Hotelsupply.new(params[:hotelsupply])

    respond_to do |format|
      if @hotelsupply.save
        format.html { redirect_to @hotelsupply, notice: 'Hotelsupply was successfully created.' }
        format.json { render json: @hotelsupply, status: :created, location: @hotelsupply }
      else
        format.html { render action: "new" }
        format.json { render json: @hotelsupply.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /hotelsupplies/1
  # PUT /hotelsupplies/1.json
  def update
    @hotelsupply = Hotelsupply.find(params[:id])

    respond_to do |format|
      if @hotelsupply.update_attributes(params[:hotelsupply])
        format.html { redirect_to @hotelsupply, notice: 'Hotelsupply was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @hotelsupply.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /hotelsupplies/1
  # DELETE /hotelsupplies/1.json
  def destroy
    @hotelsupply = Hotelsupply.find(params[:id])
    @hotelsupply.destroy

    respond_to do |format|
      format.html { redirect_to hotelsupplies_url }
      format.json { head :no_content }
    end
  end
end
