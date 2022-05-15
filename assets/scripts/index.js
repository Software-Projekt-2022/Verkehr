var socket = io.connect();

const first_panel_vue = new Vue({
    el: "#firstpanel",
    data: {
        benutzer: new Array()
    },
    created: function(){
        this.getUsers();
    },
    methods: {
        getUsers: function(){
            socket.emit('get users', function(users){
                first_panel_vue.benutzer = users;
            });
        },
        deleteUser: function(id){
            socket.emit('delete user', id, function(callback){
                if (callback == true){
                    first_panel_vue.getUsers(); 
                }
            });
        }
    }
})