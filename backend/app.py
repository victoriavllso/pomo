from flask import Flask

# Inicializa a aplicação Flask
app = Flask(__name__)

# Define uma rota básica para testar
@app.route('/')
def home():
    return "Hello, Flask!"

# Inicializa o servidor
if __name__ == '__main__':
    app.run(debug=True)