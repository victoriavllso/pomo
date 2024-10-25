# app/app.py

from config import data_base, create_app
from routes.user_routes import user_bp
from routes.discipline_routes import discipline_bp
from routes.module_routes import module_bp

# ----------------- Configuração da aplicação Flask -----------------

app = create_app()  # inicia o flask

with app.app_context():
    # data_base.drop_all()  # Apaga as tabelas existentes
    data_base.create_all()  # Cria as tabelas novamente com as novas definições

app.register_blueprint(user_bp)
app.register_blueprint(discipline_bp)
app.register_blueprint(module_bp)

# Inicializa o servidor
if __name__ == '__main__':
    app.run(debug=True)