from flask import Flask
import redis
import os
import socket

app = Flask(__name__)
cache = redis.Redis(host=os.getenv('REDIS_HOST', 'redis-service'), port=6379)

@app.route('/')
def hello():
    count = cache.incr('hits')
    host = socket.gethostname()
    return f"Hello! This site has been viewed {count} times. Served from pod: {host}\n"

if __name__ == "__main__":
    app.run(host="0.0.0.0", port=5000)