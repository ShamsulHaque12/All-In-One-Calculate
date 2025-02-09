import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TemperatureCalculator extends StatefulWidget {
  const TemperatureCalculator({super.key});

  @override
  State<TemperatureCalculator> createState() => _TemperatureCalculatorState();
}

class _TemperatureCalculatorState extends State<TemperatureCalculator> {
  final List<String> tempUnits = ["Celsius", "Fahrenheit", "Kelvin"];
  String selectedUnit = "Celsius";
  final TextEditingController tempController = TextEditingController();
  String result = "";

  void calculateTemp() {
    final temp = double.tryParse(tempController.text);
    if (temp == null || temp == 0) {
      setState(() => result = "Invalid input");
      return;
    }
    double tempInCelsius;
    if (selectedUnit == "Fahrenheit") {
      tempInCelsius = (temp - 32) * 5 / 9;
    } else if (selectedUnit == "Kelvin") {
      tempInCelsius = temp - 273.15;
    } else {
      tempInCelsius = temp;
    }
    String output = "";
    for (int i = 0; i < tempUnits.length; i++) {
      String unit = tempUnits[i];

      double convertedValue;
      if (unit == "Fahrenheit") {
        convertedValue = (tempInCelsius * 9 / 5) + 32;
      } else if (unit == "Kelvin") {
        convertedValue = tempInCelsius + 273.15;
      } else {
        convertedValue = tempInCelsius;
      }
      convertedValue = double.parse(convertedValue.toStringAsFixed(2));
      output += "$convertedValue $unit\n";
      setState(() {
        result = output;
      });
    }
  }

  void clearFields() {
    setState(() {
      selectedUnit = "Celsius";
      tempController.clear();
      result = "";
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Text("Temperature Calculator",
                  style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                      color: Colors.red)),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: tempController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: "Enter Temperature",
              ),
            ),
            const SizedBox(height: 10),
            DropdownButtonFormField<String>(
              value: selectedUnit,
              items: [
                DropdownMenuItem(value: "Celsius", child: Text("Celsius")),
                DropdownMenuItem(
                    value: "Fahrenheit", child: Text("Fahrenheit")),
                DropdownMenuItem(value: "Kelvin", child: Text("Kelvin")),
              ],
              onChanged: (value) => setState(() => selectedUnit = value!),
              decoration: const InputDecoration(border: OutlineInputBorder()),
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ElevatedButton(
                  onPressed: calculateTemp,
                  style: ElevatedButton.styleFrom(foregroundColor: Colors.red),
                  child: const Text(
                    "Calculate",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ),
                ElevatedButton(
                    onPressed: clearFields,
                    style:
                        ElevatedButton.styleFrom(foregroundColor: Colors.red),
                    child: const Text(
                      "Clear",
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    )),
              ],
            ),
            const SizedBox(height: 10),
            Center(
              child: Text("Converted Values",
                  style: const TextStyle(
                      fontSize: 25, fontWeight: FontWeight.bold)),
            ),
            const SizedBox(height: 10),
            if (result.isNotEmpty)
              Center(
                child: Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.red, width: 2),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  padding: const EdgeInsets.all(10),
                  child: Text(result,
                      style: const TextStyle(
                          fontSize: 20, fontWeight: FontWeight.bold)),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
