from flask import request, jsonify

from src.User import User
from src.Discipline import Discipline
from src.Module import Module
from config import data_base, create_app
from jose import jwt

# ----------------- Configuração da aplicação Flask -----------------


app = create_app() # inicia o flask

with app.app_context():
    # data_base.drop_all()  # Apaga as tabelas existentes
    data_base.create_all()  # Cria as tabelas novamente com as novas definições


# ----------------- Rotas para criar, editar, retornar e deletar dados do usuário  -----------------

@app.route('/register', methods=['POST'])
def register_user():
    data = request.get_json()

    if not data or 'username' not in data or 'email' not in data or 'password' not in data:
        return "Dados inválidos, verifique os campos", 400


    new_user = User(username=data['username'], email=data['email'], password=data['password'])
    data_base.session.add(new_user)
    data_base.session.commit()
    return "Usuário criado com sucesso!", 201

@app.route('/users/<int:id>', methods=['GET'])
def get_user_data(id):
    user = User.query.get(id)
    if not user:
        return "Usuário não encontrado", 404
    return jsonify(user.to_dict()), 200

@app.route('/users/<int:id>', methods=['PUT'])
def edit_user_data(id):
    user = User.query.get(id)
    if not user:
        return "Usuário não encontrado", 404
    data = request.get_json()

    if 'username' in data:
        user.username = data['username']
    if 'email' in data:
        user.email = data['email']
    if 'password' in data:
        user.password = data['password']

    data_base.session.commit()
    return "Usuário editado com sucesso", 200

@app.route('/users/<int:id>', methods=['DELETE'])
def delete_user(id):
    user = User.query.get(id)
    if not user:
        return "Usuário não encontrado", 404
    data_base.session.delete(user)
    data_base.session.commit()
    return "Usuário deletado com sucesso", 200

# ----------------- Rotas para criar, editar, retornar e deletar disciplinas  -----------------

@app.route('/disciplines/<int:id>', methods=['GET'])
def get_discipline(id):
    discipline = Discipline.query.get(id)
    if not discipline:
        return "Disciplina não encontrada", 404
    return jsonify(discipline.to_dict()), 200

@app.route('/disciplines', methods=['PUT'])
def edit_discipline(id):
    discipline = Discipline.query.get(id)
    if not discipline:
        return "Disciplina não encontrada", 404
    data = request.get_json()
    discipline.name = data['name']
    data_base.session.commit()
    return "Disciplina editada com sucesso", 200

@app.route('/disciplines', methods=['DELETE'])
def delete_discipline(id):
    discipline = Discipline.query.get(id)
    if not discipline:
        return "Disciplina não encontrada", 404
    data_base.session.delete(discipline)
    data_base.session.commit()
    return "Disciplina deletada"

# ----------------- Rotas para criar, editar, retornar e deletar sessões  -----------------
@app.route('/module', methods=['POST'])
def create_Module():
    data = request.get_json()
    new_Module = Module(id = data['id_subject'], start_time= data['start_time'], end_time=data['end_time'], start_date = data['start_date'], end_date=data['end_date'])
    data_base.session.add(new_Module)
    data_base.session.commit()
    return "Sessão criada com sucesso ", 201

@app.route('/module', methods=['GET'])
def get_Module(id_subject):
    module = Module.query.get(id_subject)
    if not Module:
        return "Sessão não encontrada", 404
    return jsonify(module.to_dict()), 200


@app.route('/module', methods=['PUT'])
def edit_Module(id_subject):
    module = Module.query.get(id_subject)
    if not module:
        return "Sessão não encontrada", 404
    data = request.get_json()

    if 'start_time' in data:
        module.start_time = data['start_time']

    if 'end_time' in data:
        module.end_time = data['end_time']

    if 'start_date' in data:
        module.start_date = data['start_date']

    if 'end_date' in data:
        module.end_date = data['end_date']

    data_base.session.commit()
    return "Sessão editada com sucesso", 200

@app.route('/module', methods=['DELETE'])
def delete_Module(id_subject):
    module = Module.query.get(id_subject)
    if not module:
        return "Sessão não encontrada", 404
    data_base.session.delete(module)
    data_base.session.commit()
    return "Sessão deletada com sucesso", 200

# Inicializa o servidor
if __name__ == '__main__':
    app.run(debug=True)