import 'package:attendance_app/src/ui/widgets/app_button.dart';
import 'package:flutter/material.dart';

class ProceedDialogWidget extends StatelessWidget {
  const ProceedDialogWidget({
    Key? key,
    required this.name,
    required this.subtext,
  }) : super(key: key);
  final String name;
  final String subtext;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text('Proceed?'),
          Text(name),
          Text(subtext),
          Row(
            children: [
              Expanded(
                child: AppButton(
                  buttonText: 'Cancel',
                  onTap: () => Navigator.pop(context, false),
                ),
              ),
              const SizedBox(
                width: 10.0,
              ),
              Expanded(
                child: AppButton(
                  buttonText: 'Send',
                  onTap: () => Navigator.pop(
                    context,
                    true,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
