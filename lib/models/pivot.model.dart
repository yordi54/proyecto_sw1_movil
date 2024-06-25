class Pivot {
  final int userId;
  final int chatId;

  Pivot({
    required this.userId,
    required this.chatId,
  });

  factory Pivot.fromJson(Map<String, dynamic> json) {
    return Pivot(
      userId: json['user_id'],
      chatId: json['chat_id'],
    );
  }
}