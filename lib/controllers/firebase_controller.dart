
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:pink_ai/config.dart';

import 'package:pink_ai/models/chat_detail_model.dart';
import 'package:pink_ai/models/chat_model.dart';

class FirebaseController {
  String chatId = '';

  void updateName(lastName, fistName) async {
    await config.firestoreUser.update(
      {
        'lastName': lastName,
        'fistName': fistName,
      },
    );
    config.updateName(lastName, fistName);
  }

  void saveTheme(String theme) {
    config.firestoreUser.update(
      {
        'theme': theme,
      },
    );
  }

  void updatePrimaryColor(Color color) {
    
    config.firestoreUser.update(
      {
        'primaryColor': config.colorToHex(color),
      },
    );
  }

  String formatId(String chatId) {
    String idFormat = chatId.replaceAll(' ', '');
    idFormat = idFormat.replaceAll('-', '');
    idFormat = idFormat.replaceAll(':', '');
    idFormat = idFormat.split('.').first;
    return idFormat;
  }

  createNewChat() {
    chatId = '';
  }

  void saveChat(ChatModel chat) {
    String responseId = formatId(chat.time.toString());
    if (chatId == '') {
      chatId = responseId;
      final chatDetail = ChatDetailModel(
        id: chatId,
        name: chat.text,
        startTime: chat.time,
        endTime: chat.time,
      ).toMap();
      config.firestore.doc(chatId).set(chatDetail);
    }
    config.firestore.doc(chatId).update({
      'endTime': chat.time,
    });
    config.firestore.doc(chatId).collection('chat').doc(responseId).set(chat.toMap());
  }

  void deleteChat(chatId) {
    config.firestore.doc(chatId).delete();
  }

  Future<List<ChatDetailModel>> getListChat() async {
    List<ChatDetailModel> listChat = [];
    await config.firestore.orderBy('endTime', descending: true).get().then(
      (value) {
        for (var element in value.docs) {
          listChat.add(
            ChatDetailModel.fromMap(
              element.data(),
            ),
          );
        }
      },
    );
    return listChat;
  }

  Future<List<ChatModel>> getChat(itemId) async {
    List<ChatModel> chatList = [];
    await config.firestore.doc(itemId).collection('chat').get().then(
      (value) {
        for (var element in value.docs) {
          ChatModel chat = ChatModel.fromMap(element.data());
          chatList.add(chat);
        }
      },
    );
    return chatList;
  }

  Future<List<ChatDetailModel>> searchChat(String name) async {
    List<ChatDetailModel> listChat = [];
    await config.firestore.orderBy('endTime', descending: true).get().then(
      (value) {
        for (var element in value.docs) {
          if (element.data()['name'].contains(name)) {
            listChat.add(
              ChatDetailModel.fromMap(
                element.data(),
              ),
            );
          }
        }
      },
    );
    return listChat;
  }
}

// Auth Firebase Controller
class AuthFirebase {
  

  void saveAuth(String userId, String fistName, String lastName, String email) {
    config.firestore.doc(userId).set({
      'userId': userId,
      'lastName': lastName,
      'fistName': fistName,
      'email': email,
      'theme': ThemeMode.system.toString(),
    });
  }

  Future<String> getAuth(String id) async {
    String name = '';
    await config.firestore.doc(id).get().then(
      (value) {
        name = value.data()!['name'];
      },
    );
    return name;
  }

  Future<String> createUserWithEmailAndPassword(email, password) async {
    try {
      final data = await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      saveAuth(data.user!.uid, 'Guest', 'User', email);
      return 'Success';
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        return 'Mật khẩu quá yếu';
      } else if (e.code == 'email-already-in-use') {
        return 'Email đã được sử dụng';
      }
    } catch (e) {
      return 'Không thể tạo tài khoản';
    }
    return 'Không thể tạo tài khoản';
  }

  Future<String> signInWithEmailAndPassword(email, password) async {
    try {
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);

      return 'Success';
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        return 'Không tìm thấy tài khoản';
      } else if (e.code == 'wrong-password') {
        return 'Sai mật khẩu. Vui lòng thử lại';
      }
    } catch (e) {
      debugPrint('Error: $e');
      return 'Đã xảy ra lỗi. Vui lòng thử lại';
    }
    return 'Đã xảy ra lỗi. Vui lòng thử lại';
  }

  void signOut() async {
    await FirebaseAuth.instance.signOut();
  }
}

final AuthFirebase authFirebase = AuthFirebase();
FirebaseController firebaseController = FirebaseController();
