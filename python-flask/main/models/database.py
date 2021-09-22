from flask_mongoengine import MongoEngine
import os, sys
sys.path.append(os.path.dirname(os.path.abspath(os.path.dirname(os.path.abspath(os.path.dirname(__file__))))))
import config
from mongoengine import StringField,ListField,EmailField,IntField,ImageField
from ..app import app
db = MongoEngine()
db.init_app(app)
class User(db.Document):
  # objectid(고유번호) = auto_create or insert
  name = StringField()
  user_id = StringField()
  email = EmailField()
  password = StringField()
  
  interest_tag = StringField()
  like = ListField()
  borrowed = ListField()
class Administrator(db.Document):
  # objectid(고유번호) = auto_create or insert
  name = StringField()
  user_id = StringField()
  password = StringField()
"""
class Book(db.Document):
  # objectid(고유번호) = auto_create or insert
  isbn = IntField()
  title = StringField()
  publication_date  = db.StringField() # API: 20200924 년월일까지 받아짐
  tag = db.ListField()
class Ebook(db.Document):
  # objectid(고유번호) = auto_create or insert
  isbn = db.IntField()
  title = db.StringField()
  publication_date  = db.StringField() # API: 20200924 년월일까지 받아짐
  contents = db.ImageField() # Filefiled() or Imagefiled()
  tag = db.ListField()
class Review(db.Document):
  # objectid(고유번호) = auto_create or insert
  user_id = db.StringField()
  isbn = db.IntField()
  score = db.FloatField() # min:0 max:5 interval: 0.1
class Notice_board(db.Document):
  # objectid(고유번호) = auto_create or insert
  number = db.IntField()
  user_id = db.StringField()
  title = db.StringField()
  comment_number = db.StringField()
  content = db.StringField() # 이미지는?
  tag = db.ListField()
class Comment(db.Document):
  # objectid(고유번호) = auto_create or insert
  comment_number = db.IntField()
  user_id = db.StringField()
  contnet = db.StringField()
class Unit(db.Document):
  # objectid(고유번호) = auto_create or insert
  name = db.StringField()
  books_list = db.ListField()
class Searchlog(db.Document):
  # objectid(고유번호) = auto_create or insert
  user_id = db.StringField()
  log = db.ListField()
"""
