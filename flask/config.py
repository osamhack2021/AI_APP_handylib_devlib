from logging import DEBUG
import os

from flask_mongoengine import MongoEngine
from main import create_app
app= create_app()

app.config['MONGODB_SETTIONGS'] = {
    'db':'lib_table',
    'host':'localhost',
    'port':'27017'
}
db = MongoEngine()
db.init_app(app)
class Config(object):
    SECRET_KEY = os.urandom(16)
    DEBUG=False


key = Config.SECRET_KEY