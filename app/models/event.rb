class Event < ActiveRecord::Base
  attr_accessible :name, :start_date, :end_date, :id, :text

  def text=(t)
    self.name = t
  end

end
