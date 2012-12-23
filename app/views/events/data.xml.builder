xml.instruct! :xml, :version=>"1.0"

xml.data do
  @events.each do |e|
    xml.event do
      xml.id e.id
      xml.text e.name
      xml.start_date e.start_date.strftime("%Y-%m-%d %H:%M:%S")
      xml.end_date e.end_date.strftime("%Y-%m-%d %H:%M:%S")
    end
  end
end