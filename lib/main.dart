import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:qatar_plinko_cup/controllers/main_controller.dart';
import 'package:qatar_plinko_cup/services/database_service.dart';
import 'package:qatar_plinko_cup/ui/bet_screen.dart';
import 'package:qatar_plinko_cup/ui/confirm_screen.dart';
import 'package:qatar_plinko_cup/ui/game_screen.dart';
import 'package:qatar_plinko_cup/ui/main_menu_screen.dart';
import 'package:qatar_plinko_cup/ui/result_screen.dart';
import 'package:qatar_plinko_cup/ui/stats_screen.dart';
import 'package:qatar_plinko_cup/ui/teams_screen.dart';

import 'utils/functions.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final database = DatabaseService();
  await database.ensureInitialized();
  Get.lazyPut(() => database, fenix: true);
  Get.lazyPut(() => MainController(), fenix: true);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    return GetMaterialApp(
      theme: buildThemeData(),
      debugShowCheckedModeBanner: false,
      initialRoute: MainMenuView.id,
      defaultTransition: Transition.cupertino,
      routes: {
        MainMenuView.id: (context) => const MainMenuView(),
        TeamsView.id: (context) => const TeamsView(),
        BetView.id: (context) => const BetView(),
        ConfirmView.id: (context) => const ConfirmView(),
        GameView.id: (context) => GameView(),
        ResultView.id: (context) => const ResultView(),
        StatsView.id: (context) => const StatsView(),
      },
    );
  }
}
