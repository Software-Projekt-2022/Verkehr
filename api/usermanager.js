module.exports = function(io,socket,mysql_connection) {

    // get Informations example
    socket.on('get users', function(callback){
        var sql = "SELECT * FROM SonderUser";
        mysql_connection.query(sql, function(err,result){
            if (!err){
                callback(result);
            } else {
                console.log(err);
            }
        });
    });
    // delete Information example
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
    // get Informations from Plaetz in Database
    socket.on('get Plaetze', function(callback){
        var sql = "SELECT * FROM Plaetze";
        var platzdata;
        mysql_connection.query(sql, function(err,result){
            if (!err){
                if(result[0].Pl_LadesaeuleID != null){
                    var sql = "SELECT L_Status FROM Ladesaeulen WHERE LadesaeuleID=" + mysql_connection.escape(result[0].Pl_LadesaeuleID);
                    mysql_connection.query(sql, function(err,statres){
                        if (!err){
                            platzdata.push(result);
                            platzdata.push(statres);
                            callback(platzdata);
                        } else {
                            console.log(err);
                            callback(false);
                        } 
                    });
                } else {
                    callback(result);
                }

            } else {
                console.log(err);
                callback(false);
            }
            
        });
    });
    // get Informations from Ladesaeule in Database
    socket.on('get Lots', function(callback){
        var sql = "SELECT * FROM Lots";
        var lotdata;
        mysql_connection.query(sql, function(err,result){
            if (!err){
                if(result[0].Lo_AddresseID != null){
                    var sql = "SELECT * FROM Addressen WHERE AddresseID=" + mysql_connection.escape(result[0].Lo_AddresseID);
                    mysql_connection.query(sql, function(err,statres){
                        if (!err){
                            // Used in upcoming iteration
                            /* if(result[0].LotID != null){
                                var sql = "SELECT P_Status FROM Plaetze INNER JOIN Lot_Plaetze ON Plaetze.PlatzID = Lot_Plaetze.LP_PlatzID INNER JOIN Lots ON Lot_Plaetze.LP_LotID = Lot." +mysql_connection.escape(result[0].LotID);
                                mysql_connection.query(sql, function(err, pdat){
                                    if(!err){
                                        lotdata.push(result);
                                        lotdata.push(statres);
                                        lotdata.push(pdat);
                                        callback(lotdata);
                                    } else {
                                        console.log(err)
                                        callback(false);
                                    }
                                });
                            } else{ */
                            lotdata.push(result);
                            lotdata.push(statres);
                            callback(lotdata);
                            //}
                        } else {
                            console.log(err);
                            callback(false);
                        } 
                    });
                } else {
                    // Used in Upcoming iteration
                    /* if(result[0].LotID != null){
                        var sql = "SELECT P_Status FROM Plaetze INNER JOIN Lot_Plaetze ON Plaetze.PlatzID = Lot_Plaetze.LP_PlatzID INNER JOIN Lots ON Lot_Plaetze.LP_LotID = Lot." +mysql_connection.escape(result[0].LotID);
                        mysql_connection.query(sql, function(err, pdat){
                            if(!err){
                                lotdata.push(result);
                                lotdata.push(pdat);
                                callback(lotdata);
                            } else {
                                console.log(err)
                                callback(false);
                            }
                        });
                        } else{
                            lotdata.push(result);
                            callback(lotdata);
                        } */ 
                    callback(result);
                }
            } else {
                console.log(err);
                callback(false);
            }
            
        });
    });
    // get Informations from Ladesaeule in Database 
    socket.on('get LadesaeleInfo', function(LadesaeuleID,callback){
        var sql = "SELECT L_Status FROM Ladesaeulen WHERE id=" + mysql_connection.escape(LadesaeuleID);
        mysql_connection.query(sql, function(err,result){
            if(!err){
                callback(true);
            } else {
                console.log(err);
                callback(false);
            }
        });
    });

};