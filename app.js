const express = require('express');
const router = require('./routes/users.router.js');
const bodyParser = require('body-parser');
const db = require("./configs/seqconfig.js");
const baseAuthentication = require('./routes/auth.js');

const app = express();
app.use(express.json());
app.use("/",router);

app.use(function(req, res, next) {
    res.header("Access-Control-Allow-Origin", "*");
    res.header(
        "Access-Control-Allow-Headers",
        "Origin, X-Requested-With, Content-Type, Accept, x-access-token"
    );
    res.header("Access-Control-Allow-Methods", "GET, POST, OPTIONS, PUT, DELETE");
    res.header("Access-Control-Request-Headers", "x-access-token");
    next();
});


db.sequelize.sync();

const port = process.env.PORT || 3000;

module.exports = app.listen(port, () => {
    console.log(`App Running on Port ${port}`);
});;

module.exports = app;