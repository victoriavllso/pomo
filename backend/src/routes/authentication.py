from functools import wraps
from flask import request, jsonify
import jwt
from config import Config
from models.User import User

def token_required(f):
    @wraps(f)
    def decorator(*args, **kwargs):
        token = request.headers.get('Authorization')

        if not token:
            return jsonify({"error": "Token não fornecido."}), 401

        try:
            # Remove o prefixo 'Bearer ' se estiver presente
            if token.startswith('Bearer '):
                token = token.split(' ')[1]
            data = jwt.decode(token, Config.SECRET_KEY, algorithms=['HS256'])
            current_user = User.query.get(data['user_id'])
        except jwt.ExpiredSignatureError:
            return jsonify({"error": "Token expirado."}), 401
        except jwt.InvalidTokenError:
            return jsonify({"error": "Token inválido."}), 401

        # Passa `current_user` como parte de `kwargs`
        return f(*args, current_user=current_user, **kwargs)
    return decorator