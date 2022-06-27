var socket = io.connect();

const first_panel_vue = new Vue({
    el: "#parktabelle",
    data: {
        parkplaetze: new Array()
    },
    created: function(){
        this.getPlaetze();
    },
    methods: {
        getPlaetze: function(){
            socket.emit('get Plaetze', function(plaetze){
                if(plaetze.Groesse != null){
                    switch(plaetze.Groesse){
                        case 0:
                            plaetze.Groesse = "PKW";
                            break;
                        case 1:
                            plaetze.Groesse = "Motorrad/-roller";
                            break;
                        case 2:
                            plaetze.Groesse = "LKW";
                            break;
                        case 3:
                            plaetze.Groesse = "BUS";
                            break;
                    }
                }
                if(plaetze.P_Status != null){
                    switch(plaetze.P_Status){
                        case 0:
                            plaetze.P_Status = "frei";
                            break;
                        case 1:
                            plaetze.P_Status = "belegt";
                            break;
                        case 2: 
                            plaetze.P_Status = "ausser Betrieb";
                            break;
                    }
                }
                if(plaetze.LadesaeuleID != null){
                    plaetze.LadesaeuleID = "vorhanden";
                    switch(plaetze.L_Status){
                        case 0: 
                            plaetze.L_Status = "frei";
                            break;
                        case 1:
                            plaetze.L_Status = "belegt";
                            break;
                        case 2:
                            plaetze.L_Status = "ausser betrieb";
                            break;
                    }
                }
                first_panel_vue.parkplaetze = plaetze;
            });
        },
    }
})

const second_panel_vue = new Vue({
    el: "#parkhaeuser",
    data: {
        parkhaeuser: new Array()
    },
    created: function(){
        this.getLots();
    },
    methods: {
        getLots: function(){
            socket.emit('get Lots', function(lots){
                second_panel_vue.parkhaeuser = lots;
            });
        },
    }
})