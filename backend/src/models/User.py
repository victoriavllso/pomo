import base64
from config import data_base

class User(data_base.Model):
    __tablename__ = 'users'

    id = data_base.Column(data_base.Integer, primary_key=True)
    name = data_base.Column(data_base.String(80), nullable=False)
    email = data_base.Column(data_base.String(120), unique=True, nullable=False)
    password = data_base.Column(data_base.String(80), nullable=False)
    profile_image = data_base.Column(data_base.LargeBinary, nullable=True)

    disciplines = data_base.relationship('Discipline', backref='user', lazy=True, cascade="all, delete-orphan")
    history = data_base.relationship('History', back_populates='user', uselist=False, cascade="all, delete-orphan")


    def __init__(self, name, email, password, profile_image):
        self.name = name
        self.email = email
        self.password = password
        self.profile_image = profile_image

    # Método para serializar o objeto User
    def to_dict(self):

        return {
            'id': self.id,
            'name': self.name,
            'email': self.email,
            'password': self.password,
            'disciplines': [discipline.to_dict() for discipline in self.disciplines],
            'history': self.history.to_dict(),
        }

    def __str__(self):
        return f"User({self.name}, {self.password})"

    def __eq__(self, other):
        return self.name == other.name and self.password == other.password

    def __hash__(self):
        return hash((self.name, self.password))
