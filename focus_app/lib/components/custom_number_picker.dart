import 'package:flutter/material.dart';
import 'package:numberpicker/numberpicker.dart';
import 'package:get/get.dart';

class CustomNumberPicker extends StatelessWidget {
  final String label;
  final int minValue;
  final int maxValue;
  final RxInt currentValue;

  const CustomNumberPicker({
    Key? key,
    required this.label,
    required this.minValue,
    required this.maxValue,
    required this.currentValue,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        children: [
          Text(
            label,
            style: const TextStyle(
              fontSize: 18,
              color: Color(0xFF4A4A4A),
            ),
          ),
          Obx(() => NumberPicker(
                value: currentValue.value,
                minValue: minValue,
                maxValue: maxValue,
                onChanged: (value) => currentValue.value = value,
                selectedTextStyle: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).primaryColor,
                ),
                textStyle: const TextStyle(
                  fontSize: 18,
                  color: Color(0xFFB0B0B0),
                ),
              )),
        ],
      ),
    );
  }
}
