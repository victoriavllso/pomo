from flask import Flask
from flask_sqlalchemy import SQLAlchemy

# Inicializa o banco de dados como uma variável global
data_base = SQLAlchemy()

def create_app():
    app = Flask(__name__)

    # Configurações do banco de dados SQLite
    app.config['SQLALCHEMY_DATABASE_URI'] = 'sqlite:///my_database.db'
    app.config['SQLALCHEMY_TRACK_MODIFICATIONS'] = False

    # Inicializa o banco de dados com o app
    data_base.init_app(app)


    return app
