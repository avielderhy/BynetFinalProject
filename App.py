from flask import Flask

app = Flask(__name__)

@app.route('/')
def index():
    return 'The App is up :)'

app.run(host='0.0.0.0', port=81)