# app/routes/module_routes.py

from datetime import datetime
from sqlite3 import IntegrityError
from flask import Blueprint, request, jsonify
from models.History import History
from models.Discipline import Discipline
from models.Module import Module
from config import data_base

module_bp = Blueprint('module', __name__)

# ----------------- Rotas para módulos -----------------

@module_bp.route('/new/module', methods=['POST'])
def create_module():
    data = request.get_json()

    # Verifica se os dados obrigatórios foram enviados
    if not data or 'history_id' not in data:
        return jsonify({"error": "Dados inválidos, 'history_id' é obrigatório."}), 400

    # Conversão dos dados de tempo e data
    try:
        start_time = datetime.strptime(data['start_time'], '%H:%M:%S').time()
        end_time = datetime.strptime(data['end_time'], '%H:%M:%S').time()
        start_date = datetime.strptime(data['start_date'], '%Y-%m-%d').date()
        end_date = datetime.strptime(data['end_date'], '%Y-%m-%d').date()
    except ValueError as ve:
        return jsonify({"error": "Formato de data ou hora inválido."}), 400

    # Busca o histórico relacionado ao módulo
    history = History.query.get(data['history_id'])
    if not history:
        return jsonify({"error": "Histórico não encontrado."}), 404

    # Cria um novo módulo com os dados convertidos
    new_module = Module(
        discipline_id=data['discipline_id'],
        history_id=data['history_id'],
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
def edit_module(id):
    # Busca o módulo pelo id
    module = Module.query.get(id)

    # Verifica se o módulo existe
    if not module:
        return jsonify({"error": "Módulo não encontrado"}), 404

    # Pega os dados enviados pelo cliente
    data = request.get_json()

    # Valida e atualiza os campos recebidos
    if 'start_time' in data:
        module.start_time = data['start_time']
    
    if 'end_time' in data:
        module.end_time = data['end_time']
    
    if 'start_date' in data:
        module.start_date = data['start_date']
    
    if 'end_date' in data:
        module.end_date = data['end_date']

    if 'discipline_id' in data:
        # Verifica se a disciplina existe antes de associar ao módulo
        discipline = Discipline.query.get(data['discipline_id'])
        if not discipline:
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
def delete_module(id):
    # Busca o módulo pelo id
    module = Module.query.get(id)

    # Verifica se o módulo existe
    if not module:
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