class Config{
  String apiKey = "AIzaSyCGujlLQjjpEfid13hvw3wYX3gjbN482M4";
  String baseUrl =
      "https://generativelanguage.googleapis.com/v1beta/models/gemini-1.5-flash-latest:generateContent?key=";
  final Map<String, dynamic> body = {
    "contents": [],
    "generationConfig": {
      "temperature": 1,
      "topK": 10,
      "topP": 1,
      "maxOutputTokens": 2048,
      "stopSequences": []
    },
    "safetySettings": [
      {
        "category": "HARM_CATEGORY_HARASSMENT",
        "threshold": "BLOCK_MEDIUM_AND_ABOVE"
      },
      {
        "category": "HARM_CATEGORY_HATE_SPEECH",
        "threshold": "BLOCK_MEDIUM_AND_ABOVE"
      },
      {
        "category": "HARM_CATEGORY_SEXUALLY_EXPLICIT",
        "threshold": "BLOCK_MEDIUM_AND_ABOVE"
      },
      {
        "category": "HARM_CATEGORY_DANGEROUS_CONTENT",
        "threshold": "BLOCK_MEDIUM_AND_ABOVE"
      }
    ]
  };
  void updateConfig(api, url){
    apiKey = api;
    baseUrl = url;
  }
}