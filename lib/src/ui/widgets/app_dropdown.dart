import 'package:flutter/material.dart';

class AppDropDown<T> extends StatelessWidget {
  const AppDropDown({
    Key? key,
    required this.items,
    required this.value,
    required this.onChanged,
  }) : super(key: key);
  final List<DropdownMenuItem<T>>? items;
  final T value;
  final void Function(T?)? onChanged;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 8.0,
          vertical: 8.0,
        ),
        child: DropdownButton<T>(
          value: value,
          onChanged: onChanged,
          items: items,
          isExpanded: true,
          borderRadius: BorderRadius.circular(10.0),
          elevation: 0,
          underline: const SizedBox.shrink(),
          isDense: true,
          style: const TextStyle(
            fontSize: 12.0,
            color: Colors.black,
          ),
        ),
      ),
    );
  }
}
