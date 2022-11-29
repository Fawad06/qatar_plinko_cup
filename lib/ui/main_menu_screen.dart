import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qatar_plinko_cup/controllers/main_controller.dart';
import 'package:qatar_plinko_cup/ui/stats_screen.dart';
import 'package:qatar_plinko_cup/ui/teams_screen.dart';

import '../widgets/background_widget.dart';
import '../widgets/coin_widget.dart';

class MainMenuView extends StatelessWidget {
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
                        Navigator.push(
                          context,
                          CupertinoPageRoute(
                            builder: (context) => const TeamsView(),
                          ),
                        );
                      },
                      child: const Text("START GAME"),
                    ),
                    const Spacer(),
                    TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          CupertinoPageRoute(
                            builder: (context) => const StatsView(),
                          ),
                        );
                      },
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
            child: Text(
              "02:59:59",
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ),
          Expanded(child: CoinWidget()),
        ],
      ),
    );
  }
}
