import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qatar_plinko_cup/services/database_service.dart';

import '../models/country_model.dart';

class MainController extends GetxController {
  final dbService = Get.find<DatabaseService>();
  int winningAmount = 0;
  RxInt balance = 0.obs;
  Rx<Duration> awardTimeDifference = const Duration(hours: 3).obs;
  RxString selectedCountryName = "".obs;
  TextEditingController betCoins = TextEditingController();
  GlobalKey<FormState> betFormKey = GlobalKey<FormState>();
  List<Map<String, dynamic>> winList = <Map<String, dynamic>>[];

  RxInt get coins => balance;
  List<Country> get countries => countriesList;
  double get highestWinningOdd => dbService.getHighestWinningOdd();
  int get biggestWinningAmount => dbService.getBiggestWinningAmount();
  Country get getCurrentCountry => countries
      .firstWhere((element) => element.name == selectedCountryName.value);

  @override
  Future<void> onInit() async {
    super.onInit();
    if (dbService.isFirstStart()) {
      await setBalance(1000);
      await dbService.setFirstStart(false);
      await setAwardTime(DateTime.now().add(const Duration(hours: 3)));
    }
    balance.value = dbService.getBalance();
    awardTimeDifference.value =
        DateTime.now().difference(dbService.getAwardTime());
    Timer.periodic(const Duration(seconds: 1), (timer) {
      awardTimeDifference.value =
          DateTime.now().difference(dbService.getAwardTime());
    });
  }

  Country getRandomCountry() {
    final rand = Random();
    final randomIndex = rand.nextInt(countries.length);
    Country randomCountry = countries[randomIndex];
    if (randomCountry == getCurrentCountry) {
      randomCountry = getRandomCountry();
    }
    return randomCountry;
  }

  double getRandomScoreMultiplier() {
    final rand = Random();
    return (rand.nextDouble() * 7.6) + 1.5;
  }

  void calculateGameResult() {
    for (int i = 0; i < 4; i++) {
      final country = winList[i]['country'] as Country;
      final scoreMultiplier = winList[i]['score'] as double;
      if (country == getCurrentCountry) {
        switch (i) {
          case 0:
            winningAmount =
                (int.parse(betCoins.text) * scoreMultiplier).toInt();
            break;
          case 1:
            winningAmount = int.parse(betCoins.text) * scoreMultiplier ~/ 2;
            break;
          case 2:
            winningAmount = int.parse(betCoins.text);
            break;
          case 3:
            winningAmount = 0;
            break;
        }
        balance.value += winningAmount;
        setBiggestWinningAmount(winningAmount);
        setBiggestWinningOdd(scoreMultiplier);
        setBalance(balance.value);
        break;
      }
    }
  }

  void countryPlacement(Country country, double scoreMultiplier) {
    winList.add({
      'country': country,
      'score': scoreMultiplier,
    });
  }

  Country getFavouriteTeam() {
    final List<int> cCounts = [];
    int max = 0;
    int maxIndex = 0;
    for (Country element in countries) {
      cCounts.add(dbService.getTeamCount(element.name));
    }
    for (int i = 0; i < cCounts.length; i++) {
      if (max < cCounts[i]) {
        max = cCounts[i];
        maxIndex = i;
      }
    }
    return max == 0 ? Country('', '') : countries[maxIndex];
  }

  Future<void> setFavouriteTeam(Country country) async {
    await dbService.setFavouriteTeam(country);
  }

  Future<void> setBiggestWinningAmount(int amount) async {
    await dbService.setBiggestWinningAmount(amount);
  }

  Future<void> setBiggestWinningOdd(double odd) async {
    await dbService.setHighestWinningOdd(odd);
  }

  Future<void> setBalance(int amount) async {
    balance.value = amount;
    await dbService.setBalance(amount);
  }

  Future deductFee() async {
    balance.value -= int.parse(betCoins.text);
    await dbService.setBalance(balance.value);
  }

  Future<void> confirm() async {
    await Future.wait([
      deductFee(),
      setFavouriteTeam(getCurrentCountry),
    ]);
  }

  void getAward() {
    setBalance(balance.value + 1000);
    setAwardTime(DateTime.now().add(const Duration(hours: 3)));
  }

  Future<void> setAwardTime(DateTime dateTime) async {
    awardTimeDifference.value = DateTime.now().difference(dateTime);
    await dbService.setAwardTime(dateTime);
  }
}
