import 'package:flame_forge2d/flame_forge2d.dart';

class WallBorder extends BodyComponent {
  WallBorder({
    required this.startingPoints,
    required this.endingPoints,
  }) : super(renderBody: false);

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
