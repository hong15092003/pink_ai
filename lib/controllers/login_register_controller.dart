import 'package:pink_ai/components/popup/my_popup.dart';
import 'package:pink_ai/controllers/firebase_controller.dart';

class LoginRegisterController {
  void register(context, email, password, confirmPassword) async {
    String status = '';
    status = checkValidate(email, password, confirmPassword: confirmPassword);
    if (status == 'Success') {
      status =
          await authFirebase.createUserWithEmailAndPassword(email, password);
    }
    if (status == 'Success') {
      return;
    } else {
       MyPopup().dialog(context, status);
    }
  }

  void signInWithEmailAndPassword(context, email, password) async {
    String status = '';
    status = checkValidate(email, password, confirmPassword: null);
    if (status == 'Success') {
      status = await authFirebase.signInWithEmailAndPassword(email, password);
    }
    if (status == 'Success') {
      return;
    } else {
      MyPopup().dialog(context, status);
    }
  }

  bool checkComfirmPassword(password, confirmPassword) {
    return password == confirmPassword;
  }

  String checkValidate(email, password, {confirmPassword}) {
    if (email.isEmpty) {
      return 'Vui lòng nhập tên email';
    }
    if (!checkRegexEmail(email)) {
      return 'Email không hợp lệ';
    }
    if (password.isEmpty) {
      return 'Vui lòng nhập mật khẩu';
    }
    if (confirmPassword != null) {
      if (password.length < 8) {
        return 'Mật khẩu phải lớn hơn 8 ký tự';
      }
      if (!checkFormatPassword(password)) {
        return 'Mật khẩu phải chứa ít nhất 1 kí tự đặc biệt, chữ cái viết hoa và số';
      }
      if (confirmPassword.isEmpty) {
        return 'Vui lòng nhập lại mật khẩu';
      }
      if (!checkComfirmPassword(password, confirmPassword)) {
        return 'Mật khẩu không khớp';
      }
    }

    return 'Success';
  }

  bool checkRegexEmail(String email) {
    String pattern = r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$';
    RegExp regExp = RegExp(pattern);
    return regExp.hasMatch(email);
  }

  bool checkFormatPassword(String password) {
    String pattern = r'^(?=.*\d)(?=.*[a-z])(?=.*[A-Z])(?=.*[a-zA-Z]).{8,}$';
    RegExp regExp = RegExp(pattern);
    return regExp.hasMatch(password);
  }

  void signOut() {
    authFirebase.signOut();
  }

 
}

LoginRegisterController loginRegisterController = LoginRegisterController();
