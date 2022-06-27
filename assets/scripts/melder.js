var socket = io.connect();

const eventservice = require('../api/eventservice.js');
const eventfactory = require('../api/eventfactory.js');

const first_panel_vue = new Vue({
    el: "#meldeinfo",
    data: {
        meldeType,
        Hausnummer,
        Strasse,
        Plz,
        Zeitpunkt,
        Beschreibung
    },
    created: function(){
        //this.handleEvent();
    },
    methods: {
        /*handleEvent: function(){
            socket.emit('add News', function(meldeType,Hausnummer,Strasse,Plz,Zeitpunkt,Beschreibung){
                
            });
        },*/
    }
})