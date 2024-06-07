import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:pink_ai/models/chat_detail_model.dart';
import 'package:pink_ai/models/chat_model.dart';

class FirebaseController {
  final _firestore = FirebaseFirestore.instance
      .collection('User')
      .doc(FirebaseAuth.instance.currentUser!.uid)
      .collection('saveChat');

  final _firestoreUser = FirebaseFirestore.instance
      .collection('User')
      .doc(FirebaseAuth.instance.currentUser!.uid);

  void saveProfile(lastName, fistName) {
    _firestoreUser.update(
      {
        'lastName': lastName,
        'fistName': fistName,
      },
    );
  }

  void saveTheme(String theme) {
    _firestoreUser.update(
      {
        'theme': theme,
      },
    );
  }

  Future<String> getName() async {
    String name = '';
    await _firestoreUser.get().then(
      (value) {
        name = value.data()!['fistName'] + ' ' + value.data()!['lastName'];
      },
    );
    return name;
  }

  Future<String> getEmail() async {
    String email = '';
    await _firestoreUser.get().then(
      (value) {
        email = value.data()!['email'];
      },
    );
    return email;
  }

  Future<String> getTheme() async {
    String theme = '';
    _firestoreUser.get().then(
      (value) {
        theme = value.data()!['theme'];
      },
    );
    return theme;
  }

  String idChat = '';

  String formatId(String idChat) {
    String idFormat = idChat.replaceAll(' ', '');
    idFormat = idFormat.replaceAll('-', '');
    idFormat = idFormat.replaceAll(':', '');
    idFormat = idFormat.split('.').first;
    return idFormat;
  }

  createNewChat() {
    idChat = '';
  }

  void saveChat(ChatModel chat) {
    String idChat = formatId(chat.time.toString());
    if (idChat == '') {
      idChat = idChat;
      final chatDetail = ChatDetailModel(
        id: idChat,
        name: chat.text,
        startTime: chat.time,
        endTime: chat.time,
      ).toMap();
      _firestore.doc(idChat).set(chatDetail);
    }
    _firestore.doc(idChat).update({
      'endTime': chat.time,
    });
    _firestore.doc(idChat).collection('chat').doc(idChat).set(chat.toMap());
  }

  void deleteChat(id) {
    _firestore.doc(id).delete();
  }

  Future<List<ChatDetailModel>> getListChat() async {
    List<ChatDetailModel> listChat = [];
    await _firestore.orderBy('endTime', descending: true).get().then(
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
    await _firestore.doc(itemId).collection('chat').get().then(
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
    await _firestore.orderBy('endTime', descending: true).get().then(
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
  final _firestore = FirebaseFirestore.instance.collection('User');

  void saveAuth(String id, String fistName, String lastName, String email) {
    _firestore.doc(id).set({
      'lastName': lastName,
      'fistName': fistName,
      'email': email,
      'theme': ThemeMode.system.toString(),
    });
  }

  Future<String> getAuth(String id) async {
    String name = '';
    await _firestore.doc(id).get().then(
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
    }
    return 'Không thể đăng nhập';
  }

  void signOut() async {
    await FirebaseAuth.instance.signOut();
  }
}

final AuthFirebase authFirebase = AuthFirebase();
FirebaseController firebaseController = FirebaseController();
