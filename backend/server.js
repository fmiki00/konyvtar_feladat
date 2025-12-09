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


