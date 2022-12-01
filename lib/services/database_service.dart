import 'package:get/get.dart';
import 'package:qatar_plinko_cup/models/country_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DatabaseService extends GetxService {
  late final SharedPreferences prefs;

  bool isFirstStart() {
    return prefs.getBool('first_start') ?? true;
  }

  int getTeamCount(String countryName) {
    return prefs.getInt(countryName) ?? 0;
  }

  double getHighestWinningOdd() {
    return prefs.getDouble('winning_odd') ?? 0;
  }

  int getBiggestWinningAmount() {
    return prefs.getInt('winning_amount') ?? 0;
  }

  int getBalance() {
    return prefs.getInt('balance') ?? 0;
  }

  Future<void> setBiggestWinningAmount(int amount) async {
    if (getBiggestWinningAmount() < amount) {
      await prefs.setInt('winning_amount', amount);
    }
  }

  Future<void> setHighestWinningOdd(double odd) async {
    if (getHighestWinningOdd() < odd) {
      await prefs.setDouble('winning_odd', odd);
    }
  }

  Future<void> setBalance(int amount) async {
    await prefs.setInt('balance', amount);
  }

  Future<void> setFirstStart(bool firstStart) async {
    await prefs.setBool('first_start', firstStart);
  }

  Future<void> setFavouriteTeam(Country country) async {
    final teamCount = getTeamCount(country.name);
    await prefs.setInt(country.name, teamCount + 1);
  }

  Future ensureInitialized() async {
    prefs = await SharedPreferences.getInstance();
  }

  Future setAwardTime(DateTime dateTime) async {
    await prefs.setString('award_date_time', dateTime.toString());
  }

  DateTime getAwardTime() {
    final dateString = prefs.getString('award_date_time');
    if (dateString == null) {
      return DateTime.now().add(const Duration(hours: 3));
    }
    return DateTime.parse(dateString);
  }
}
