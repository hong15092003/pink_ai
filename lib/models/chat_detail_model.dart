// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

class ChatDetailModel {
  String id;
  String name;
  DateTime startTime;
  DateTime endTime;
  ChatDetailModel({
    required this.id,
    required this.name,
    required this.startTime,
    required this.endTime,
  });

  ChatDetailModel copyWith({
    String? id,
    String? name,
    DateTime? startTime,
    DateTime? endTime,
  }) {
    return ChatDetailModel(
      id: id ?? this.id,
      name: name ?? this.name,
      startTime: startTime ?? this.startTime,
      endTime: endTime ?? this.endTime,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'startTime': startTime,
      'endTime': endTime,
    };
  }

  factory ChatDetailModel.fromMap(Map<String, dynamic> map) {
    return ChatDetailModel(
      id: map['id'] as String,
      name: map['name'] as String,
      startTime: (map['startTime'] as Timestamp).toDate(),
      endTime: (map['endTime'] as Timestamp).toDate(),
    );
  }

  String toJson() => json.encode(toMap());

  factory ChatDetailModel.fromJson(String source) =>
      ChatDetailModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'ChatDetailModel(id: $id, name: $name, startTime: $startTime, endTime: $endTime)';
  }

  @override
  bool operator ==(covariant ChatDetailModel other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.name == name &&
        other.startTime == startTime &&
        other.endTime == endTime;
  }

  @override
  int get hashCode {
    return id.hashCode ^ name.hashCode ^ startTime.hashCode ^ endTime.hashCode;
  }
}
