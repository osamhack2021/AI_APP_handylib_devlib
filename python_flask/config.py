import os
from main.app import app
from datetime import timedelta

app.config['PERMANENT_SESSION_LIFETIME']=timedelta(minutes=30)
class Config(object):
    SECRET_KEY = os.urandom(16)
    DEBUG=False


key = Config.SECRET_KEY
app.config['SECRET_KEY']=key