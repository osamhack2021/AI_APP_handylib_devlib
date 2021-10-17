import pymongo
from pymongo import MongoClient
from flask_mongoengine import MongoEngine
from mongoengine import StringField,ListField,EmailField,IntField,ImageField,DateField
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
  rank = StringField()
  unit = StringField()
  def to_json(self):
    return {"name": self.name,
    "email": self.email,
    "password": self.password,
    "user_id": self.user_id,
    "like": self.like,
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
  categoryId = IntField()
  categoryName = StringField() # tag
  publisher = StringField()
  customerReviewRank = IntField()
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
  board_number=IntField()
  tag=StringField()
  def to_json(self):
    return {
    "user_id": self.user_id,
    "comment_number":self.comment_number,
    "content":self.content,
    "time_stamp":self.time_stamp,
    "board_number":self.board_number,
    "tag":self.tag
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
class Embook(db.EmbeddedDocument):
  title = StringField()
  isbn = StringField()
  isbn13 = StringField()
  link = StringField()
  author = StringField()
  pubDate = StringField() # publication_date
  description = StringField()
  creator = StringField()
  cover = StringField()
  categoryId = IntField()
  categoryName = StringField() # tag
  publisher = StringField()
  customerReviewRank = IntField()
  state = IntField()
  user_id = StringField()
  score = IntField()
  def to_json(self):
    return {
    "title":self.title,
    "isbn":self.isbn,
    "isbn13":self.isbn13,
    "link": self.link,
    "author": self.author,
    "pubDate": self.pubDate,
    "description": self.description,
    "creator": self.creator,
    "cover": self.cover,
    "categoryId": self.categoryId,
    "categoryName": self.categoryName,
    "publisher": self.publisher,
    "customerReviewRank": self.customerReviewRank,
    "state":self.state,
    "user_id":self.user_id,
    "score":self.score,
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
class Unittest(db.Document):
  name = db.StringField()
  title = db.StringField()
  isbn = db.StringField()
  isbn13 = db.StringField()
  state = db.IntField()
  user_id = db.StringField()
  score = db.IntField()
  def to_json(self):
    return {
    "name":self.name,
    "title":self.title,
    "isbn":self.isbn,
    "isbn13":self.isbn13,
    "state":self.state,
    "user_id":self.user_id,
    "score":self.score,
    }