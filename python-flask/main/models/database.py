from flask_mongoengine import MongoEngine
from mongoengine import StringField,ListField,EmailField,IntField,ImageField,FloatField
from ..app import app
db = MongoEngine()
db.init_app(app)

class User(db.Document):
  # objectid(고유번호) = auto_create or insert
  name = StringField()
  user_id = StringField()
  email = EmailField()
  password = StringField()
  interest_tag = ListField()
  like = ListField()
  borrowed = ListField()
  def to_json(self):
    return {"name": self.name,
    "email": self.email,
    "password": self.password,
    "user_id": self.user_id,
    "interest_tag": self.interest_tag,
    "like": self.like,
    "borrowed": self.borrowed}
class Book(db.Document):
  # objectid(고유번호) = auto_create or insert
  isbn = IntField()
  title = StringField()
  publication_date  = StringField() # API: 20200924 년월일까지 받아짐
  tag = ListField()
  def to_json(self):
    return {"isbn": self.isbn,
    "title": self.title,
    "publication_date": self.publication_date,
    "tag": self.tag,}

class Ebook(db.Document):
  # objectid(고유번호) = auto_create or insert
  isbn = IntField()
  title = StringField()
  publication_date  = StringField() # API: 20200924 년월일까지 받아짐
  contents = ImageField() # Filefiled() or Imagefiled()
  tag = ListField()
  def to_json(self):
    return {"isbn": self.isbn,
    "title": self.title,
    "publication_date": self.publication_date,
    "tag": self.tag,
    "contents":self.contents}
class Review(db.Document):
  # objectid(고유번호) = auto_create or insert
  user_id = StringField()
  isbn = IntField()
  score = FloatField() # min:0 max:5 interval: 0.1
  def to_json(self):
    return {"user_id": self.user_id,
    "isbn": self.isbn,
    "score": self.score,}
class Notice_board(db.Document):
  # objectid(고유번호) = auto_create or insert
  number = IntField()
  user_id = StringField()
  title = StringField()
  comment_number = ListField()
  content = StringField() 
  tag = StringField()
  def to_json(self):
    return {"number": self.number,
    "user_id": self.user_id,
    "title": self.title,
    "comment_number":self.comment_number,
    "content":self.content,
    "tag":self.tag
    }
class Comment(db.Document):
  # objectid(고유번호) = auto_create or insert
  comment_number = IntField()
  user_id = StringField()
  content = StringField()
  def to_json(self):
    return {
    "user_id": self.user_id,
    "comment_number":self.comment_number,
    "content":self.content,
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
