var microservice_name = 'microservice.verkehr';
var microservice_prefix = 'VER-';
var microservice_exchange = 'publish_event.verkehr';
var microservice_queue = 'microservice.verkehr';

/**
 * Wraps event so it can be published to the exchange. 
 * @returns wrapped event
 */
function wrapper(event_type)
{
    return {
        event_id: microservice_prefix + Date.now(),
        event_type: event_type,
        event_origin: microservice_name,
        event_time: new Date().toISOString(),
        content: {}
    };
}

/**
 * Wraps event so it can be published to the exchange, with content.
 * @param {*} event_type 
 * @param {*} content 
 * @returns wrapped event
 */
function wrapperWithContent(event_type, content)
{
    var event = wrapper(event_type);
    event.content = content;
    return event;
}

/**
 * Builds admin message event
 * @param {*} msg 
 * @returns event
 */
function adminMessageBroadcastEvent(msg)
{
    return wrapperWithContent("admin_message_broadcast",
    {
        message: msg
    });
}

/**
 * Builds microservice specific event
 * @param {*} msg 
 * @param {*} type 
 * @param {*} level 
 * @returns event
 */
function trafficCrashWarningEvent(msg, type, level)
{
    return wrapperWithContent("traffic_crash_warning_issued",
    {
        message: msg,
        pollution_type: type,
        pollution_level: level
    });
}

module.exports.adminMessageBroadcastEvent = adminMessageBroadcastEvent;
module.exports.airQualityWarningEvent = airQualityWarningEvent;