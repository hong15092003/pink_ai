import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:pink_ai/config.dart';
// import 'package:google_api_client/google_api_client.dart';
// import 'package:google_vision_api/google_vision_api.dart';

import 'package:pink_ai/controllers/home_controller.dart';
import 'package:pink_ai/models/gemini_chat_model.dart';

class GeminiChatController {

  Map<String, dynamic> body = config.body;

  void generateContent(text) async {
    handleAfterCallAPI(text);
    final response = await http.post(Uri.parse(config.baseUrl),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(body));
    handleBeforeCallAPI(response);
  }

  void addContentBody(String text, String role) {
    body['contents'].add({
      "role": role,
      "parts": [
        {"text": text}
      ]
    });
  }

  void handleAfterCallAPI(text) {
    addContentBody(text, 'user');
  }

  void handleBeforeCallAPI(response) {
    if (response.statusCode == 200) {
      final responseDecode = jsonDecode(response.body);
      ModelResponse modelResponse = ModelResponse.fromJson(responseDecode);
      final content = modelResponse.candidates[0].content.parts[0].text;
      homeController.pushContent(content, 'model');
      addContentBody(content, 'model');
    } else {
      homeController.pushContent('Đã xảy ra lỗi, vui lòng thử lại !', 'model');
    }
  }
}


//{content: {parts: [{text: Trời hôm nay nóng như lửa, nhưng may mà có nụ cười của cậu tỏa sáng như ông mặt trời, giúp tớ xua tan đi cái nóng bức này!}], role: model}

class VisionController {
  String? imageUrl;
  String? question;

  // Khóa API của Google Cloud Vision API

  Future<void> pickImage() async {
    // final pickedFile =
    //     await ImagePicker().pickImage(source: ImageSource.gallery);
    // if (pickedFile != null) {
    //   // Upload hình ảnh lên Google Cloud Storage
    //   final ref =
    //       FirebaseStorage.instance.ref().child('images/${pickedFile.name}');
    //   await ref.putFile(File(pickedFile.path));
    //   imageUrl = await ref.getDownloadURL();
      // print(pickedFile);

      // Gửi yêu cầu đến Google Cloud Vision API
      // final vision = GoogleVisionApi(ApiCredentials(_apiKey));
      // final response = await vision.analyzeImage(
      //   image: AnalyzeImageRequestImage(source: ImageSource(gcsImageUri: _imageUrl)),
      //   features: [
      //     ImageFeature(type: FeatureType.LABEL_DETECTION),
      //   ],
      // );

      // Tạo câu hỏi dựa trên dữ liệu nhận được
      // if (response.labelAnnotations!.isNotEmpty) {
      //   _question = 'Đây là ${response.labelAnnotations!.first.description}?';
      // }
    }
  }


GeminiChatController geminiChat = GeminiChatController();
VisionController vision = VisionController();