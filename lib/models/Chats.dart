class Chats {
  final String chatId;
  final String chatName;
  final String chatType;

  Chats({
    required this.chatId,
    required this.chatName,
    required this.chatType,
  });

  factory Chats.fromJson(Map<String, dynamic> json) {
    return Chats(
      chatId: json['chatId'],
      chatName: json['chatName'],
      chatType: json['chatType'],
    );
  }
}
