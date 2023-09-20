const express = require('express');
const router = express.Router();

const { storage } = require('../cloudinary');
const multer = require('multer');
const upload = multer({ storage });

router.post('/upload', upload.single('image'), (req, res) => {
    console.log(req.file);
    res.send('Done');
});

module.exports = router;
