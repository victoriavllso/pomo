from config import data_base

class Discipline(data_base.Model):
    __tablename__ = 'disciplines'

    id = data_base.Column(data_base.Integer, primary_key=True)
    name = data_base.Column(data_base.String(80), nullable=False)
    
    def __init__(self, name, id):
        self.name = name
        self.id = id

    def __str__(self):
        return f"User({self.name}, {self.id})"

    def __hash__(self):
        return hash(self.id)