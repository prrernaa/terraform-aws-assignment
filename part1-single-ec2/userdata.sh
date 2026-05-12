#!/bin/bash

apt update -y

########################################
# Install Python
########################################

apt install -y python3-pip

########################################
# Install Node.js 18
########################################

curl -fsSL https://deb.nodesource.com/setup_18.x | bash -

apt install -y nodejs

########################################
# Flask App
########################################

mkdir -p /home/ubuntu/flask-app

cat <<EOF > /home/ubuntu/flask-app/app.py
from flask import Flask

app = Flask(__name__)

@app.route('/')
def home():
    return "Flask Backend Running"

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=5000)
EOF

pip3 install flask

cd /home/ubuntu/flask-app
nohup python3 app.py > flask.log 2>&1 &

########################################
# Express App
########################################

mkdir -p /home/ubuntu/express-app

cat <<EOF > /home/ubuntu/express-app/server.js
const express = require('express');
const app = express();

app.get('/', (req, res) => {
    res.send('Express Frontend Running');
});

app.listen(3000, '0.0.0.0', () => {
    console.log('Express server running');
});
EOF

cd /home/ubuntu/express-app

npm init -y
npm install express

nohup node server.js > express.log 2>&1 &
