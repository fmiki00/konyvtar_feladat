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

app.get('/konyvek', (req, res) => {
    const sql = 'SELECT k.KolcsonzesId, k.kolcsonzesIdo, d.diakNeve AS diak_nev, kv.konyvCime AS konyv_cim, sz.szerzoNeve AS szerzo, m.mufajNev AS mufaj FROM Kolcsonzes k JOIN Diak d ON k.diakId = d.diakId JOIN Konyv kv ON k.konyvId = kv.konyvId JOIN Szerzo sz ON kv.szerzoId = sz.szerzoId JOIN Mufaj m ON kv.mufajId = m.mufajId ORDER BY k.kolcsonzesIdo ASC;';
    db.query(sql, (err, results) => {
        if (err) return res.status(500).send(err);
        res.json(results);
    });
});

app.post('/ujkonyv', (req, res) => {
    const konyv = req.body;
    const sql = 'INSERT INTO konyv (konyvId, konyvCime) VALUES (?, ?)';

    db.query(sql, [konyv.konyvId, konyv.konyvCime], (err, result) => {
        if (err) {
            res.status(500).json({ error: 'Hiba az uj konyv hozzaadasakor.' });
        } else {
            res.send('Uj konyv sikeresen hozzaadva.');
        }
    });
});

app.delete('/konyvek/:id', (req, res) => {
    const konyvId = req.params.id;
    const sql = 'DELETE FROM konyvek WHERE id = ?';

    db.query(sql, [konyvId], (err, result) => {
        if (err) return res.status(500).json({ error: 'Hiba a konyv torlese soran.' });
        res.json({ message: 'Konyv sikeresen torolve.' });
    });
});

app.listen(3001, () => {
    console.log('A szerver fut: http://localhost:3001');
});
