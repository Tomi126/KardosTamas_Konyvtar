const express = require('express');
const cors = require('cors');
const mysql = require('mysql2');
const PORT = 3001;
const app = express();

app.use(cors());


const db = mysql.createPool({
    host: 'localhost',
    user: 'root',
    password: '',
    database: 'konyvtar',
    port: 3307
});

app.get("/", (req, res) => {
    res.send("Hello from the server!");
});

app.get("/konyvek", (req, res) => {
    const sql = "SELECT konyv_id, cim, szerzo, mufaj_nev FROM konyv INNER JOIN mufaj ON konyv.mufaj_id = mufaj.mufaj_id;";
    db.query(sql, (err, result) => {
        if (err) {
            res.status(500).send("Hiba a könyvek lekérése során");
        } else {
            res.json(result);
        }});
});

app.post("/ujkonyv", express.json() ,(req, res) => {
    const konyv = req.body;
    const sql = `INSERT INTO konyv (konyv_id, cim, szerzo, mufaj_id) VALUES (?, ?, ?, ?);`;

    db.query(sql, [konyv.konyv_id, konyv.cim, konyv.szerzo, konyv.mufaj_id], (err, result) => {
        if (err) {
            res.status(500).send("Hiba az új könyv hozzáadása során");
        } else {
            res.send("Könyv hozzáadva sikeresen");
        }
    });
});

app.delete("/konyvtorles/:id", (req, res) => {
    const id = req.params.id;
    const sql = "DELETE FROM konyv WHERE konyv_id = ?;";
    db.query(sql, [id], (err, result) => {
        if (err) {
            res.status(500).send("Hiba a könyv törlése során");
        } else {
            res.send("Könyv törölve sikeresen");
        }
    });
});

app.listen(PORT, () => {
    console.log(`Server is running on http://localhost:${PORT}`);
});