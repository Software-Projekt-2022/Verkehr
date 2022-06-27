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

const router = express.Router()


const Auth = (req,res,next) => {
    // TOKEN CHECK
    // next() wenn bestanden

    next();
    //else {res.redirect('https://cyber-city.systems/login?target=https://cyber-city.systems/')};
}




router.get('/', Auth , (req,res) =>{
    res.sendFile(path.join(__dirname+'/../assets/html/index.html'));
});





module.exports = router;