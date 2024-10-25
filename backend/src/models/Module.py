from config import data_base

class Module(data_base.Model):
    __tablename__ = 'modules'
    id = data_base.Column(data_base.Integer, primary_key=True)
    discipline_id = data_base.Column(data_base.Integer, data_base.ForeignKey('disciplines.id'), nullable=True)
    history_id = data_base.Column(data_base.Integer, data_base.ForeignKey('history.id'), nullable=False)
    start_time = data_base.Column(data_base.Time, nullable=False)
    end_time = data_base.Column(data_base.Time, nullable=False)
    start_date = data_base.Column(data_base.Date, nullable=False)
    end_date = data_base.Column(data_base.Date, nullable=False)

    discipline = data_base.relationship('Discipline', back_populates='modules')


    def __init__(self, discipline_id, history_id, start_time, end_time, start_date, end_date):
        self.discipline_id = discipline_id
        self.history_id = history_id
        self.start_time = start_time
        self.end_time = end_time
        self.start_date = start_date
        self.end_date = end_date

    
    def __hash__(self):
        return hash(self.id)

    def to_dict(self):
        return {
            'id': self.id,
            'discipline': self.discipline.to_dict(),
            'history_id': self.history_id,
            'start_time': self.start_time.strftime('%H:%M:%S'),
            'end_time': self.end_time.strftime('%H:%M:%S'),
            'start_date': self.start_date.strftime('%Y-%m-%d'),
            'end_date': self.end_date.strftime('%Y-%m-%d')
        }