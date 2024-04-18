const express = require('express');
const app = express();

app.get('/', function (req, res) {
    res.send(`
        <!DOCTYPE html>
        <html>
            <head>
                <title>This is the Way v1</title>
            </head>
            <body style="background-color: blue; color: white; padding: 20px;">
                <h1 style="font-size: 60px;">This is the way! v1</h1>
            </body>
        </html>
    `);
});

app.listen(3000, () => {
    console.log('Server is running on port 3000');
});