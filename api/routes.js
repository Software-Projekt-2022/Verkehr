const express = require('express')
const path = require('path');
const app = express();
const mysql = require("mysql");

const mysql_connection = mysql.createConnection({
    host: 'verkehrdb',
    user: 'root',
    password: '',
    database: 'verkehr'
});

const router = express.Router();

//const validURL = "https://auth.cyber-city.systems/api";
//const sendToLogin = "https://cyber-city.systems/login?target=https://cyber-city.systems/";

const Auth = async (req,res,next) => {
    /*/ TOKEN CHECK
    var cookie = req.headers.cookie;
    if(cookie != null){
        const config = {
            headers: {
                'Authorization': cookie
            }
        };
        const https = require('https');
        try {
            await https.request(`${validURL}/validate_token`, config).then((data) => {
                if(data.status == 200){ */
                next();
                /*} else {res.redirect(sendToLogin)};
            })
        }
        catch (err){
            console.log(err);
            res.redirect(sendToLogin);
        }
    } else {res.redirect(sendToLogin);
    };*/
}




router.get('/', Auth , (req,res) =>{
    res.sendFile(path.join(__dirname+'/../assets/html/index.html'));
});





module.exports = router;