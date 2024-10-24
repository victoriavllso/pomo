from config import data_base

class Discipline(data_base.Model):
    __tablename__ = 'disciplines'

    id = data_base.Column(data_base.Integer, primary_key=True)
    name = data_base.Column(data_base.String(80), nullable=False)
    
    def __init__(self, name, id):
        self.__name = name
        self.__id = id

    def __str__(self):
        return f"User({self.__name}, {self.__id})"

    def __hash__(self):
        return hash(self.__id)