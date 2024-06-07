import 'package:flutter/material.dart';
import 'package:pink_ai/components/button/icon_button.dart';
import 'package:pink_ai/components/button/text_button.dart';
import 'package:pink_ai/components/text_filed/text_box.dart';
import 'package:pink_ai/controllers/login_register_controller.dart';
import 'package:pink_ai/views/register_view.dart';

class LoginView extends StatelessWidget {
  const LoginView({super.key});

  void navigateToRegisterView(BuildContext context) {
    Navigator.of(context).push(PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) =>
          const RegisterView(),
      transitionDuration: const Duration(milliseconds: 500),
      reverseTransitionDuration: const Duration(milliseconds: 500),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        var begin = const Offset(0.0, 1.0);
        var end = Offset.zero;
        var curve = Curves.easeInOut;

        var tween =
            Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

        return SlideTransition(
          position: animation.drive(tween),
          child: child,
        );
      },
    ));
  }

  @override
  Widget build(BuildContext context) {
    final TextEditingController emailAddress = TextEditingController();
    final TextEditingController password = TextEditingController();
    return Scaffold(
      appBar: Top(context: context).view(),
      body: Container(
        alignment: Alignment.center,
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextBox(
              context: context,
              textEditingController: emailAddress,
            ).inputInfo('Email hoặc tên đăng nhập'),
            const SizedBox(height: 16),
            TextBox(
              context: context,
              textEditingController: password,
            ).inputInfo('Mật khẩu', isPassword: true),
            const SizedBox(height: 15),
            Container(
              constraints: const BoxConstraints(maxWidth: 500),
              child: Align(
                alignment: Alignment.centerRight,
                child: ButtonText(
                  context: context,
                  text: 'Quên mật khẩu',
                  onPressed: () {},
                ).noBorder(),
              ),
            ),
            const SizedBox(height: 15),
            ButtonText(
              context: context,
              text: 'Đăng Nhập',
              onPressed: () {
                loginRegisterController.signInWithEmailAndPassword(
                  context,
                  emailAddress.text,
                  password.text,
                );
              },
            ).circle(),
            const SizedBox(height: 30),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Bạn chưa có tài khoản ?',
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                const SizedBox(width: 5),
                ButtonText(
                  context: context,
                  text: 'Đăng Ký',
                  onPressed: () {
                    navigateToRegisterView(context);
                  },
                ).noBorder(),
              ],
            )
          ],
        ),
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
        title: ButtonText(context: context, text: 'Login', onPressed: () {})
            .circle(),
        leading: ThemeChange(context: context).button());
  }
}

class OtherLogin {
  final BuildContext context;

  OtherLogin({required this.context});

  Widget view() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        ButtonText(
          context: context,
          text: 'G',
          onPressed: () {},
        ).circle(),
        ButtonText(
          context: context,
          text: 'F',
          onPressed: () {},
        ).circle(),
        ButtonText(
          context: context,
          text: 'I',
          onPressed: () {},
        ).circle(),
      ],
    );
  }
}
