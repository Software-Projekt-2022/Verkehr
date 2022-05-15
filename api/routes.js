const express = require('express')
const path = require('path');
const app = express();
const mysql = require("mysql");
const mysql_connection = mysql.createConnection({
    host: 'localhost',
    user: 'root',
    password: '',
    database: 'test123'
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