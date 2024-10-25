# app/routes/module_routes.py

from flask import Blueprint, request, jsonify
from models import History
from models.Discipline import Discipline
from models.Module import Module
from src.config import data_base

module_bp = Blueprint('module', __name__)

# ----------------- Rotas para módulos -----------------

@module_bp.route('/modules', methods=['POST'])
def create_module():
    data = request.get_json()

    # Verifica se os dados necessários estão presentes na requisição
    if not data or 'discipline_id' not in data or 'start_time' not in data or 'end_time' not in data:
        return jsonify({"error": "Dados inválidos. Verifique os campos necessários."}), 400

    # Busca a disciplina pelo ID para associar ao módulo
    discipline = Discipline.query.get(data['discipline_id'])
    if not discipline:
        return jsonify({"error": "Disciplina não encontrada."}), 404
    
    history = History.query.get(data['history_id'])
    if not history:
        return jsonify({"error": "History não encontrado."}), 404

    # Criação do novo módulo
    new_module = Module(
        discipline_id=discipline.id,
        history_id=history.id,
        start_time=data['start_time'],
        end_time=data['end_time'],
        start_date=data.get('start_date'),
        end_date=data.get('end_date')
    )

    # Adiciona o novo módulo ao banco de dados
    try:
        data_base.session.add(new_module)
        data_base.session.commit()
        return jsonify({"message": "Módulo criado com sucesso!", "module": new_module.to_dict()}), 201
    except Exception as e:
        data_base.session.rollback()
        return jsonify({"error": str(e)}), 500

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