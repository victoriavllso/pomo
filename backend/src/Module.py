
class Module:
    def __init__(self, id_subject, start_time, end_time, start_date, end_date):
        self.__id_subject = id_subject
        self.__start_time = start_time
        self.__end_time = end_time
        self.__start_date = start_date
        self.__end_date = end_date

    
    def __hash__(self):
        return hash(self.__id_subject)