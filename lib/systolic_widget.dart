import 'package:flutter/material.dart';

class SystolicWidget extends StatefulWidget {
  final ValueChanged<int> onValueChanged; // Define callback function

  const SystolicWidget({Key? key, required this.onValueChanged})
      : super(key: key);

  @override
  State<SystolicWidget> createState() => _SystolicWidgetState();
}

class _SystolicWidgetState extends State<SystolicWidget> {
  int _systolic = 0;
  // ignore: unused_field
  bool _hasError = false;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: [
          SizedBox(
            width: 350.0, // Set the width of the SizedBox
            child: Container(
              decoration: BoxDecoration(
                color: const Color.fromARGB(255, 59, 231, 254),
                borderRadius: BorderRadius.circular(12.0), // Round corners
              ),
              padding: const EdgeInsets.only(
                top: 6.0,
                bottom: 2.0,
                left: 2.0,
                right: 2.0,
              ), // Add padding
              child: TextFormField(
                keyboardType: TextInputType.number,
                onChanged: (value) {
                  setState(() {
                    _hasError = false; // Reset error status
                    if (value.isEmpty || int.tryParse(value) == null) {
                      _hasError = true; // Set error status
                    } else {
                      _systolic = int.tryParse(value)!;
                    }
                    widget.onValueChanged(_systolic);
                  });
                },
                decoration: InputDecoration(
                  labelText: 'Enter Systolic Blood Pressure',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12.0),
                  ), // Keep the outline border
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
