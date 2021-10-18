import os
from main.app import app

class Config(object):
    SECRET_KEY = os.urandom(16)
    DEBUG=False


key = Config.SECRET_KEY
app.config['SECRET_KEY']=key