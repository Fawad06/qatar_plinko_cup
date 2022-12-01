import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qatar_plinko_cup/controllers/main_controller.dart';
import 'package:qatar_plinko_cup/ui/stats_screen.dart';
import 'package:qatar_plinko_cup/ui/teams_screen.dart';

import '../widgets/background_widget.dart';
import '../widgets/coin_widget.dart';

class MainMenuView extends StatelessWidget {
  static const String id = "MainMenuView";

  const MainMenuView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BackgroundWidget(
      child: Scaffold(
        appBar: buildAppBar(context),
        body: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            Expanded(
              flex: 5,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30.0),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    const Spacer(flex: 2),
                    Container(
                      height: 300,
                      alignment: Alignment.center,
                      child: const Text(
                        "QATAR PLINKO CUP",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 80,
                          fontFamily: "JosefinSans",
                          color: Color(0xff2A7EBE),
                          fontStyle: FontStyle.italic,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                    const Spacer(flex: 2),
                    ElevatedButton(
                      onPressed: () {
                        Get.find<MainController>().selectedCountryName.value =
                            "";
                        Get.toNamed(TeamsView.id);
                      },
                      child: const Text("START GAME"),
                    ),
                    const Spacer(),
                    TextButton(
                      onPressed: () => Get.toNamed(StatsView.id),
                      child: Text(
                        "MY STATS",
                        style: TextStyle(
                          color: Colors.grey.shade600,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const Expanded(child: SizedBox.shrink())
          ],
        ),
      ),
    );
  }

  AppBar buildAppBar(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      title: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Expanded(child: SizedBox.shrink()),
          Expanded(
            child: GetX<MainController>(
              builder: (controller) =>
                  controller.awardTimeDifference.value.inSeconds < 0
                      ? Text(
                          formatTime(
                              -controller.awardTimeDifference.value.inSeconds),
                          textAlign: TextAlign.center,
                          style: Theme.of(context).textTheme.bodyMedium,
                        )
                      : GestureDetector(
                          onTap: () {
                            controller.getAward();
                          },
                          child: Container(
                            width: 120,
                            height: 50,
                            alignment: Alignment.center,
                            margin: const EdgeInsets.symmetric(horizontal: 10),
                            decoration: BoxDecoration(
                              boxShadow: const [
                                BoxShadow(
                                  blurRadius: 8,
                                  color: Colors.black,
                                  spreadRadius: 1,
                                ),
                              ],
                              gradient: const LinearGradient(
                                colors: [Colors.teal, Colors.cyan],
                              ),
                              borderRadius: BorderRadius.circular(90),
                            ),
                            child: const Text(
                              "Claim!",
                              style: TextStyle(
                                color: Colors.yellowAccent,
                                shadows: [
                                  Shadow(
                                    offset: Offset(1, 1),
                                    color: Colors.black,
                                    blurRadius: 10,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
            ),
          ),
          const Expanded(child: CoinWidget()),
        ],
      ),
    );
  }

  String formatTime(int seconds) {
    final int hrs = seconds ~/ 3600;
    seconds = seconds % 3600;
    final int min = seconds ~/ 60;
    seconds = seconds % 60;
    return "${hrs.toString().padLeft(2, '0')}:${min.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}";
  }
}
