import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qatar_plinko_cup/utils/custom_clipper.dart';
import 'package:qatar_plinko_cup/widgets/background_widget.dart';
import 'package:qatar_plinko_cup/widgets/score_box.dart';

import '../controllers/game_controller/game_controller.dart';

class GameView extends StatelessWidget {
  static const String id = "GameView";
  final PlinkoGame game = PlinkoGame();

  GameView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BackgroundWidget(
      child: Scaffold(
        body: Stack(
          fit: StackFit.expand,
          children: [
            buildWalls(),
            GameWidget<PlinkoGame>(game: game),
            buildBottom(),
          ],
        ),
      ),
    );
  }

  Widget buildBottom() {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: ScoreBox(
                  score: game.scoreM1.toPrecision(1),
                  width: 70,
                  height: 60,
                ),
              ),
              Expanded(
                child: ScoreBox(
                  score: game.scoreM2.toPrecision(1),
                  width: 70,
                  height: 60,
                ),
              ),
              Expanded(
                child: ScoreBox(
                  score: game.scoreM3.toPrecision(1),
                  width: 70,
                  height: 60,
                ),
              ),
              Expanded(
                child: ScoreBox(
                  score: game.scoreM4.toPrecision(1),
                  width: 70,
                  height: 60,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Row buildWalls() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        ClipPath(
          clipper: LeftWallClipper(),
          child: Container(
            width: 20,
            height: double.infinity,
            color: const Color(0xff3472a1),
          ),
        ),
        ClipPath(
          clipper: RightWallClipper(),
          child: Container(
            width: 20,
            height: double.infinity,
            color: const Color(0xff3472a1),
          ),
        ),
      ],
    );
  }
}
