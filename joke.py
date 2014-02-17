from flask import Flask
import requests

app = Flask(__name__)

@app.route('/joke/<first>/<last>')
def joke(first, last):
    payload = {'firstName': first, 'lastName': last}
    r = requests.get("http://api.icndb.com/jokes/random", params=payload)
    data = r.json()
    return data['value']['joke']
