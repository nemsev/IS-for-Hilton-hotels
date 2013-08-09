# coding: utf-8
class HotelsupplyPdf < Prawn::Document
  def initialize(hotelsupplies, view)
    super()
    @hotelsupplies = hotelsupplies
    @view = view
    # отрисовать выходной документ
    draw_document
  end
  # ширина колонок
  Widths = [40, 300, 100, 100]
  # заглавия колонок
  Headers = ['ID', 'Наименование', 'Количество', 'Цена за единицу(руб.)']
  
  def row(id, name, num, cost)
    row = [id, name, num, cost]
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
    text "Отчет-список товарно-материальных ценностей на складе на #{Time.now.strftime('%d/%m/%Y')}", :size => 14, :style => :bold, :align => :center
    move_down(20)   
    # выборка записей
    data = [ ]
    number_of_goods = 0
    cost_of_all_goods = 0
    goods = @hotelsupplies.each do |good|
      data << row(good.id, good.name, good.num, good.cost)
      number_of_goods += good.num
      cost_of_all_goods += good.cost * good.num
    end
    
    head = make_table([Headers], :column_widths => Widths)
    table([[head], *(data.map{|d| [d]})], :header => true, :row_colors => %w[cccccc ffffff]) do
      row(0).style :background_color => '000000', :text_color => 'ffffff'
      cells.style :borders => []
    end
    table([["Итого: #{number_of_goods} единиц товара, на общую сумму #{cost_of_all_goods} рублей"]], :width => 540)
    # добавим время создания внизу страницы
    creation_date = Time.now.strftime("Отчет сгенерирован %e.%m.%Y в %H:%M")
    go_to_page(page_count)
    move_down(710)
    text creation_date, :align => :right, :style => :italic, :size => 9
    
  end
  
end