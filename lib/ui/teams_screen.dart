import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qatar_plinko_cup/ui/bet_screen.dart';
import 'package:qatar_plinko_cup/widgets/background_widget.dart';

import '../controllers/main_controller.dart';
import '../utils/functions.dart';
import '../widgets/team_widget.dart';

class TeamsView extends StatelessWidget {
  const TeamsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BackgroundWidget(
      child: Scaffold(
        appBar: buildAppBar(
          context,
          "CHOOSE YOUR COUNTRY",
        ),
        body: Column(
          children: [
            Expanded(
              flex: 4,
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 30),
                padding: const EdgeInsets.only(left: 20, right: 20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(color: const Color(0xff1160B0)),
                ),
                child: GetX<MainController>(
                  builder: (controller) {
                    final selectedName = controller.selectedCountryName.value;
                    final countries = controller.countries;
                    return GridView.builder(
                      itemCount: countries.length,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        childAspectRatio: 1,
                        crossAxisSpacing: 20,
                        mainAxisSpacing: 20,
                      ),
                      itemBuilder: (context, index) {
                        final country = countries[index];
                        return GestureDetector(
                          onTap: () {
                            controller.betCoins.clear();
                            controller.selectedCountryName.value = country.name;
                          },
                          child: TeamWidget(
                            isSelected: selectedName == country.name,
                            country: country,
                          ),
                        );
                      },
                    );
                  },
                ),
              ),
            ),
            Expanded(
              child: Center(
                child: GetX<MainController>(builder: (controller) {
                  return ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.resolveWith<Color?>(
                        (Set<MaterialState> states) {
                          if (states.contains(MaterialState.disabled)) {
                            return const Color(0xff2D87E1).withOpacity(0.5);
                          }
                          return null;
                        },
                      ),
                    ),
                    onPressed: controller.selectedCountryName.value.isEmpty
                        ? null
                        : () {
                            controller.betCoins.text = "0";
                            Navigator.of(context).push(
                              CupertinoPageRoute(
                                builder: (context) => const BetView(),
                              ),
                            );
                          },
                    child: const Text("NEXT"),
                  );
                }),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
