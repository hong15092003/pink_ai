class ChatModel {
  String text;
  String role;
  ChatModel({required this.text, required this.role});
  toJson() {
    return {
      'text': text,
      'role': role,
    };
  }

  factory ChatModel.fromJson(Map<String, dynamic> json) {
    String text = json['text'];
    String role = json['role'];
    return ChatModel(text: text, role: role);
  }
}

List<ChatModel> chatList = [];