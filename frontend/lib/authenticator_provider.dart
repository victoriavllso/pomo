import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:pomo/user.dart';

class AuthProvider extends ChangeNotifier {
  String? _token; // Armazena o token JWT
  User? _user;

  String baseUrl;
  String? get token => _token;
  User? get user => _user;

  AuthProvider({required this.baseUrl});

  Future<String> login({required String email, required String password}) async {
    final url = Uri.parse('$baseUrl/login');
    final body = jsonEncode({
      'email': email,
      'password': password,
    });
    try {
      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
        },
        body: body,
      );
      Map<String, dynamic> data = json.decode(response.body);
      if (response.statusCode == 200) {
        _token = data['token']; // Armazena o token
        notifyListeners(); // Notifica os ouvintes sobre a mudança
        return "Logado com sucesso!";
      } else {
        return data['error'] ?? "Erro ao conectar-se";
      }
    } catch (error) {
      return "Erro ao conectar-se: $error";
    }
  }

  Future<String> getUser() async {
    if (_token == null) {
      return "Erro: usuário não está logado"; // Retorna null se não houver token
    }

    final url = Uri.parse('$baseUrl/user');
    try {
      final response = await http.get(
        url,
        headers: {
          'Authorization': 'Bearer $_token', // Passando o token como Bearer
          'Content-Type': 'application/json',
        },
      );
      Map<String, dynamic> data = json.decode(response.body);
      if (response.statusCode == 200) {
        _user = User.fromJson(data);
        return "success";
      } else {
        return data['error'] ?? "Erro interno, tente mais tarde!";
      }
    } catch (error) {
      return "Erro interno, tente mais tarde!";
    }
  }

  Future<String> register({
    required String name,
    required String email,
    required String password,
    required File profileImage,
    required int hoursDay
  }) async {
    final url = Uri.parse('$baseUrl/register');

    try {
      // Cria uma requisição multipart
      var request = http.MultipartRequest('POST', url);
      request.headers['Content-Type'] = 'multipart/form-data';

      // Adiciona campos ao formulário
      request.fields['email'] = email;
      request.fields['password'] = password;
      request.fields['name'] = name;
      request.fields['hoursDay'] = hoursDay as String;

      // Adiciona a imagem como um arquivo
      request.files.add(await http.MultipartFile.fromPath(
        'profile_image', // Nome do campo que o backend espera
        profileImage.path, // Caminho do arquivo
      ));

      // Envia a requisição
      final response = await request.send();

      // Recebe a resposta
      final responseData = await http.Response.fromStream(response);

      Map<String, dynamic> data = json.decode(responseData.body);

      if (response.statusCode == 200) {
        return 'success'; // Retorna mensagem de sucesso
      } else {
        return data['error'] ?? "Erro ao registrar"; // Retorna erro
      }
    } catch (error) {
      return "Erro ao registrar novo usuário"; // Retorna erro de conexão
    }
  }

  void logout() {
    _token = null; // Limpa o token
    _user = null;
    notifyListeners(); // Notifica os ouvintes sobre a mudança
  }
}