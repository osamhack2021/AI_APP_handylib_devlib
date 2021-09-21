import os
from flask.app import Flask
from flask_mongoengine import MongoEngine
from main.app import app
app.config['MONGODB_SETTIONGS'] = {
    'db':'lib_table',
    'host':'localhost',
    'port':'27017'
}
def db_create():
    db = MongoEngine()
    db.init_app(app)
    return db
class Config(object):
    SECRET_KEY = os.urandom(16)
    DEBUG=False


key = Config.SECRET_KEY