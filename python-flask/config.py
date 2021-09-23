import os
from flask.app import Flask
from flask_mongoengine import MongoEngine
from main.app import app
from datetime import timedelta
database_name = "API_test"
uri  = "mongodb+srv://DevLib_Backend1:OSAMHackathonDevLibBackend1@cluster0.5ublg.mongodb.net/{}?retryWrites=true&w=majority".format(database_name) # 몽고db커넥트url 넣으면 되요
app.config["MONGODB_HOST"] = uri
app.config['PERMANENT_SESSION_LIFETIME']=timedelta(minutes=30)
class Config(object):
    SECRET_KEY = os.urandom(16)
    DEBUG=False


key = Config.SECRET_KEY
app.config['SECRET_KEY']=key