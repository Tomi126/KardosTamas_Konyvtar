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

app.listen(PORT, () => {
    console.log(`Server is running on http://localhost:${PORT}`);
});