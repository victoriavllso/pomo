# app/routes/module_routes.py

from datetime import datetime
from sqlite3 import IntegrityError
from flask import Blueprint, request, jsonify
from models.Discipline import Discipline
from .authentication import token_required
from models.Module import Module
from config import data_base

module_bp = Blueprint('module', __name__)

# ----------------- Rotas para módulos -----------------

@module_bp.route('/new/module', methods=['POST'])
@token_required
def create_module(current_user=None):
    data = request.get_json()

    # Verifica se os dados obrigatórios foram enviados
    if not data or 'discipline_id' not in data or 'start_time' not in data or 'start_date' not in data or 'end_time' not in data or 'end_date' not in data:
        return jsonify({"error": "Dados inválidos"}), 400

    # Conversão dos dados de tempo e data
    try:
        start_time = datetime.strptime(data['start_time'], '%H:%M:%S').time()
        end_time = datetime.strptime(data['end_time'], '%H:%M:%S').time()
        start_date = datetime.strptime(data['start_date'], '%Y-%m-%d').date()
        end_date = datetime.strptime(data['end_date'], '%Y-%m-%d').date()
    except ValueError as ve:
        return jsonify({"error": "Formato de data ou hora inválido."}), 400

    # Busca o histórico relacionado ao módulo
    history = current_user.history
    disciplines = current_user.disciplines
    if data['discipline_id'] not in [discipline.id for discipline in disciplines]:
        return jsonify({"error": "discipline_id inválido"}), 400

    # Cria um novo módulo com os dados convertidos
    new_module = Module(
        discipline_id=data['discipline_id'],
        history_id=history.id,
        start_time=start_time,
        end_time=end_time,
        start_date=start_date,
        end_date=end_date
    )

    try:
        # Adiciona o módulo ao banco de dados
        data_base.session.add(new_module)
        data_base.session.commit()
    except IntegrityError:
        data_base.session.rollback()
        return jsonify({"error": "Erro ao criar o módulo, possível conflito de dados."}), 400
    except Exception as e:
        data_base.session.rollback()
        return jsonify({"error": str(e)}), 500

    return jsonify({"message": "Módulo criado com sucesso!"}), 201

@module_bp.route('/module/<int:id>', methods=['PUT'])
@token_required
def edit_module(id, current_user=None):
    # Busca o módulo pelo id
    module = Module.query.get(id)

    # Verifica se o módulo existe
    if not module or module not in current_user.history.modules:
        return jsonify({"error": "Módulo não encontrado"}), 404

    # Pega os dados enviados pelo cliente
    data = request.get_json()

    # Valida e atualiza os campos recebidos
    if 'start_time' in data:
        module.start_time = datetime.strptime(data['start_time'], '%H:%M:%S').time()
    
    if 'end_time' in data:
        module.end_time = datetime.strptime(data['end_time'], '%H:%M:%S').time()
    
    if 'start_date' in data:
        module.start_date = datetime.strptime(data['start_date'], '%Y-%m-%d').date()
    
    if 'end_date' in data:
        module.end_date = datetime.strptime(data['end_date'], '%Y-%m-%d').date()

    if 'discipline_id' in data:
        # Verifica se a disciplina existe antes de associar ao módulo
        discipline = Discipline.query.get(data['discipline_id'])
        if not discipline or discipline not in current_user.disciplines:
            return jsonify({"error": "Disciplina não encontrada"}), 404
        module.discipline_id = data['discipline_id']

    try:
        # Commita as alterações ao banco de dados
        data_base.session.commit()
        return jsonify({"message": "Módulo editado com sucesso"}), 200
    except Exception as e:
        # Em caso de erro, faz rollback na transação
        data_base.session.rollback()
        return jsonify({"error": str(e)}), 500

@module_bp.route('/module/<int:id>', methods=['DELETE'])
@token_required
def delete_module(id, current_user=None):
    # Busca o módulo pelo id
    module = Module.query.get(id)

    # Verifica se o módulo existe
    if not module or module not in current_user.history.modules:
        return jsonify({"error": "Módulo não encontrado"}), 404

    try:
        # Deleta o módulo do banco de dados
        data_base.session.delete(module)
        data_base.session.commit()
        return jsonify({"message": "Módulo deletado com sucesso"}), 200

    except Exception as e:
        # Em caso de erro, faz rollback na transação
        data_base.session.rollback()
        return jsonify({"error": str(e)}), 500