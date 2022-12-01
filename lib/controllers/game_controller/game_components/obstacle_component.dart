import 'package:flame/components.dart';
import 'package:flame_forge2d/flame_forge2d.dart';

class ObstacleBody extends BodyComponent {
  ObstacleBody(this.location) : super(renderBody: false);
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

class Obstacle extends SpriteComponent with HasGameRef<Forge2DGame> {
  Obstacle(this.location);
  final Vector2 location;

  @override
  Future<void> onLoad() async {
    super.onLoad();
    sprite = await gameRef.loadSprite('obstacle.png');
    size = Vector2(3.5, 3);
    position = location;
    anchor = Anchor.center;
    add(ObstacleBody(location));
  }
}
