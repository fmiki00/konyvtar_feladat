const express = require('express');
const mysql = require('mysql2');
const cors = require('cors');
const { connect } = require('http2');
const app = express();

app.use(cors());
app.use(express.json());

const db = mysql.createConnection({
    host: 'localhost',
    port: 3307,
    user: 'root',
    password: '',
    database: 'fm_konyvtarfeladat'
});

db.connect(err => {
    if (err) {
        console.error('Hiba az adatbazis csatlakozáskor: ' + err);
        return;
    }
    console.log('Sikeres adatbazis csatlakozás.');
});



app.listen(3001, () => {
    console.log('A szerver fut: http://localhost:3001');
});
