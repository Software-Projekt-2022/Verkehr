module.exports = function(io,socket,mariadb_connection) {

    // get Informations example
    socket.on('get users', function(callback){
        var sql = "SELECT * FROM SonderUser";
         mariadb_connection.query(sql, function(err,result){
            if (!err){
                 callback(result);
            } else {
                console.log(err);
            }
        });
    });
    // delete Information example
    socket.on('delete user', function(userID,callback){
        var sql = "DELETE FROM testtabelle WHERE id=" + mariadb_connection.escape(userID);
         mariadb_connection.query(sql, function(err,result){
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
         mariadb_connection.query(sql, function(err,result){
            if (!err){
                if(result[0].Pl_LadesaeuleID != null){
                    var sql = "SELECT L_Status FROM Ladesaeulen WHERE LadesaeuleID=" + mariadb_connection.escape(result[0].Pl_LadesaeuleID);
                     mariadb_connection.query(sql, function(err,statres){
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
         mariadb_connection.query(sql, function(err,result){
            if (!err){
                if(result[0].Lo_AddresseID != null){
                    var sql = "SELECT * FROM Addressen WHERE AddresseID=" + mariadb_connection.escape(result[0].Lo_AddresseID);
                     mariadb_connection.query(sql, function(err,statres){
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
        var sql = "SELECT L_Status FROM Ladesaeulen WHERE id=" + mariadb_connection.escape(LadesaeuleID);
         mariadb_connection.query(sql, function(err,result){
            if(!err){
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
         mariadb_connection.query(sql, function(err,result){
            if (!err){
                if(result[0].Pl_LadesaeuleID != null){
                    var sql = "SELECT L_Status FROM Ladesaeulen WHERE LadesaeuleID=" + mariadb_connection.escape(result[0].Pl_LadesaeuleID);
                     mariadb_connection.query(sql, function(err,statres){
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
    //get Informstions from Neuigkeiten in Database
    socket.on('get News', function(callback){
        var sql = "SELECT * FROM Neuigkeiten";
        var newsdata;
         mariadb_connection.query(sql, function(err,result){
            if (!err){
                if(result[0].Ne_AddresseID != null){
                    var sql = "SELECT * FROM Addressen WHERE AddresseID=" + mariadb_connection.escape(result[0].Ne_AddresseID);
                     mariadb_connection.query(sql, function(err,statres){
                        if (!err){
                             newsdata.push(result);
                             lotdata.push(statres);
                             callback(newsdata);
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

};