import 'package:attendance_app/src/ui/widgets/app_scaffold.dart';
import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

class QrScannerScreen extends StatelessWidget {
  const QrScannerScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      child: MobileScanner(
        allowDuplicates: false,
        onDetect: (barcode, args) {
          final String? code = barcode.rawValue;
          debugPrint('Barcode found! $code');
          Navigator.pop(context, code);
        },
      ),
    );
  }
}
