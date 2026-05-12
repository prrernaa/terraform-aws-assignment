#!/bin/bash

apt update -y

########################################
# Install Node.js 18
########################################

curl -fsSL https://deb.nodesource.com/setup_18.x | bash -

apt install -y nodejs

########################################
# Express App
########################################

mkdir -p /home/ubuntu/express-app

cat <<EOF > /home/ubuntu/express-app/server.js
const express = require('express');
const app = express();

app.get('/', (req, res) => {
    res.send('Frontend Express Running');
});

app.listen(3000, '0.0.0.0', () => {
    console.log('Frontend server running');
});
EOF

cd /home/ubuntu/express-app

npm init -y
npm install express

nohup node server.js > express.log 2>&1 &
