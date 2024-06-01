import 'package:flutter/material.dart';
import 'package:pink_ai/components/home/body.dart';
import 'package:pink_ai/components/home/bottom.dart';
import 'package:pink_ai/controllers/home_controller.dart';
import 'package:pink_ai/models/chat_model.dart';
import 'package:pink_ai/components/logo/text_logo.dart';
import 'package:pink_ai/views/drawer_view.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      drawer: const DrawerView(),
      body: Center(
        child: Stack(
          children: [
            TextLogo(context: context).textLogo(),
            Align(
              alignment: Alignment.center,
              child: StreamBuilder<List<ChatModel>>(
                  stream: homeController.chatListStream,
                  builder: (context, snapshot) {
                    return BodyHome(list: homeController.chatList).view();
                  }),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Bottom(context: context).bar(),
            ),
          ],
        ),
      ),
    );
  }
}
