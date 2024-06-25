import 'package:proyecto_sw1/models/pivot.model.dart';

class Member {

  final int id;
  final String firstName;
  final String lastName;
  final String email;
  final int state;
  final int languageId;
  final String photo;
  final Pivot pivot;


  Member({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.languageId,
    required this.state,
    required this.photo,
    required this.pivot,
    
  });

  factory Member.fromJson(Map<String, dynamic> json) {
    return Member(
      id: json['id'],
      firstName: json['first_name'],
      lastName: json['last_name'],
      email: json['email'],
      languageId: json['language_id'],
      state: json['state'],
      photo: json['photo'],
      pivot: Pivot.fromJson(json['pivot']),
    );
  }

}