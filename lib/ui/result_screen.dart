import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:qatar_plinko_cup/controllers/main_controller.dart';
import 'package:qatar_plinko_cup/generated/assets.dart';
import 'package:qatar_plinko_cup/widgets/background_widget.dart';
import 'package:qatar_plinko_cup/widgets/team_widget.dart';

class ResultView extends StatelessWidget {
  static const String id = "ResultView";
  const ResultView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<MainController>();
    return BackgroundWidget(
      child: Scaffold(
        body: SafeArea(
          child: Column(
            children: [
              const SizedBox(height: 40),
              Text(
                "RESULT",
                style: Theme.of(context).textTheme.displayMedium?.copyWith(
                      color: const Color(0xff1160B0),
                      fontSize: 34,
                    ),
              ),
              const SizedBox(height: 10),
              Expanded(
                flex: 4,
                child: Container(
                  margin: const EdgeInsets.symmetric(horizontal: 30),
                  padding: const EdgeInsets.only(top: 20),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(color: const Color(0xff1160B0)),
                  ),
                  child: Column(
                    children: [
                      Expanded(
                        flex: 5,
                        child: ListView.separated(
                          itemCount: controller.winList.length,
                          itemBuilder: (context, index) => Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Text(
                                "#${index + 1}",
                                style: Theme.of(context)
                                    .textTheme
                                    .displayLarge
                                    ?.copyWith(
                                      color: controller.winList[index]
                                                  ['country'] ==
                                              controller.getCurrentCountry
                                          ? const Color(0xff3472A1)
                                          : Colors.grey,
                                    ),
                              ),
                              TeamWidget(
                                isSelected: controller.winList[index]
                                            ['country'] ==
                                        controller.getCurrentCountry
                                    ? true
                                    : false,
                                country: controller.winList[index]['country'],
                                isResult: true,
                              ),
                            ],
                          ),
                          separatorBuilder: (_, __) =>
                              const SizedBox(height: 20),
                        ),
                      ),
                      const Divider(
                        thickness: 2,
                        color: Colors.grey,
                        indent: 10,
                        endIndent: 10,
                      ),
                      Expanded(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "TOTAL WIN: ${controller.winningAmount} ",
                              style: Theme.of(context)
                                  .textTheme
                                  .displayMedium
                                  ?.copyWith(color: const Color(0xff3472A1)),
                            ),
                            SvgPicture.asset(
                              Assets.iconsCoin,
                              width: 30,
                              height: 30,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                child: Center(
                  child: ElevatedButton(
                    onPressed: () {
                      controller.winningAmount = 0;
                      controller.winList.clear();
                      Get.back();
                    },
                    child: const Text("TO MAIN MENU"),
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
