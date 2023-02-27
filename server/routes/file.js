const express = require("express");
const fileRouter = express.Router();
const { Files } = require("../models/file");


fileRouter.post('/api/upload', async (req, res) => {
    try {
        const { name, description, files } = req.body;
        let file = new Files({
            name,
            description, 
            files,
        });
        
        file = await file.save();
        res.json(file);
    }

    catch (e) {
        res.status(500).json({
            error: e.message
        })
    }

});

module.exports = fileRouter;