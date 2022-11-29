import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qatar_plinko_cup/controllers/main_controller.dart';
import 'package:qatar_plinko_cup/utils/functions.dart';
import 'package:qatar_plinko_cup/widgets/background_widget.dart';
import 'package:qatar_plinko_cup/widgets/team_widget.dart';

import 'game_screen.dart';

class ConfirmView extends StatelessWidget {
  const ConfirmView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BackgroundWidget(
      child: Scaffold(
        appBar: buildAppBar(context, "LETS GO"),
        body: Column(
          children: [
            Expanded(
              flex: 3,
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 30),
                padding: const EdgeInsets.only(left: 20, right: 20, top: 20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(color: const Color(0xff1160B0)),
                ),
                child: GetX<MainController>(builder: (controller) {
                  return Column(
                    children: [
                      TeamWidget(
                        isSelected: false,
                        country: controller.getCurrentCountry,
                      ),
                      const SizedBox(height: 20),
                      Text(
                        "BET: ",
                        style: Theme.of(context).textTheme.displayMedium,
                      ),
                      const SizedBox(height: 20),
                      TextFormField(
                        initialValue: controller.betCoins.text,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontSize: 20,
                          color: Colors.black,
                          fontWeight: FontWeight.w600,
                          fontFamily: "JosefinSans",
                        ),
                        decoration: const InputDecoration(
                          filled: true,
                          enabled: false,
                          fillColor: Colors.white,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.zero,
                            borderSide: BorderSide(
                              color: Colors.black,
                              width: 2,
                            ),
                          ),
                        ),
                      ),
                    ],
                  );
                }),
              ),
            ),
            const Expanded(child: SizedBox.shrink()),
            Expanded(
              child: Center(
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(builder: (_) => GameView()),
                      (route) => false,
                    );
                  },
                  child: const Text("CONFIRM AND START"),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
