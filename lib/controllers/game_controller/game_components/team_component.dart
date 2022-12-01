import 'package:flame/components.dart';
import 'package:flame_forge2d/flame_forge2d.dart';
import 'package:flutter/material.dart';
import 'package:qatar_plinko_cup/controllers/game_controller/game_components/bottom_border_component.dart';
import 'package:qatar_plinko_cup/models/country_model.dart';

class Team extends BodyComponent with ContactCallbacks {
  Team({
    required this.country,
    required this.location,
    required this.collisionCallBack,
    required this.whenRemoved,
  });

  final Country country;
  final Vector2 location;
  final VoidCallback whenRemoved;
  final Function(Country country, double scoreMultiplier) collisionCallBack;

  @override
  void onRemove() {
    whenRemoved();
  }

  @override
  Future<void> onLoad() async {
    super.onLoad();
    final sprite = country.imageUrl.split('/').last;
    add(
      SpriteComponent(
        sprite: await gameRef.loadSprite(sprite),
        size: Vector2.all(gameRef.size.y * 0.0275 * 2),
        anchor: Anchor.center,
      ),
    );
  }

  @override
  Body createBody() {
    final shape = CircleShape()..radius = gameRef.size.y * 0.0275;
    final fixtureDef = FixtureDef(
      shape,
      friction: 0.5,
      restitution: 0.5,
      density: 1,
    );
    final bodyDef = BodyDef(
      type: BodyType.dynamic,
      position: location,
      userData: this,
    );
    return world.createBody(bodyDef)..createFixture(fixtureDef);
  }

  @override
  void beginContact(Object other, Contact contact) {
    if (other is BottomBorder && isMounted) {
      collisionCallBack(country, other.scoreMultiplier);
      body.position.add(Vector2(99, 99));
      gameRef.remove(this);
    }
  }
}
