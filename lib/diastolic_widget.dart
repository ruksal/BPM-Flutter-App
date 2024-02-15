import 'package:flutter/material.dart';

class DiastolicWidget extends StatefulWidget {
  final ValueChanged<int> onValueChanged;
  const DiastolicWidget({Key? key, required this.onValueChanged})
      : super(key: key);

  @override
  State<DiastolicWidget> createState() => _DiastolicWidgetState();
}

class _DiastolicWidgetState extends State<DiastolicWidget> {
  int _diastolic = 0;
  // ignore: unused_field
  bool _hasError2 = false;
  int _val = 0;

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
                    _hasError2 = false; // Reset error status
                    if (value.isEmpty || int.tryParse(value) == null) {
                      _hasError2 = true; // Set error status
                    } else {
                      _val = int.tryParse(value)!;
                      if (_val < 0 || _val > 380) {
                        _hasError2 = true;
                      } else {
                        _diastolic = _val;
                      }
                    }
                    widget.onValueChanged(_diastolic);
                  });
                },
                decoration: InputDecoration(
                  labelText: 'Enter Diastolic Blood Pressure',
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
