import 'package:pomo/session.dart';

class History {
  int id;
  List<Session> sessions;

  History({
    required this.id,
    List<Session>? sessions, // Permite que a lista seja opcional
  }) : sessions = sessions ?? []; // Define uma lista vazia se `sessions` for null

  void addSession(Session session) {
    sessions.add(session); // Acessa diretamente `sessions`
  }

  double completedHours(int courseId) {
    Duration totalDuration = Duration.zero;

    // Filtra e soma as durações das sessões do curso especificado
    for (var session in sessions) {
      if (session.course.id == courseId) {
        totalDuration += session.duration; // Soma a duração da sessão
      }
    }

    // Retorna a duração total em horas como double
    return totalDuration.inMinutes / 60.0; // Converte minutos em horas
  }

  factory History.fromJson(Map<String, dynamic> json) {
    var history = History(id: int.parse(json['id'])); // Inicializa o History com id

    // Verifica se json['sessions'] é uma lista antes de iterar
    if (json['sessions'] != null) {
      for (var sessionJson in json['sessions'] as List<dynamic>) {
        history.addSession(Session.fromJson(sessionJson)); // Adiciona cada Session
      }
    }

    return history; // Retorna a instância de History
  }
}