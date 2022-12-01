import 'package:flutter/material.dart';

import '../generated/assets.dart';

class ScoreBox extends StatelessWidget {
  final double score;
  final double width;
  final double height;

  const ScoreBox({
    Key? key,
    required this.score,
    this.width = 90,
    this.height = 60,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Center(
          child: Image.asset(
            Assets.imagesBox,
            width: width,
            height: height,
            fit: BoxFit.fill,
          ),
        ),
        Align(
          alignment: const Alignment(0, 0.075),
          child: Text(
            score.toStringAsFixed(1),
            textAlign: TextAlign.center,
            style: Theme.of(context)
                .textTheme
                .bodyMedium
                ?.copyWith(color: Colors.white),
          ),
        ),
      ],
    );
  }
}
