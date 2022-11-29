import 'dart:async' as asc;

import 'package:flame/components.dart';
import 'package:flame/extensions.dart';
import 'package:flame/game.dart';
import 'package:flame_forge2d/flame_forge2d.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qatar_plinko_cup/ui/result_screen.dart';
import 'package:qatar_plinko_cup/utils/custom_clipper.dart';
import 'package:qatar_plinko_cup/widgets/background_widget.dart';
import 'package:qatar_plinko_cup/widgets/score_box.dart';

class GameView extends StatefulWidget {
  const GameView({Key? key}) : super(key: key);

  @override
  State<GameView> createState() => _GameViewState();
}

class _GameViewState extends State<GameView> {
  final PlinkoGame game = PlinkoGame();
  int elapsedTime = 0;

  @override
  Widget build(BuildContext context) {
    return BackgroundWidget(
      child: Scaffold(
        body: Stack(
          fit: StackFit.expand,
          children: [
            buildWalls(),
            GameWidget<PlinkoGame>(
              game: game,
              overlayBuilderMap: {
                'PauseMenu': (BuildContext context, PlinkoGame game) {
                  asc.Timer.periodic(const Duration(seconds: 1), (timer) {
                    if (elapsedTime <= 1) {
                      setState(() {
                        elapsedTime++;
                      });
                    } else {
                      timer.cancel();
                    }
                  });
                  return Align(
                    alignment: const Alignment(0, -0.5),
                    child: Text(
                      'Starting in ${game.pauseDuration.inSeconds - elapsedTime}...',
                      style:
                          Theme.of(context).textTheme.displayMedium?.copyWith(
                        color: Colors.yellowAccent,
                        shadows: [
                          const Shadow(
                            color: Colors.black,
                            offset: Offset(1, 2),
                            blurRadius: 10,
                          ),
                        ],
                      ),
                    ),
                  );
                },
              },
            ),
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
            children: const [
              Expanded(child: ScoreBox(score: 2.5, width: 70, height: 60)),
              Expanded(child: ScoreBox(score: 1.2, width: 70, height: 60)),
              Expanded(child: ScoreBox(score: 2.5, width: 70, height: 60)),
              Expanded(child: ScoreBox(score: 8.1, width: 70, height: 60)),
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

class PlinkoGame extends Forge2DGame {
  PlinkoGame() : super(gravity: Vector2(0, 100));
  late final Team t1;
  late final Team t2;
  late final Team t3;
  late final Team t4;
  bool shouldPause = true;
  Duration pauseDuration = const Duration(seconds: 3);
  @override
  backgroundColor() => Colors.transparent;

  @override
  Future<void> onLoad() async {
    await super.onLoad();
    t1 = Team('qatar.png', Vector2(size.x * 0.25, size.y * 0.1));
    t2 = Team('argentina.png', Vector2(size.x * 0.4, size.y * 0.1));
    t3 = Team('brazil.png', Vector2(size.x * 0.55, size.y * 0.1));
    t4 = Team('germany.png', Vector2(size.x * 0.7, size.y * 0.1));
    add(t1);
    add(t2);
    add(t3);
    add(t4);
    buildObstacles();
    //left wall border
    add(
      WallBorder(
        startingPoints: Vector2(size.x * 0.05, 0),
        endingPoints: Vector2(size.x * 0.05, size.y),
      ),
    );

    //right wall border
    add(
      WallBorder(
        startingPoints: Vector2(size.x - size.x * 0.05, 0),
        endingPoints: Vector2(size.x - size.x * 0.05, size.y),
      ),
    );
    overlays.add('PauseMenu');
    asc.Timer(pauseDuration, () {
      overlays.remove('PauseMenu');
      resumeEngine();
    });
  }

  @override
  void update(dt) {
    super.update(dt);
    if (shouldPause) {
      pauseEngine();
      shouldPause = false;
    }
    if (t1.body.position.y > size.y &&
        t2.body.position.y > size.y &&
        t3.body.position.y > size.y &&
        t4.body.position.y > size.y) {
      pauseEngine();
      Get.offAll(() => const ResultView());
    }
  }

  void buildObstacles() {
    int spaceV = 0;
    for (int i = 1; i < 10; i++) {
      if (i % 2 != 0) {
        int spaceH = 0;
        for (int j = 1; j <= 4; j++) {
          add(Obstacle(
            Vector2(size.x * 0.2 + spaceH, size.y * 0.2 + spaceV),
          ));
          spaceH = (8 * j);
        }
      } else {
        int spaceH = 0;
        for (int j = 1; j <= 5; j++) {
          add(Obstacle(
            Vector2(size.x * 0.1 + spaceH, size.y * 0.2 + spaceV),
          ));
          spaceH = (8 * j);
        }
      }
      spaceV = 6 * i;
    }
  }
}

class Team extends BodyComponent {
  Team(this.sprite, this.location);

  final String sprite;
  final Vector2 location;
  @override
  Future<void> onLoad() async {
    super.onLoad();
    add(
      SpriteComponent(
        sprite: await gameRef.loadSprite(sprite),
        size: Vector2.all(4),
        anchor: Anchor.center,
      ),
    );
  }

  @override
  Body createBody() {
    final shape = CircleShape()..radius = 2;
    final fixtureDef = FixtureDef(
      shape,
      friction: 0.5,
      restitution: 0.5,
      density: 1,
    );
    final bodyDef = BodyDef(type: BodyType.dynamic, position: location);
    return world.createBody(bodyDef)..createFixture(fixtureDef);
  }
}

class Obstacle extends BodyComponent {
  Obstacle(this.location);
  final Vector2 location;
  @override
  Body createBody() {
    final shape = CircleShape()..radius = 0.7;
    final fixtureDef = FixtureDef(
      shape,
      friction: 0.5,
      restitution: 0.7,
      density: 1,
    );
    final bodyDef = BodyDef(type: BodyType.static, position: location);
    return world.createBody(bodyDef)..createFixture(fixtureDef);
  }
}

class WallBorder extends BodyComponent {
  WallBorder({required this.startingPoints, required this.endingPoints});

  final Vector2 startingPoints;
  final Vector2 endingPoints;
  @override
  Body createBody() {
    final shape = EdgeShape()
      ..set(
        startingPoints,
        endingPoints,
      );
    final fixture = FixtureDef(shape, friction: 0.5);
    final bodyDef = BodyDef(position: Vector2.zero(), userData: this);
    return world.createBody(bodyDef)..createFixture(fixture);
  }
}
