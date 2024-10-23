class User:
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
