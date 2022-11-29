import 'package:flutter/material.dart';

import '../models/country_model.dart';

class TeamWidget extends StatelessWidget {
  const TeamWidget({
    Key? key,
    required this.isSelected,
    required this.country,
    this.isResult = false,
  }) : super(key: key);

  final Country country;
  final bool isSelected;
  final bool isResult;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: isSelected ? const Color(0xff1160B0) : Colors.transparent,
      width: isResult ? 130 : null,
      child: Column(
        children: [
          isResult ? const SizedBox(height: 10) : const SizedBox(height: 20),
          CircleAvatar(
            radius: isResult ? 20 : 42,
            backgroundImage: AssetImage(
              country.imageUrl,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            country.name,
            style: Theme.of(context)
                .textTheme
                .bodyText2
                ?.copyWith(color: Colors.grey),
          ),
          if (isResult) const SizedBox(height: 10),
        ],
      ),
    );
  }
}
