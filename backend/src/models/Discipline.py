from config import data_base

class Discipline(data_base.Model):
    __tablename__ = 'disciplines'

    id = data_base.Column(data_base.Integer, primary_key=True)
    name = data_base.Column(data_base.String(80), nullable=False)
    user_id = data_base.Column(data_base.Integer, data_base.ForeignKey('users.id'), nullable=False)

    modules = data_base.relationship('Module', back_populates='discipline', cascade="all, delete-orphan")
    
    def __init__(self, name, user_id):
        self.name = name
        self.user_id = user_id

    def __hash__(self):
        return hash(self.id)
    
    # Método para serializar o objeto Discipline
    def to_dict(self):
        return {
            'id': self.id,
            'user_id': self.user_id,
            'name': self.name
        }