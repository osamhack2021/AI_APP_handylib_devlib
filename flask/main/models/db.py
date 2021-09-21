from flask_mongoengine import MongoEngine

db=MongoEngine()

class User(db.Document):
  # objectid(고유번호) = auto_create or insert
  name = db.StringField()
  user_id = db.StringField()
  email = db.EmailField()
  password = db.StringField()
  interest_tag = db.StringField()
  like = db.ListField()
  borrowed = db.ListField()
class Administrator(db.Document):
  # objectid(고유번호) = auto_create or insert
  name = db.StringField()
  user_id = db.StringField()
  password = db.StringField()
class Book(db.Document):
  # objectid(고유번호) = auto_create or insert
  isbn = db.IntField()
  title = db.StringField()
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