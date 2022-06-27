const express = require('express');
const path = require('path');
const app = express();
const server = require("http").createServer(app);
const io = require("socket.io")(server);

const mariadb = require('mariadb');
const mariadb_connection = mariadb.createConnection({
    host: 'verkehrdb',
    user: 'verkehr',
    password: 'verkehrpw12345',
    database: 'verkehr'
});

// CONNECT TO MariaDB
mariadb_connection.connect(function(error){
    if (!!error){
        console.log("MySQL COULD NOT CONNECT");
        console.log(error);
    } else {
        console.log("MySQL CONNECTED");*/
        // SERVER START
        server.listen(process.env.PORT || 3000, () => {
            console.log("Server started on Port 3000");
            });
        }
});


// ROUTES API REQUIRE
app.use('/assets', express.static('assets')); // STYLE AND SCRIPT ROUTE
const routes_api = require('./api/routes.js');
app.use(routes_api);


const connectedUsers = []

io.on('connection', function(socket){

    console.log("NEUER USER CONNECTED!");
    connectedUsers.push(socket);
    console.log("ANZAHL USER: " + connectedUsers.length);
    socket.on('disconnect', function(){
        var i = connectedUsers.indexOf(socket);
        connectedUsers.splice(i, 1);
        console.log("USER DISCONNECTED")
        console.log("ANZAHL USER: " + connectedUsers.length);
    });


    // MODULES
    require('./api/usermanager.js')(io,socket,mariadb_connection);


});
