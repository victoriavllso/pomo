# app/routes/discipline_routes.py

from sqlite3 import IntegrityError
from flask import Blueprint, request, jsonify
from models.Discipline import Discipline
from .authentication import token_required
from config import data_base
from models.User import User

discipline_bp = Blueprint('discipline', __name__)

# ----------------- Rotas para disciplinas -----------------

@discipline_bp.route('/new/discipline', methods=['POST'])
@token_required
def create_discipline(current_user=None):
    data = request.get_json()

    # Verifica se os dados obrigatórios foram enviados
    if not data or 'name' not in data:
        return jsonify({"error": "Dados inválidos, 'name' obrigatório"}), 400

    # Cria uma nova disciplina relacionada ao usuário
    new_discipline = Discipline(name=data['name'], user_id=current_user.id)

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
@token_required
def edit_discipline(id, current_user=None):
    discipline = Discipline.query.get(id)
    if not discipline or discipline not in current_user.disciplines:
        return "Disciplina não encontrada", 404
    data = request.get_json()
    if 'name' not in data:
        return jsonify({"error": "Dados inválidos, 'name' obrigatório."}), 400
    discipline.name = data['name']

    data_base.session.commit()
    return "Disciplina editada com sucesso", 200

@discipline_bp.route('/discipline/<int:id>', methods=['DELETE'])
@token_required
def delete_discipline(id, current_user=None):
    discipline = Discipline.query.get(id)
    if not discipline or discipline not in current_user.disciplines:
        return "Disciplina não encontrada", 404
    data_base.session.delete(discipline)
    try:
        data_base.session.commit()
    except Exception as e:
        data_base.session.rollback()
        return jsonify({"error": str(e)}), 500
    
    return "Disciplina deletada com sucesso", 200