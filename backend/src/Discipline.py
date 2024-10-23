class Discipline:
    def __init__(self, name, id):
        self.__name = name
        self.__id = id

    def __str__(self):
        return f"User({self.__name}, {self.__id})"

    def __hash__(self):
        return hash(self.__id)