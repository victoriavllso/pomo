# app/routes/discipline_routes.py

from sqlite3 import IntegrityError
from flask import Blueprint, request, jsonify
from models.Discipline import Discipline
from config import data_base
from models.User import User

discipline_bp = Blueprint('discipline', __name__)

# ----------------- Rotas para disciplinas -----------------

@discipline_bp.route('/test', methods=['GET'])
def test_route():
    return jsonify({"message": "Rota de teste funcionando!"}), 200

@discipline_bp.route('/new/discipline', methods=['POST'])
def create_discipline():
    data = request.get_json()

    # Verifica se os dados obrigatórios foram enviados
    if not data or 'name' not in data or 'user_id' not in data:
        return jsonify({"error": "Dados inválidos, 'name' e 'user_id' são obrigatórios."}), 400

    # Busca o usuário relacionado à disciplina
    user = User.query.get(data['user_id'])
    if not user:
        return jsonify({"error": "Usuário não encontrado."}), 404

    # Cria uma nova disciplina relacionada ao usuário
    new_discipline = Discipline(name=data['name'], user_id=user.id)

    try:
        # Adiciona a disciplina e os módulos ao banco de dados
        data_base.session.add(new_discipline)
        data_base.session.commit()
    except IntegrityError:
        data_base.session.rollback()
        return jsonify({"error": "Erro ao criar a disciplina, possível conflito de dados."}), 400
    except Exception as e:
        data_base.session.rollback()
        return jsonify({"error": str(e)}), 500

    return jsonify({"message": "Disciplina criada com sucesso!"}), 201

@discipline_bp.route('/discipline/<int:id>', methods=['PUT'])
def edit_discipline(id):
    discipline = Discipline.query.get(id)
    if not discipline:
        return "Disciplina não encontrada", 404
    data = request.get_json()
    if 'name' not in data:
        return jsonify({"error": "Dados inválidos, 'name' obrigatório."}), 400
    discipline.name = data['name']

    data_base.session.commit()
    return "Disciplina editada com sucesso", 200

@discipline_bp.route('/discipline/<int:id>', methods=['DELETE'])
def delete_discipline(id):
    discipline = Discipline.query.get(id)
    if not discipline:
        return "Disciplina não encontrada", 404
    data_base.session.delete(discipline)
    try:
        data_base.session.commit()
    except Exception as e:
        data_base.session.rollback()
        return jsonify({"error": str(e)}), 500
    
    return "Disciplina deletada com sucesso", 200