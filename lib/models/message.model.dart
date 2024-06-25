import 'package:proyecto_sw1/models/transalated_text.model.dart';

class Message {
  final int id;
  final int chatId;
  final int userId;
  final int type;
  final String sentAt;
  final TranslatedTex translatedText;


  Message({
    required this.id,
    required this.chatId,
    required this.userId,
    required this.type,
    required this.sentAt,
    required this.translatedText,
    
  });

  factory Message.fromJson(Map<String, dynamic> json) {
    return Message(
      id: json['id'],
      chatId: json['chat_id'],
      userId: json['user_id'],
      type: json['type'],
      sentAt: json['sent_at'],
      translatedText: TranslatedTex.fromJson(json['translated_text']),
    );
  }

  //function convert hora to string
  String getTime(){
    DateTime date = DateTime.parse(sentAt);
    return "${date.hour}:${date.minute}";
  }
  
}