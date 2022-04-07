from flask import Flask
import sys
import os

app = Flask(__name__)

@app.route("/")
def hello():
    node_name = os.environ.get('NODE_NAME', 'Node name unavailable')
    pod_name = os.environ.get('HOSTNAME', 'Pod name unavailable')
    return f'Hello from {pod_name} on {node_name}'

app.run(host = '0.0.0.0', port = 9090)
