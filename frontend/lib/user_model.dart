import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'course.dart';
import 'dart:convert';

class UserModel extends ChangeNotifier {
  String _name = '';
  String _iconPath = '';
  int _studyHours = 0;
  List<Course> _courses = [];

  String get name => _name;
  String get iconPath => _iconPath;
  int get studyHours => _studyHours;
  List<Course> get courses => _courses;

  UserModel() {
    _loadUserData();
  }

  void setName(String name) {
    _name = name;
    notifyListeners();
    _saveUserData();
  }

  void setIconPath(String path) {
    _iconPath = path;
    notifyListeners();
    _saveUserData();
  }

  void setStudyHours(int hours) {
    _studyHours = hours;
    notifyListeners();
    _saveUserData();
  }

  void addCourse(Course course) {
    _courses.add(course);
    notifyListeners();
    _saveUserData();
  }

  void removeCourse(Course course) {
    _courses.remove(course);
    notifyListeners();
    _saveUserData();
  }

  // Métodos para salvar e carregar os dados do usuário
  void _saveUserData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    prefs.setString('name', _name);
    prefs.setString('iconPath', _iconPath);
    prefs.setInt('studyHours', _studyHours);

    // Convertendo a lista de cursos para JSON
    List<String> coursesJson =
    _courses.map((course) => json.encode(course.toJson())).toList();
    prefs.setStringList('courses', coursesJson);
  }

  void _loadUserData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    _name = prefs.getString('name') ?? '';
    _iconPath = prefs.getString('iconPath') ?? '';
    _studyHours = prefs.getInt('studyHours') ?? 0;

    // Carregando a lista de cursos
    List<String>? coursesJson = prefs.getStringList('courses');
    if (coursesJson != null) {
      _courses =
          coursesJson.map((course) => Course.fromJson(json.decode(course))).toList();
    }

    notifyListeners();
  }
}