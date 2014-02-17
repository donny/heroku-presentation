from flask import Flask
import requests
import os
from pymongo import MongoClient

app = Flask(__name__)

############# MongoHQ

MONGO_URL = os.environ.get('MONGOHQ_URL')
client = MongoClient(MONGO_URL)

# Get the default database
db = client.get_default_database()

# Get the jokes collection
jokes = db.jokes






@app.route('/joke/<first>/<last>')
def joke(first, last):
    payload = {'firstName': first, 'lastName': last}
    r = requests.get("http://api.icndb.com/jokes/random", params=payload)
    data = r.json()

    joke = data['value']['joke']

    # Save it in MongoDB
    joke_id = jokes.insert(data)

    # Display the joke
    requests.get("http://intu-websocket.herokuapp.com/send/" + joke)

    return joke
