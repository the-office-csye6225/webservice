module.exports = app => {
    const users = require("../controllers/app.controller.js");
    var router = require("express").Router();
    // Create a new Tutorial
    router.post("/", users.create);
    app.use('/v1/user', router);
  };