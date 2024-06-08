// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class ApiConfigModel {
  final String model;
  final String model1;
  final String model2;
  final String version;
  final String apiKey;
  final String headerUrl;
  ApiConfigModel({
    required this.model,
    required this.model1,
    required this.model2,
    required this.version,
    required this.apiKey,
    required this.headerUrl,
  });

  ApiConfigModel copyWith({
    String? model,
    String? model1,
    String? model2,
    String? version,
    String? apiKey,
    String? headerUrl,
  }) {
    return ApiConfigModel(
      model: model ?? this.model,
      model1: model1 ?? this.model1,
      model2: model2 ?? this.model2,
      version: version ?? this.version,
      apiKey: apiKey ?? this.apiKey,
      headerUrl: headerUrl ?? this.headerUrl,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'model': model,
      'model1': model1,
      'model2': model2,
      'version': version,
      'apiKey': apiKey,
      'headerUrl': headerUrl,
    };
  }

  factory ApiConfigModel.fromMap(Map<String, dynamic> map) {
    return ApiConfigModel(
      model: map['model'] as String,
      model1: map['model1'] as String,
      model2: map['model2'] as String,
      version: map['version'] as String,
      apiKey: map['apiKey'] as String,
      headerUrl: map['headerUrl'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory ApiConfigModel.fromJson(String source) => ApiConfigModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'ApiConfigModel(model: $model, model1: $model1, model2: $model2, version: $version, apiKey: $apiKey, headerUrl: $headerUrl)';
  }

  @override
  bool operator ==(covariant ApiConfigModel other) {
    if (identical(this, other)) return true;
  
    return 
      other.model == model &&
      other.model1 == model1 &&
      other.model2 == model2 &&
      other.version == version &&
      other.apiKey == apiKey &&
      other.headerUrl == headerUrl;
  }

  @override
  int get hashCode {
    return model.hashCode ^
      model1.hashCode ^
      model2.hashCode ^
      version.hashCode ^
      apiKey.hashCode ^
      headerUrl.hashCode;
  }
}
