import 'dart:async' as asc;

import 'package:flame_forge2d/flame_forge2d.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qatar_plinko_cup/controllers/game_controller/game_components/bottom_border_component.dart';
import 'package:qatar_plinko_cup/controllers/main_controller.dart';

import '../../ui/result_screen.dart';
import 'game_components/obstacle_component.dart';
import 'game_components/team_component.dart';
import 'game_components/wall_border_component.dart';

class PlinkoGame extends Forge2DGame {
  PlinkoGame() : super(gravity: Vector2(0, 100));
  late final Team t1;
  late final Team t2;
  late final Team t3;
  late final Team t4;
  late final scoreM1 = mainController.getRandomScoreMultiplier();
  late final scoreM2 = mainController.getRandomScoreMultiplier();
  late final scoreM3 = mainController.getRandomScoreMultiplier();
  late final scoreM4 = mainController.getRandomScoreMultiplier();
  final mainController = Get.find<MainController>();
  bool shouldPause = true;
  int teamsRemoved = 0;
  @override
  backgroundColor() => Colors.transparent;

  @override
  Future<void> onLoad() async {
    await super.onLoad();
    buildTeams();
    buildObstacles();
    buildWallBorders();
    buildBottomBorders();
    asc.Timer(const Duration(seconds: 3), () => resumeEngine());
  }

  @override
  void update(dt) {
    super.update(dt);
    if (shouldPause) {
      pauseEngine();
      shouldPause = false;
    }
    if (teamsRemoved == 4) {
      pauseEngine();
      mainController.calculateGameResult();
      Get.offNamed(ResultView.id);
    }
  }

  void buildTeams() {
    final locations = [
      Vector2(size.x * 0.27, size.y * 0.1),
      Vector2(size.x * 0.42, size.y * 0.1),
      Vector2(size.x * 0.57, size.y * 0.1),
      Vector2(size.x * 0.72, size.y * 0.1),
    ];
    locations.shuffle();
    t1 = Team(
      country: mainController.getCurrentCountry,
      location: locations[0],
      collisionCallBack: mainController.countryPlacement,
      whenRemoved: () {
        teamsRemoved++;
      },
    );
    t2 = Team(
      country: mainController.getRandomCountry(),
      location: locations[1],
      collisionCallBack: mainController.countryPlacement,
      whenRemoved: () {
        teamsRemoved++;
      },
    );
    t3 = Team(
      country: mainController.getRandomCountry(),
      location: locations[2],
      collisionCallBack: mainController.countryPlacement,
      whenRemoved: () {
        teamsRemoved++;
      },
    );
    t4 = Team(
      country: mainController.getRandomCountry(),
      location: locations[3],
      collisionCallBack: mainController.countryPlacement,
      whenRemoved: () {
        teamsRemoved++;
      },
    );
    add(t1);
    add(t2);
    add(t3);
    add(t4);
  }

  void buildBottomBorders() {
    final sizeY = size.y * 0.9;
    add(
      BottomBorder(
        startingPoints: Vector2(size.x * 0.00, sizeY),
        endingPoints: Vector2(size.x * 0.25, sizeY),
        scoreMultiplier: scoreM1,
      ),
    );
    add(
      BottomBorder(
        startingPoints: Vector2(size.x * 0.25, sizeY),
        endingPoints: Vector2(size.x * 0.5, sizeY),
        scoreMultiplier: scoreM2,
      ),
    );
    add(
      BottomBorder(
        startingPoints: Vector2(size.x * 0.5, sizeY),
        endingPoints: Vector2(size.x * 0.75, sizeY),
        scoreMultiplier: scoreM3,
      ),
    );
    add(
      BottomBorder(
        startingPoints: Vector2(size.x * 0.75, sizeY),
        endingPoints: Vector2(size.x * 1.00, sizeY),
        scoreMultiplier: scoreM4,
      ),
    );
  }

  void buildWallBorders() {
    add(
      WallBorder(
        startingPoints: Vector2(size.x * 0.05, 0),
        endingPoints: Vector2(size.x * 0.05, size.y),
      ),
    );
    add(
      WallBorder(
        startingPoints: Vector2(size.x - size.x * 0.05, 0),
        endingPoints: Vector2(size.x - size.x * 0.05, size.y),
      ),
    );
  }

  void buildObstacles() async {
    double spaceY = 0;
    for (int i = 1; i < 10; i++) {
      if (i % 2 != 0) {
        double spaceX = 0;
        for (int j = 1; j <= 4; j++) {
          add(
            Obstacle(
              Vector2(
                size.x * 0.2 + spaceX,
                size.y * 0.2 + spaceY,
              ),
            ),
          );
          spaceX = (size.x * 0.2 * j);
        }
      } else {
        double spaceX = 0;
        for (int j = 1; j <= 5; j++) {
          add(
            Obstacle(
              Vector2(
                size.x * 0.1 + spaceX,
                size.y * 0.2 + spaceY,
              ),
            ),
          );
          spaceX = (size.x * 0.2 * j);
        }
      }
      spaceY = size.y * 0.07 * i;
    }
  }
}
