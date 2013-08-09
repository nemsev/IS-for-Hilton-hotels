# coding: utf-8
class StationeryrequestPdf < Prawn::Document
  def initialize(stationeryrequest, view)
    super()
    @stationeryrequest = stationeryrequest
    @view = view
    # отрисовать выходной документ
    draw_document
  end
  # ширина колонок
  Widths = [80, 270, 90, 100]
  # заглавия колонок
  Headers = ['Кто затребовал', 'Наименование товара', 'Количество товара', 'Цена за единицу(руб.)']
  
  def row(employee, name, num, cost)
    row = [employee, name, num, cost]
    make_table([row]) do |t|
      t.column_widths = Widths
      t.cells.style :borders => [:left, :right], :padding => 2
    end
  end
  
  def draw_document
    # привязываем шрифты
    font_families.update(
      "Verdana" => {
        :bold => "/Users/antonnemtsev/prawn_fonts/verdanab.ttf",
        :italic => "/Users/antonnemtsev/prawn_fonts/verdana.ttf",
        :normal => "/Users/antonnemtsev/prawn_fonts/verdana.ttf"})
    font "Verdana", :size => 12
    text "Отчет о списании ТМЦ со склада по требованию Службы приема и размещения от #{Time.now.strftime('%d/%m/%Y')}", :size => 14, :style => :bold, :align => :center
    move_down(50)   
    # выборка записей
    @requests = @stationeryrequest.hotelsuppliesrequests
    data = [ ]
    number_of_goods = 0
    cost_of_all_goods = 0
    goods = @requests.each do |request|
      data << row(@stationeryrequest.employee.employee, request.hotelsupply.name, request.num, request.hotelsupply.cost)
      number_of_goods += request.num
      cost_of_all_goods += request.hotelsupply.cost * request.num
    end
    
    head = make_table([Headers], :column_widths => Widths)
    table([[head], *(data.map{|d| [d]})], :header => true, :row_colors => %w[cccccc ffffff]) do
      row(0).style :background_color => '000000', :text_color => 'ffffff'
      cells.style :borders => []
    end
    table([["Итого: #{number_of_goods} единиц товара, на общую сумму #{cost_of_all_goods} рублей"]], :width => 540)
    move_down(20)
    text "Подпись __________", :size => 12, :align => :right
    # добавим время создания внизу страницы
    creation_date = Time.now.strftime("Отчет сгенерирован %e.%m.%Y в %H:%M")
    go_to_page(page_count)
    move_down(710)
    text creation_date, :align => :right, :style => :italic, :size => 9
    
  end
  
end