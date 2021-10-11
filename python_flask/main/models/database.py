import pymongo
from pymongo import MongoClient
from flask_mongoengine import MongoEngine
from mongoengine import StringField,ListField,EmailField,IntField,ImageField,FloatField,DateField
from ..app import app
database_name = "API_test"
uri  = "mongodb+srv://DevLib_Backend1:OSAMHackathonDevLibBackend1@cluster0.5ublg.mongodb.net/{}?retryWrites=true&w=majority".format(database_name) # 몽고db커넥트url 넣으면 되요
app.config["MONGODB_HOST"] = uri
client = MongoClient( uri )
db = MongoEngine()
db.init_app(app)

class User(db.Document):
  # objectid(고유번호) = auto_create or insert
  name = StringField()
  user_id = StringField()
  email = EmailField()
  password = StringField()
  like = ListField()
  borrowed = ListField()
  rank = StringField()
  unit=StringField()
  def to_json(self):
    return {"name": self.name,
    "email": self.email,
    "password": self.password,
    "user_id": self.user_id,
    "like": self.like,
    "borrowed": self.borrowed,
    "rank":self.rank,
    "unit":self.unit,
    }
class Book(db.Document):
  title = StringField()
  link = StringField()
  author = StringField()
  pubDate = StringField() # publication_date
  description = StringField()
  creator = StringField()
  isbn = StringField()
  isbn13 = StringField()
  cover = StringField()
  categoryId = FloatField()
  categoryName = StringField() # tag
  publisher = StringField()
  customerReviewRank = FloatField()
  def to_json(self):
    return {"title": self.title,
    "link": self.link,
    "author": self.author,
    "pubDate": self.pubDate,
    "description": self.description,
    "creator": self.creator,
    "isbn": self.isbn,
    "isbn13": self.isbn13,
    "cover": self.cover,
    "categoryId": self.categoryId,
    "categoryName": self.categoryName,
    "publisher": self.publisher,
    "customerReviewRank": self.customerReviewRank,}
class Ebook(db.Document):
  # objectid(고유번호) = auto_create or insert
  isbn = IntField()
  title = StringField()
  publication_date  = StringField() # API: 20200924 년월일까지 받아짐
  contents = ImageField() # Filefiled() or Imagefiled()
  tag = StringField()
  def to_json(self):
    return {"isbn": self.isbn,
    "title": self.title,
    "publication_date": self.publication_date,
    "tag": self.tag,
    "contents":self.contents}

class Notice_board(db.Document):
  # objectid(고유번호) = auto_create or insert
  number = IntField()
  user_id = StringField()
  title = StringField()
  comment_list = ListField()
  content = StringField() 
  tag = StringField()
  time_stamp=DateField()
  def to_json(self):
    return {"number": self.number,
    "user_id": self.user_id,
    "title": self.title,
    "comment_list":self.comment_list,
    "content":self.content,
    "tag":self.tag,
    "time_stamp":self.time_stamp
    }
class Comment(db.Document):
  # objectid(고유번호) = auto_create or insert
  comment_number = IntField()
  user_id = StringField()
  content = StringField()
  time_stamp=DateField()
  def to_json(self):
    return {
    "user_id": self.user_id,
    "comment_number":self.comment_number,
    "content":self.content,
    "time_stamp":self.time_stamp
    }
class Unit(db.Document):
  # objectid(고유번호) = auto_create or insert
  name = StringField()
  books_list = ListField()
  def to_json(self):
    return {
    "name":self.name,
    "books_list":self.books_list,
    }
class Searchlog(db.Document):
  # objectid(고유번호) = auto_create or insert
  user_id = StringField()
  log = ListField()
  def to_json(self):
    return {
        "user_id": self.user_id,
        "log": self.log,
    }
