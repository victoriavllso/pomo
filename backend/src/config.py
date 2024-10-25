import os
from flask import Flask
from flask_sqlalchemy import SQLAlchemy

# Inicializa o banco de dados como uma variável global
data_base = SQLAlchemy()

def create_app():
    app = Flask(__name__)

    app.config["UPLOAD_EXTENSIONS"] = [".jpg", ".png"]
    app.config["UPLOAD_PATH"] = "image_uploads"

    app.config['SQLALCHEMY_DATABASE_URI'] = 'sqlite:///my_database.db'
    app.config['SQLALCHEMY_TRACK_MODIFICATIONS'] = False
    app.json.compact = False

    # Inicializa o banco de dados com o app
    data_base.init_app(app)


    return app

class Config:
    SECRET_KEY = os.getenv("SECRET_KEY", "pomoseccom2024#_J23104231")  # use uma chave secreta forte