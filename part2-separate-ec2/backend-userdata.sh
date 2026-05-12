#!/bin/bash

apt update -y

########################################
# Install Python
########################################

apt install -y python3-pip

########################################
# Flask App
########################################

mkdir -p /home/ubuntu/flask-app

cat <<EOF > /home/ubuntu/flask-app/app.py
from flask import Flask

app = Flask(__name__)

@app.route('/')
def home():
    return "Backend Flask Running"

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=5000)
EOF

pip3 install flask

cd /home/ubuntu/flask-app

nohup python3 app.py > flask.log 2>&1 &
