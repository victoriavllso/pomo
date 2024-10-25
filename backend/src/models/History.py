from config import data_base

class History(data_base.Model):
    __tablename__ = 'history'

    id = data_base.Column(data_base.Integer, primary_key=True)
    user_id = data_base.Column(data_base.Integer, data_base.ForeignKey('users.id'), unique=True, nullable=False)

    user = data_base.relationship('User', back_populates='history')
    modules = data_base.relationship('Module', backref='history', lazy=True, cascade="all, delete-orphan")

    def __init__(self, user_id):
        self.user_id = user_id

    def to_dict(self):
        return {
            'id': self.id,
            'modules': [module.to_dict() for module in self.modules]
        }

    def __hash__(self):
        return hash((self.user.id))
