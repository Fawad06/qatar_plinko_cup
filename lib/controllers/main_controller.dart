import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../models/country_model.dart' as cm;

class MainController extends GetxController {
  RxString selectedCountryName = "".obs;
  RxInt get coins => cm.balanceCoins;
  TextEditingController betCoins = TextEditingController();
  GlobalKey<FormState> betFormKey = GlobalKey<FormState>();
  List<cm.Country> get countries => cm.countries;

  cm.Country get getCurrentCountry => countries.firstWhere(
        (element) => element.name == selectedCountryName.value,
      );

  cm.Country get favouriteTeam =>
      countries.firstWhere((element) => element.name == "Argentina");
}
