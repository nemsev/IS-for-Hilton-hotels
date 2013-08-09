# encoding: utf-8
class TaxirequestsController < ApplicationController
  before_filter :require_login
  # GET /taxirequests
  # GET /taxirequests.json
  def index
    end_date = Time.now.to_date+1
    start_date = Time.now.to_date-Time.now.to_date.day+1
    #узнать кол-во всех заявок на такси за месяц
    @all_taxirequests = Taxirequest.where(:created_at => start_date..end_date)
    @taxirequests = Taxirequest.where(:arrival_date => Time.now.to_date, :status => 0)
    #заявки такси на вчера
    @taxirequests_yesterday = Taxirequest.where(:arrival_date => Time.now.to_date-1, :status => 0)
    #заявки такси на 2 дня назад
    @taxirequests_2days_ago = Taxirequest.where(:arrival_date => Time.now.to_date-2, :status => 0)
    if(params[:id])
      a = [ ]
      # b - временный массив
      b = [ ]
      i = 0
      @closedtaxirequests = Taxirequest.where(:arrival_date => Time.now.to_date-params[:id].to_i, :status => 1).select('employee_id,payment_method,destination,arrival_time')
      @closedtaxirequests.each do |taxirequest|
        employee = Employee.find(taxirequest.employee_id)
        b[0] = employee.employee
        b[1] = taxirequest.payment_method
        b[2] = taxirequest.destination
        b[3] = taxirequest.arrival_time.strftime('%H:%M')
        a[i] = b
        b = [ ]
        i += 1
      end
    end

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: a }
      format.pdf do
        pdf = TaxirequestPdf.new(@all_taxirequests, view_context)
        send_data pdf.render, filename: "taxirequests_#{Time.now.strftime('%d/%m/%Y')}.pdf", type: "application/pdf"
      end
    end
  end

  # GET /taxirequests/1
  # GET /taxirequests/1.json
  def show
    @taxirequest = Taxirequest.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @taxirequest }
    end
  end

  # GET /taxirequests/new
  # GET /taxirequests/new.json
  def new
    @taxirequest = Taxirequest.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @taxirequest }
    end
  end

  # GET /taxirequests/1/edit
  def edit
    @taxirequest = Taxirequest.find(params[:id])
  end

  # POST /taxirequests
  # POST /taxirequests.json
  def create
    # Вызвать такси
    @order_number = Taxirequest.call_a_taxi(params[:taxirequest])
    # Разместить заявку на такси в таблице taxirequests
    @taxirequest = Taxirequest.add_request(params[:taxirequest], session[:employee_id], @order_number)
    #@taxirequest = Taxirequest.new(params[:taxirequest])

    respond_to do |format|
      if @taxirequest.save
        format.html { redirect_to @taxirequest, notice: 'Taxirequest was successfully created.'+@response }
        format.json { render json: @taxirequest, status: :created, location: @taxirequest }
      else
        format.html { render action: "new" }
        format.json { render json: taxirequest.errors, status: :unprocessable_entity }
      end
    end

  end

  # PUT /taxirequests/1
  # PUT /taxirequests/1.json
  def update
    @taxirequest = Taxirequest.find(params[:id])

    respond_to do |format|
      if @taxirequest.update_attributes(params[:taxirequest])
        format.html { redirect_to @taxirequest, notice: 'Taxirequest was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @taxirequest.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /taxirequests/1
  # DELETE /taxirequests/1.json
  def destroy
    @taxirequest = Taxirequest.find(params[:id])
    @taxirequest.destroy

    respond_to do |format|
      format.html { redirect_to taxirequests_url }
      format.json { head :no_content }
    end
  end
end
