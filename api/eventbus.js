const express = require('express')
const path = require('path');
const app = express();
const mysql = require("mysql");
const mysql_connection = mysql.createConnection({
    host: 'verkehrdb:3306',
    user: 'root',
    password: '',
    database: 'verkehr'
});

const ampq = require('ampqlib/callback_api');

const microservice_name = 'microservice.verkehr';
const microservice_prefix = 'VER-';
const microservice_exchange = 'publish_event.verkehr';
const microservice_queue = 'microservice.verkehr';

amqp.connect('amqp://localhost', (err, connection) =>
{
    if (err) throw err

    /* Verbindung kann hier genutzt werden */
});

connection.createChannel((err, channel) =>
{
    if (err) throw err
    
    /* Channel kann hier genutzt werden */
});

function makeEvent()
{
    return {
        event_id: microservice_prefix + Date.now(),
        event_type: "admin_message_broadcast",
        event_origin: microservice_name,
        event_time: new Date().toISOString(),
        content:
        {
            message: "Das ist eine Nachricht vom Admin :)"
        }
    }
};

var event = makeEvent()
var msg = JSON.stringify(event)

channel.publish(microservice_exchange, event.event_type, Buffer.from(msg))

channel.consume(microservice_queue, msg =>
{
    /* Hier können Events empfangen werden */
    if(msg.content)
    {
        console.log('Event received: "%s"', msg.content.toString())
    }
},
{
    //Wichtig: automatisches Acknowledgement
    noAck: true
});


