jQuery(document).ready(function($) {
    scheduler.config.xml_date="%Y-%m-%d %H:%i:%s";
    scheduler.init('scheduler_here', null, 'month');
    scheduler.load('/events/data.xml')

    var dp = new dataProcessor("/events/db_action.xml");
    dp.init(scheduler);

});
