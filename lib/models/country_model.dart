import 'package:get/get.dart';
import 'package:qatar_plinko_cup/generated/assets.dart';

class Country {
  final String name;
  final String imageUrl;

  Country(this.name, this.imageUrl);
}

RxInt balanceCoins = 1000.obs;
final countries = [
  Country("Qatar", Assets.imagesQatar),
  Country("England", Assets.imagesEngland),
  Country("Argentina", Assets.imagesArgentina),
  Country("France", Assets.imagesFrance),
  Country("Spain", Assets.imagesSpain),
  Country("Belgium", Assets.imagesBelgium),
  Country("Brazil", Assets.imagesBrazil),
  Country("Portugal", Assets.imagesPortugal),
  Country("Ecuador", Assets.imagesEcuador),
  Country("Iran", Assets.imagesIran),
  Country("Saudi Arabia", Assets.imagesSaudiArabia),
  Country("Australia", Assets.imagesAustralia),
  Country("Costa Rica", Assets.imagesCostaRica),
  Country("Canada", Assets.imagesCanada),
  Country("Serbia", Assets.imagesSerbia),
  Country("Ghana", Assets.imagesGhana),
  Country("Senegal", Assets.imagesSenegal),
  Country("USA", Assets.imagesUsa),
  Country("Mexico", Assets.imagesMexico),
  Country("Denmark", Assets.imagesDenmark),
  Country("Germany", Assets.imagesGermany),
  Country("Morocco", Assets.imagesMoroco),
  Country("Switzerland", Assets.imagesSwitzerland),
  Country("Uruguay", Assets.imagesUruguay),
  Country("Netherlands", Assets.imagesNetherlands),
  Country("Wales", Assets.imagesWales),
  Country("Poland", Assets.imagesPoland),
  Country("Tunisia", Assets.imagesTunisia),
  Country("Japan", Assets.imagesJapan),
  Country("Croatia", Assets.imagesCroatia),
  Country("Cameroon", Assets.imagesCameroon),
  Country("South Korea", Assets.imagesSouthKorea),
];
