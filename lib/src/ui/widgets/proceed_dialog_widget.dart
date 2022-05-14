import 'package:attendance_app/src/ui/widgets/app_button.dart';
import 'package:attendance_app/src/utils/constants.dart';
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
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(20.0),
        ),
      ),
      scrollable: true,
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text(
            'Proceed ?',
            style: TextStyle(fontWeight: FontWeight.w900),
          ),
          Constants.verticalSpacer15,
          Text(name),
          Constants.verticalSpacer8,
          Text(subtext),
          Constants.verticalSpacer15,
          Row(
            children: [
              Expanded(
                child: AppButton(
                  buttonColor: Colors.white,
                  borderSideColor: Colors.black,
                  textColor: Colors.black,
                  buttonText: 'Cancel',
                  onTap: () => Navigator.pop(context, false),
                ),
              ),
              const SizedBox(
                width: 10.0,
              ),
              Expanded(
                child: AppButton(
                  buttonText: 'Proceed',
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
