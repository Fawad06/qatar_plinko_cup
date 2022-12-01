import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:qatar_plinko_cup/controllers/main_controller.dart';

import '../generated/assets.dart';

class CoinWidget extends StatelessWidget {
  const CoinWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 120,
      height: 50,
      color: const Color(0xff3472A1),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgPicture.asset(Assets.iconsCoin),
          const SizedBox(width: 10),
          GetX<MainController>(
            builder: (controller) {
              return Text(
                formatNumbers(controller.coins.toString()),
                style: Theme.of(context)
                    .textTheme
                    .bodyMedium
                    ?.copyWith(color: Colors.white),
              );
            },
          ),
        ],
      ),
    );
  }

  String formatNumbers(String coins) {
    String s = "";
    int count = 0;
    if (coins.length >= 7) {
      return "${coins[0]}M";
    }
    for (int i = coins.length - 1; i >= 0; i--) {
      if (count == 2) {
        s = " ${coins[i]}$s";
        count = 0;
      } else {
        count++;
        s = coins[i] + s;
      }
    }
    return s;
  }
}
