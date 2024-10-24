from config import data_base
class Module(data_base.Model):
    __tablename__ = 'modules'
    id = data_base.Column(data_base.Integer, primary_key=True)
    id_subject = data_base.Column(data_base.Integer, nullable=False)
    start_time = data_base.Column(data_base.Time, nullable=False)
    end_time = data_base.Column(data_base.Time, nullable=False)
    start_date = data_base.Column(data_base.Date, nullable=False)
    end_date = data_base.Column(data_base.Date, nullable=False)


    def __init__(self, id_subject, start_time, end_time, start_date, end_date):
        self.id_subject = id_subject
        self.start_time = start_time
        self.end_time = end_time
        self.start_date = start_date
        self.end_date = end_date

    
    def __hash__(self):
        return hash(self.id_subject)