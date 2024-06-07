import 'package:flutter/material.dart';
import 'package:pink_ai/components/button/icon_button.dart';
import 'package:pink_ai/components/button/text_button.dart';
import 'package:pink_ai/components/text_filed/text_box.dart';
import 'package:pink_ai/controllers/login_register_controller.dart';

class RegisterView extends StatelessWidget {
  const RegisterView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Top(context: context).view(),
      body: Container(
        alignment: Alignment.center,
        padding: const EdgeInsets.all(16),
        child: Body(
          context: context,
        ).view(),
      ),
    );
  }
}

class Top {
  final BuildContext context;

  Top({required this.context});

  AppBar view() {
    return AppBar(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      title: ButtonText(context: context, text: 'Register', onPressed: () {})
          .circle(),
      leading: ThemeChange(context: context).button(),
    );
  }
}

class Body {
  final BuildContext context;
  TextEditingController userName = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController confirmPassword = TextEditingController();

  Body({
    required this.context,
  });

  Widget view() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        TextBox(
          context: context,
          textEditingController: userName,
        ).inputInfoCirlce('Email'),
        const SizedBox(height: 16),
        TextBox(
          context: context,
          textEditingController: password,
        ).inputInfoCirlce(
          'Mật khẩu',
          isPassword: true,
        ),
        const SizedBox(height: 16),
        TextBox(
          context: context,
          textEditingController: confirmPassword,
        ).inputInfoCirlce(
          'Nhập lại mật khẩu',
          isPassword: true,
        ),
        const SizedBox(height: 30),
        ButtonText(
          context: context,
          text: 'Đăng Ký',
          onPressed: () {
            loginRegisterController.register(
                context, userName.text, password.text, confirmPassword.text);
          },
        ).circle(),
        const SizedBox(height: 30),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Bạn đã có tài khoản ?',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            const SizedBox(width: 10),
            ButtonText(
              context: context,
              text: 'Đăng Nhập',
              onPressed: () {
                Navigator.pop(context);
              },
            ).noBorder(),
          ],
        )
      ],
    );
  }
}
