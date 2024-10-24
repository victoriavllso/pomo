from config import data_base

class User(data_base.Model):
    __tablename__ = 'users'

    id = data_base.Column(data_base.Integer, primary_key=True)
    username = data_base.Column(data_base.String(80), nullable=False)
    email = data_base.Column(data_base.String(120), unique=True, nullable=False)
    password = data_base.Column(data_base.String(80), nullable=False)

    def __init__(self, username, email, password):
        self.__username = username
        self.__email = email
        self.__password = password

    def __str__(self):
        return f"User({self.__username}, {self.__password})"

    def __eq__(self, other):
        return self.__username == other.username and self.__password == other.password

    def __hash__(self):
        return hash((self.__username, self.__password))
