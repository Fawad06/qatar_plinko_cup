import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:qatar_plinko_cup/generated/assets.dart';
import 'package:qatar_plinko_cup/utils/functions.dart';
import 'package:qatar_plinko_cup/widgets/background_widget.dart';
import 'package:qatar_plinko_cup/widgets/team_widget.dart';

import '../controllers/main_controller.dart';
import '../widgets/score_box.dart';

class StatsView extends StatelessWidget {
  const StatsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BackgroundWidget(
      child: Scaffold(
        appBar: buildAppBar(context, "MY STATS"),
        body: Container(
          margin: const EdgeInsets.only(left: 20, right: 20, bottom: 30),
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(color: const Color(0xff1160B0)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Spacer(),
              Text(
                "FAVOURITE TEAM",
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodyLarge,
              ),
              const Spacer(),
              TeamWidget(
                isSelected: false,
                country: Get.find<MainController>().favouriteTeam,
              ),
              const Spacer(flex: 2),
              Text(
                "BIGGEST WINNING OF\n ALL TIME",
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodyLarge,
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    "400",
                    style: Theme.of(context)
                        .textTheme
                        .bodySmall
                        ?.copyWith(fontSize: 28),
                  ),
                  const SizedBox(width: 10),
                  SvgPicture.asset(
                    Assets.iconsCoin,
                    width: 30,
                    height: 30,
                  ),
                ],
              ),
              const Spacer(flex: 2),
              Text(
                "BIGGEST WINNING OF\n ALL TIME",
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodyLarge,
              ),
              const SizedBox(height: 20),
              const ScoreBox(score: 8.1),
              const Spacer(flex: 2),
            ],
          ),
        ),
      ),
    );
  }
}
