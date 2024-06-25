import 'package:proyecto_sw1/models/member.dart';
import 'package:proyecto_sw1/models/message.model.dart';
import 'package:proyecto_sw1/models/pivot.model.dart';

class Chat {
  final int id;
  final String createdAt;
  final int type;
  final Pivot pivot;
  final List<Member> members;
  final List<Message> messages;
  Message latestMessage;

  Chat({
    required this.id,
    required this.createdAt,
    required this.type,
    required this.pivot,
    required this.members,
    required this.messages,
    required this.latestMessage,
    
  });

  factory Chat.fromJson(Map<String, dynamic> json) {
    return Chat(
      id: json['id'],
      createdAt: json['created_at'],
      type: json['type'],
      pivot: Pivot.fromJson(json['pivot']),
      members: List<Member>.from(json['members'].map((x) => Member.fromJson(x))),
      messages: List<Message>.from(json['messages'].map((x) => Message.fromJson(x))).reversed.toList(),
      latestMessage: Message.fromJson(json['latest_message']),
    );
  }
}