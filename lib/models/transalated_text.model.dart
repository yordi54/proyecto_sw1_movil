class TranslatedTex{
  final int id;
  final int messageId;
  final String content;
  final bool isOriginal;
  final int languageId;


  TranslatedTex({
    required this.id,
    required this.messageId,
    required this.content,
    required this.isOriginal,
    required this.languageId,
  });

  factory TranslatedTex.fromJson(Map<String, dynamic> json) {
    return TranslatedTex(
      id: json['id'],
      messageId: json['message_id'],
      content: json['content'],
      isOriginal: json['is_original'],
      languageId: json['language_id'],
    );
  }


}