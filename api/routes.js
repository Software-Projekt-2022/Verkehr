const express = require('express')
const path = require('path');
const app = express();
const mysql = require("mysql");
const mysql_connection = mysql.createConnection({
    host: 'verkehrdb:3306',
    user: 'verkehr',
    password: 'verkehrpw12345',
    database: 'verkehr'
});

const router = express.Router()


const Auth = (req,res,next) => {
    // TOKEN CHECK
    // next() wenn bestanden

    next();
}




router.get('/', Auth , (req,res) =>{
    res.sendFile(path.join(__dirname+'/../assets/html/index.html'));
});





module.exports = router;