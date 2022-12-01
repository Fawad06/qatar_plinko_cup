import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:qatar_plinko_cup/controllers/main_controller.dart';
import 'package:qatar_plinko_cup/ui/confirm_screen.dart';
import 'package:qatar_plinko_cup/utils/functions.dart';
import 'package:qatar_plinko_cup/widgets/background_widget.dart';

import '../widgets/coin_widget.dart';

class BetView extends StatelessWidget {
  static const String id = "BetView";
  const BetView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BackgroundWidget(
      child: Scaffold(
        appBar: buildAppBar(
          context,
          "BET ON YOUR TEAM",
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30.0),
          child: Column(
            children: [
              Expanded(
                flex: 4,
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "BALANCE: ",
                          style: Theme.of(context).textTheme.displayMedium,
                        ),
                        const SizedBox(width: 20),
                        const CoinWidget(),
                      ],
                    ),
                    const Spacer(),
                    SizedBox(
                      height: 100,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Align(
                            alignment: const Alignment(-1, -0.5),
                            child: Text(
                              "BET: ",
                              style: Theme.of(context).textTheme.displayMedium,
                            ),
                          ),
                          const SizedBox(width: 20),
                          Expanded(
                            child: Form(
                              key: Get.find<MainController>().betFormKey,
                              child: TextFormField(
                                controller: Get.find<MainController>().betCoins,
                                keyboardType: TextInputType.number,
                                textAlign: TextAlign.center,
                                onTap: () {
                                  if (Get.find<MainController>()
                                          .betCoins
                                          .text ==
                                      "0") {
                                    Get.find<MainController>().betCoins.clear();
                                  }
                                },
                                validator: (value) {
                                  if (value == null || value == "") {
                                    return "Enter an amount";
                                  } else if (value == "0") {
                                    return "Enter an amount";
                                  } else if (value.length >= 15) {
                                    return "Bet Limit Exceeded";
                                  } else if (int.parse(value) >
                                      Get.find<MainController>().coins.value) {
                                    return "Not enough balance";
                                  }
                                  return null;
                                },
                                style: const TextStyle(
                                  fontSize: 20,
                                  color: Colors.black,
                                  fontWeight: FontWeight.w600,
                                  fontFamily: "JosefinSans",
                                ),
                                inputFormatters: [
                                  FilteringTextInputFormatter.allow(
                                    RegExp("[0-9]"),
                                  ),
                                ],
                                autovalidateMode:
                                    AutovalidateMode.onUserInteraction,
                                decoration: const InputDecoration(
                                  filled: true,
                                  fillColor: Colors.white,
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.zero,
                                    borderSide: BorderSide(
                                      color: Colors.grey,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const Spacer(flex: 8),
                  ],
                ),
              ),
              Expanded(
                child: Center(
                  child: ElevatedButton(
                    onPressed: () {
                      if (Get.find<MainController>()
                          .betFormKey
                          .currentState!
                          .validate()) {
                        Get.toNamed(ConfirmView.id);
                      }
                    },
                    child: const Text("Next"),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
