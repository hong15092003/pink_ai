import 'package:flutter/material.dart';
import 'package:pink_ai/components/button/icon_button.dart';
import 'package:pink_ai/components/button/text_button.dart';
import 'package:pink_ai/components/text_filed/text_box.dart';
import 'package:pink_ai/controllers/history_controller.dart';

import 'package:pink_ai/views/history_view.dart';
import 'package:pink_ai/views/settings_view.dart';

class DrawerView extends StatefulWidget {
  const DrawerView({super.key});

  @override
  State<DrawerView> createState() => _DrawerViewState();
}

class _DrawerViewState extends State<DrawerView> {
  final ValueNotifier<bool> _showBottomSheet = ValueNotifier(false);
  ValueNotifier<bool> searchOnTap = ValueNotifier(false);
  TextEditingController searchController = TextEditingController();

  /// Show settingview

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: Top(
        context: context,
        display: _showBottomSheet,
      ).view(),
      bottomNavigationBar: const SizedBox(
        height: 20,
      ),
      bottomSheet: BottomSettings(
        context: context,
        display: _showBottomSheet,
      ).view(),
      body: Center(
          child: Stack(
        children: [
          Container(
              margin: const EdgeInsets.only(top: 10, left: 10, right: 10),
              child: Center(
                  child: HistoryView(
                context: context,
              ).view())),
          Align(
            alignment: Alignment.bottomCenter,
            child: Bottom(
              context: context,
            ).view(searchOnTap, searchController),
          ),
        ],
      )),
    );
  }
}

class Top {
  final BuildContext context;
  final ValueNotifier<bool> display;

  Top({required this.context, required this.display});
  AppBar view() {
    return AppBar(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      leading: ButtonIcon(
        context: context,
        icon: Icons.person_rounded,
        onPressed: () {
          display.value = !display.value;
        },
      ).noBorder(),
      title: ValueListenableBuilder(
          valueListenable: display,
          builder: (context, value, child) {
            return ButtonText(
              context: context,
              text: value ? 'settings' : 'history',
              onPressed: () {
                display.value = !display.value;
              },
            ).circle();
          }),
      actions: [
        ButtonIcon(
          context: context,
          icon: Icons.arrow_forward_ios_rounded,
          onPressed: () {
            Scaffold.of(context).openEndDrawer();
          },
        ).noBorder(),
      ],
    );
  }
}

class Bottom {
  final BuildContext context;
  Bottom({
    required this.context,
  });

  Widget view(onTap, searchController) {
    return Container(
      padding: const EdgeInsets.only(left: 10, right: 10, top: 10, bottom: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Expanded(
            child: TextBox(
              onTap: onTap,
              context: context,
              textEditingController: searchController,
              onChanged: (_){
                historyController.searchChat(_);
              },
              suffix: ButtonIcon(
                  context: context,
                  icon: Icons.search_rounded,
                  onPressed: () {
                    historyController.searchChat(searchController.text);
                  }).circleBorder(),
            ).chat(),
          ),
        ],
      ),
    );
  }
}

class BottomSettings {
  BuildContext context;
  final ValueNotifier<bool> display;
  BottomSettings({required this.context, required this.display});
  Widget view() {
    return ValueListenableBuilder(
      valueListenable: display,
      builder: (context, value, child) {
        return Container(
          color: Theme.of(context).scaffoldBackgroundColor,
          child: AnimatedSwitcher(
            duration: const Duration(milliseconds: 400),
            transitionBuilder: (Widget child, Animation<double> animation) {
              return ScaleTransition(scale: animation, child: child);
            },
            child: display.value
                ? SettingsView(display: display, key: const ValueKey(1))
                : const SizedBox(),
          ),
        );
      },
    );
  }
}
