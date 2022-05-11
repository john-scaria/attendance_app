import 'package:flutter/material.dart';

class LogoWidget extends StatelessWidget {
  const LogoWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      /* height: MediaQuery.of(context).size.width / 2,
      width: MediaQuery.of(context).size.width / 2, */
      decoration: BoxDecoration(
        color: Colors.white,
        shape: BoxShape.circle,
      ),
      child: Center(
        child: Text('Abcdefg'),
      ),
    );
  }
}
