# app/routes/user_routes.py

import datetime
import bcrypt
from flask import Blueprint, Response, request, jsonify
from sqlalchemy.exc import IntegrityError
from config import data_base, Config
from .authentication import token_required
from models.User import User
from models.History import History
from werkzeug.security import check_password_hash
import jwt

user_bp = Blueprint('user', __name__)

# ----------------- Rotas para usuários -----------------

@user_bp.route('/register', methods=['POST'])
def register_user():
    if 'name' not in request.form or 'email' not in request.form or 'password' not in request.form or 'profile_image' not in request.files:
        return "Dados inválidos, verifique os campos", 400

    name = request.form['name']
    email = request.form['email']
    password = request.form['password']
    hashed_password = bcrypt.hashpw(password.encode('utf-8'), bcrypt.gensalt())
    profile_image_file = request.files['profile_image']

    # Lê o arquivo como BLOB
    profile_image = profile_image_file.read()  # Mantém como BLOB

    new_user = User(name=name, email=email, password=hashed_password, profile_image=profile_image)
    data_base.session.add(new_user)

    try:
        data_base.session.commit()
    except IntegrityError:
        data_base.session.rollback()
        return jsonify({"error": "Email already in use"}), 400
    except Exception as e:
        data_base.session.rollback()
        print(f"Erro inesperado: {e}")  # Log do erro no console
        return jsonify({"error": "Erro ao criar o usuario. Tente novamente mais tarde."}), 500

    # Criar um novo registro de History
    new_history = History(user_id=new_user.id)  # Presumindo que há um campo user_id em History
    data_base.session.add(new_history)

    try:
        data_base.session.commit()
    except Exception as e:
        data_base.session.rollback()
        print(f"Erro ao criar o histórico: {e}")  # Log do erro
        return jsonify({"error": "Erro ao criar o histórico. Tente novamente mais tarde."}), 500

    return jsonify({"message": "Usuário criado com sucesso!"}), 201

@user_bp.route('/user/', methods=['GET'])
@token_required
def get_user_data(current_user=None):
    return jsonify(current_user.to_dict()), 200

@user_bp.route('/user/profile_image', methods=['GET'])
@token_required
def get_profile_image(current_user=None):
    if not current_user.profile_image:
        return jsonify({"error": "Imagem não encontrada"}), 404

    return Response(current_user.profile_image, mimetype='image/jpeg')

@user_bp.route('/users/', methods=['GET'])
@token_required
def get_users_data(current_user=None):

    users = User.query.all()
    return jsonify([user.to_dict() for user in users]), 200

@user_bp.route('/user/', methods=['PUT'])
@token_required
def edit_user_data(current_user=None):
    data = request.form

    if 'name' in data:
        current_user.name = data['name']
    if 'email' in data:
        current_user.email = data['email']
    if 'password' in data:
        current_user.password = bcrypt.hashpw(data['password'].encode('utf-8'), bcrypt.gensalt())
    if 'profile_image' in request.files:  # Adicionando a edição da foto de perfil
        current_user.profile_image = request.files['profile_image']

    try:
        data_base.session.commit()
    except IntegrityError:
        data_base.session.rollback()
        return jsonify({"error": "Email already in use"}), 400
    except Exception as e:
        data_base.session.rollback()
        print(f"Erro inesperado: {e}")  # Log do erro no console
        return jsonify({"error": "Erro ao editar o usuario. Tente novamente mais tarde."}), 500
    
    return "Usuário editado com sucesso", 200

@user_bp.route('/user/', methods=['DELETE'])
@token_required
def delete_user(current_user=None):
    data_base.session.delete(current_user)
    try:
        data_base.session.commit()
    except Exception as e:
        data_base.session.rollback()
        print(f"Erro inesperado: {e}")  # Log do erro no console
        return jsonify({"error": "Erro ao deletar o usuario. Tente novamente mais tarde."}), 500
    
    return "Usuário deletado com sucesso", 200

@user_bp.route('/user/disciplines/', methods=['GET'])
@token_required
def get_disciplines_user(current_user=None):

    # Pega todas as disciplinas associadas ao usuário
    disciplines = current_user.disciplines

    # Retorna as disciplinas no formato JSON
    return jsonify([discipline.to_dict() for discipline in disciplines]), 200

@user_bp.route('/user/history/', methods=['GET'])
@token_required
def get_history_user(current_user=None):
    # Pega todas as disciplinas associadas ao usuário
    history = current_user.history

    # Retorna as disciplinas no formato JSON
    return jsonify(history.to_dict()), 200

@user_bp.route('/login', methods=['POST'])
def login():
    data = request.get_json()
    if not data or 'email' not in data or 'password' not in data:
        return jsonify({"error": "Dados inválidos, 'email' e 'password' são obrigatórios."}), 400

    user = User.query.filter_by(email=data['email']).first()
    if user and bcrypt.hashpw(data["password"].encode("utf-8"), user.password) == user.password:
        # Criar o token JWT
        token = jwt.encode({
            'user_id': user.id,
            'exp': datetime.datetime.utcnow() + datetime.timedelta(hours=1)  # expira em 1 hora
        }, Config.SECRET_KEY.encode('utf-8'), algorithm='HS256')

        return jsonify({"token": token}), 200

    return jsonify({"error": "Credenciais inválidas."}), 401