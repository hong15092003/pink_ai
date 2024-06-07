class Content {
  String role;
  List<Part> parts;

  Content({required this.role, required this.parts});

  factory Content.fromJson(Map<String, dynamic> json) {
    String role = json['role'];
    List<dynamic> partList = json['parts'];
    List<Part> parts = partList.map((part) => Part.fromJson(part)).toList();
    return Content(role: role, parts: parts);
  }

  Map<String, dynamic> toJson() {
    return {
      'role': role,
      'parts': parts.map((part) => part.toJson()).toList(),
    };
  }
}

class Part {
  String text;

  Part({required this.text});

  factory Part.fromJson(Map<String, dynamic> json) {
    String text = json['text'];
    return Part(text: text);
  }

  Map<String, dynamic> toJson() {
    return {
      'text': text,
    };
  }
}

class ModelRequest {
  List<Content> contents;
  GenerationConfig generationConfig;
  List<SafetySetting> safetySettings;
  ModelRequest({
    required this.contents,
    required this.generationConfig,
    required this.safetySettings,
  });
  Map<String, dynamic> toJson() {
    return {
      'contents': contents.map((content) => content.toJson()).toList(),
      'generationConfig': generationConfig.toJson(),
      'safetySettings':
          safetySettings.map((setting) => setting.toJson()).toList(),
    };
  }

  String dataToString() {
    return toJson().toString();
  }
}

class GenerationConfig {
  double temperature;
  int topK;
  double topP;
  int maxOutputTokens;
  List<String> stopSequences;
  GenerationConfig({
    required this.temperature,
    required this.topK,
    required this.topP,
    required this.maxOutputTokens,
    required this.stopSequences,
  });
  Map<String, dynamic> toJson() {
    return {
      'temperature': temperature,
      'topK': topK,
      'topP': topP,
      'maxOutputTokens': maxOutputTokens,
      'stopSequences': stopSequences,
    };
  }
}

class SafetySetting {
  String category;
  String threshold;
  SafetySetting({required this.category, required this.threshold});
  Map<String, dynamic> toJson() {
    return {
      'category': category,
      'threshold': threshold,
    };
  }
}

// Usage example:

class ModelResponse {
  List<Candidate> candidates;
  UsageMetadata usageMetadata;
  ModelResponse({required this.candidates, required this.usageMetadata});
  factory ModelResponse.fromJson(Map<String, dynamic> json) {
    List<dynamic> candidateList = json['candidates'];
    List<Candidate> candidates = candidateList
        .map((candidate) => Candidate.fromJson(candidate))
        .toList();
    Map<String, dynamic> usageMetadataJson = json['usageMetadata'];
    UsageMetadata usageMetadata = UsageMetadata.fromJson(usageMetadataJson);
    return ModelResponse(candidates: candidates, usageMetadata: usageMetadata);
  }
  Map<String, dynamic> toJson() {
    return {
      'candidates': candidates.map((candidate) => candidate.toJson()).toList(),
      'usageMetadata': usageMetadata.toJson(),
    };
  }
}

class Candidate {
  Content content;
  String finishReason;
  int index;
  List<SafetyRating> safetyRatings;
  Candidate(
      {required this.content,
      required this.finishReason,
      required this.index,
      required this.safetyRatings});
  factory Candidate.fromJson(Map<String, dynamic> json) {
    Map<String, dynamic> contentJson = json['content'];
    Content content = Content.fromJson(contentJson);
    String finishReason = json['finishReason'];
    int index = json['index'];
    List<dynamic> safetyRatingList = json['safetyRatings'];
    List<SafetyRating> safetyRatings = safetyRatingList
        .map((safetyRating) => SafetyRating.fromJson(safetyRating))
        .toList();
    return Candidate(
        content: content,
        finishReason: finishReason,
        index: index,
        safetyRatings: safetyRatings);
  }
  Map<String, dynamic> toJson() {
    return {
      'content': content.toJson(),
      'finishReason': finishReason,
      'index': index,
      'safetyRatings':
          safetyRatings.map((safetyRating) => safetyRating.toJson()).toList(),
    };
  }
}

class SafetyRating {
  String category;
  String probability;
  SafetyRating({required this.category, required this.probability});
  factory SafetyRating.fromJson(Map<String, dynamic> json) {
    String category = json['category'];
    String probability = json['probability'];
    return SafetyRating(category: category, probability: probability);
  }
  Map<String, dynamic> toJson() {
    return {
      'category': category,
      'probability': probability,
    };
  }
}

class UsageMetadata {
  int promptTokenCount;
  int candidatesTokenCount;
  int totalTokenCount;
  UsageMetadata(
      {required this.promptTokenCount,
      required this.candidatesTokenCount,
      required this.totalTokenCount});
  factory UsageMetadata.fromJson(Map<String, dynamic> json) {
    int promptTokenCount = json['promptTokenCount'];
    int candidatesTokenCount = json['candidatesTokenCount'];
    int totalTokenCount = json['totalTokenCount'];
    return UsageMetadata(
        promptTokenCount: promptTokenCount,
        candidatesTokenCount: candidatesTokenCount,
        totalTokenCount: totalTokenCount);
  }
  Map<String, dynamic> toJson() {
    return {
      'promptTokenCount': promptTokenCount,
      'candidatesTokenCount': candidatesTokenCount,
      'totalTokenCount': totalTokenCount,
    };
  }
}
