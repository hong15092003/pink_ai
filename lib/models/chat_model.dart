// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

class ChatModel {
  String text;
  String role;
  DateTime time;
  ChatModel({
    required this.text,
    required this.role,
    required this.time,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'text': text,
      'role': role,
      'time': time,
    };
  }

  ChatModel copyWith({
    String? text,
    String? role,
    DateTime? time,
  }) {
    return ChatModel(
      text: text ?? this.text,
      role: role ?? this.role,
      time: time ?? this.time,
    );
  }

  factory ChatModel.fromMap(Map<String, dynamic> map) {
    return ChatModel(
      text: map['text'] as String,
      role: map['role'] as String,
      time: (map['time'] as Timestamp).toDate(),
    );
  }

  String toJson() => json.encode(toMap());

  factory ChatModel.fromJson(String source) =>
      ChatModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'ChatModel(text: $text, role: $role, time: $time)';

  @override
  bool operator ==(covariant ChatModel other) {
    if (identical(this, other)) return true;

    return other.text == text && other.role == role && other.time == time;
  }

  @override
  int get hashCode => text.hashCode ^ role.hashCode ^ time.hashCode;
}
