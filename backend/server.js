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
            console.error("Error fetching books:", err);
            res.status(500).send("Error fetching books");
        } else {
            res.json(result);
        }});
});


app.listen(PORT, () => {
    console.log(`Server is running on http://localhost:${PORT}`);
});