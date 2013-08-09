# coding: utf-8
class TaxirequestPdf < Prawn::Document
  def initialize(taxirequests, view)
    super()
    @all_taxirequests = taxirequests
    @view = view
    # отрисовать выходной документ
    draw_document
  end
  
  def draw_document
    # привязываем шрифты
    font_families.update(
      "Verdana" => {
        :bold => "/Users/antonnemtsev/prawn_fonts/verdanab.ttf",
        :italic => "/Users/antonnemtsev/prawn_fonts/verdana.ttf",
        :normal => "/Users/antonnemtsev/prawn_fonts/verdana.ttf"})
    font "Verdana", :size => 12
    text "Отчет о заявках на такси в период с #{(Time.now.to_date-Time.now.to_date.day+1).strftime('%d/%m/%Y')} по #{Time.now.strftime('%d/%m/%Y')}", :size => 14, :style => :bold, :align => :center
    move_down(50)   
    text "Всего заявок на такси в системе - #{@all_taxirequests.count}"
    move_down(10)
    text "Из них:"
    move_down(10)
    table([ ["Обслуженные", "Необслуженные"],[@all_taxirequests.where(:status => 1).count, @all_taxirequests.where(:status => 0).count] ])
    move_down(10)
    text "Гости предпочли оплатить(раз):"
    move_down(10)
    table([ ["Картой", "Наличными"],[@all_taxirequests.where(:payment_method => 'opera').count, @all_taxirequests.where(:payment_method => 'car').count] ])
    move_down(10)
    text "Итого на сегодняшний день выручка по всем обслуженным заявкам на такси составляет - #{@all_taxirequests.where(:status => 1).sum("cost")} рублей", :style => :bold, :align => :center
    move_down(10)
    text "Прогнозируемая сумма выручки - #{@all_taxirequests.sum("cost")} рублей", :align => :center
  end
  
end