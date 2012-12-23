class EventsController < ApplicationController

  def view
    #empty
  end

  def data
    @events = Event.all
    render :template => 'events/data', :layout => false
  end

  #acts like a 'data_processor' for dhtmlx
  #receive a post with a list of ids/operations/values
  #and process each action accordingly
  def db_action
    ids = get_ids
    ids.each do |id|
      logger.debug "id=#{id}"
      op = get_operation_for(id)
      values = get_values_for(id)
      process_item(id, op, values)
    end
  end

  protected

  def process_item(id, op, values)
    logger.debug "id = #{id} op = #{op} values ==> #{values}"
    case op
      when "inserted"
        e = Event.create(:name => values['text'], :start_date => values['start_date'], :end_date => values['end_date'])
        e.save!
        @tid = e.id

      when "deleted"
        Event.delete(:id => id)
        @tid = id

      when "updated"
        e = Event.find_by_id(id)
        e.update_attributes! values
        @tid = e.id

      else
        raise
    end
  end

  def get_ids
    params['ids'].split
  end

  def get_operation_for(id)
    params["#{id}_!nativeeditor_status"]
  end

  def get_values_for(id)
    hash = {}
    params.keys.select{ |k| k.start_with? "#{id}_" }.each do |k|
      p = k.split('_', 2)[1]
      v = params[k]
      hash[p] = v unless p.start_with? '!' #are there any more values other than !nativeeditor?
    end
    hash
  end


end
