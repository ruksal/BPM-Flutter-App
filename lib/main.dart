import 'package:blood_pressure_monitor/diastolic_widget.dart';
import 'package:blood_pressure_monitor/systolic_widget.dart';
import 'package:flutter/material.dart';
import 'info.dart';
import 'package:get/get.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Blood Pressure Monitor',
      theme: ThemeData(
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Blood Pressure Monitor'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  final String title;

  const MyHomePage({Key? key, required this.title}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _systolicValue = 0;
  int _diastolicValue = 0;
  double _gvalue = 0;
  String _result = ' ';
  bool _hasError = false;
  bool _hasError2 = false;

  void _showErrorAlert() {
    Get.dialog(
      AlertDialog(
        backgroundColor: Colors.black,
        title: const Text('Error',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.red, // Set the text color to red
            )),
        content: const Text(
          'Please enter valid Systolic and Diastolic Blood pressures.',
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Colors.white, // Set the text color to red
          ),
        ),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              Get.back(); // Close the dialog
            },
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          widget.title,
          style: const TextStyle(
            color: Colors.yellow, // Set the text color to yellow
          ),
        ),
        backgroundColor: Colors.black,
      ),
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/W5.jpg"),
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Card(
              elevation: 0,
              color: Colors.transparent,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.0),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Image.asset("assets/pngwing.com (20).png", width: 250),
                  const SizedBox(height: 8),
                  SystolicWidget(
                    onValueChanged: (value) {
                      setState(() {
                        _systolicValue = value;
                        _hasError = false; // Update the systolic value
                      });
                    },
                  ),
                  const SizedBox(height: 8),
                  DiastolicWidget(
                    onValueChanged: (value) {
                      setState(() {
                        _diastolicValue = value;
                        _hasError2 = false; // Update the systolic value
                      });
                    },
                  ),
                  const SizedBox(height: 8),
                  ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all<Color>(
                          const Color.fromARGB(255, 23, 242,
                              12)), // Set the button background color
                    ),
                    child: const Text(
                      'Show Info',
                      style: TextStyle(
                        color: Colors.black,
                      ),
                    ),
                    onPressed: () {
                      if (_systolicValue == 0 ||
                          _hasError ||
                          _diastolicValue == 0 ||
                          _hasError2) {
                        _showErrorAlert();
                      } else {
                        if (_systolicValue < 120 && _diastolicValue < 80) {
                          _gvalue = _systolicValue.toDouble();
                          _result = 'Normal';
                          _showInfoAlert();
                        } else if (_systolicValue >= 120 &&
                            _systolicValue < 130 &&
                            _diastolicValue < 80) {
                          _result = 'Elevated';
                          _gvalue = ((_systolicValue - 120) * 4) + 120;
                          _showInfoAlert();
                        } else if (_systolicValue >= 130 &&
                            _systolicValue < 140 &&
                            _diastolicValue >= 90 &&
                            _diastolicValue < 90) {
                          _result = 'High BP (Stage 1)';
                          _gvalue = ((_systolicValue - 130) * 4) + 160;
                          _showInfoAlert();
                        } else if (_systolicValue >= 140 &&
                            _systolicValue < 180 &&
                            _diastolicValue >= 90 &&
                            _diastolicValue < 120) {
                          _result = 'High BP (Stage 2)';
                          _gvalue = ((_systolicValue - 140) * 2) + 200;
                          _showInfoAlert();
                        } else if (_systolicValue >= 180 &&
                            _systolicValue < 400 &&
                            _diastolicValue >= 120 &&
                            _diastolicValue < 380) {
                          _result = 'Hypertensive Crisis';
                          _gvalue = ((_systolicValue - 180) * 0.77) + 280;
                          _showInfoAlert();
                        } else if (_systolicValue >= 400 &&
                            _diastolicValue > 380) {
                          _result = 'Hypertensive Crisis';
                          _gvalue = 450;
                          _showInfoAlert();
                        } else {
                          _result = 'Unrecognized';
                          _showInfoAlert();
                        }
                      }
                    },
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _showInfoAlert() {
    Get.to(() => InfoScreen(
          systolic: _systolicValue,
          diastolic: _diastolicValue,
          gvalue: _gvalue,
          result: _result,
        ));
  }
}
