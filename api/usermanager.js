module.exports = function(io,socket,mysql_connection) {

    socket.on('get users', function(callback){
        var sql = "SELECT * FROM testtabelle";
        mysql_connection.query(sql, function(err,result){
            if (!err){
                callback(result);
            } else {
                console.log(err);
            }
        });
    });

    socket.on('delete user', function(userID,callback){
        var sql = "DELETE FROM testtabelle WHERE id=" + mysql_connection.escape(userID);
        mysql_connection.query(sql, function(err,result){
            if (!err){
                callback(true);
            } else {
                console.log(err);
                callback(false);
            }
        });
    });

};