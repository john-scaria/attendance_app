import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';

class AppQrView extends StatelessWidget {
  const AppQrView({Key? key, required this.data}) : super(key: key);
  final String data;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20.0),
        color: Colors.white,
      ),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: QrImage(
          data: data,
          size: 200.0,
        ),
      ),
    );
  }
}
