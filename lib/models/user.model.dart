
import 'package:proyecto_sw1/models/language.model.dart';

class User {
  final int id;
  final String firstName;
  final String lastName;
  final String email;
  final int state;
  final int languageId;
  final String photo;
  final Language language;
  User({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.languageId,
    required this.state,
    required this.photo,
    required this.language,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      firstName: json['first_name'],
      lastName: json['last_name'],
      email: json['email'],
      languageId: json['language_id'],
      state: json['state'],
      photo: json['photo'],
      language: Language.fromJson(json['language']),
    );
  }

  
}