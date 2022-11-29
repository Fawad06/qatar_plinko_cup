import 'package:flutter/material.dart';

class BackButtonCustom extends StatelessWidget {
  const BackButtonCustom({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).pop();
      },
      child: Container(
        width: 35,
        height: 25,
        color: const Color(0xff4098C6),
        child: const Icon(Icons.arrow_back),
      ),
    );
  }
}
