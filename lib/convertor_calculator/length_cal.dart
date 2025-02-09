import 'package:flutter/material.dart';

class LengthCalculator extends StatefulWidget {
  const LengthCalculator({super.key});

  @override
  State<LengthCalculator> createState() => _LengthCalculatorState();
}

class _LengthCalculatorState extends State<LengthCalculator> {
  final List<String> lengthUnits = [
    "Meter",
    "Kilometer",
    "Centimeter",
    "Inch",
    "Feet",
    "Mile",
    "Yard",
    "Nanometer",
    "Micrometer",
    "Millimeter"
  ];

  String selectedUnit = "Meter";
  final TextEditingController lengthController = TextEditingController();
  String result = "";

  void calculateLength() {
    final length = double.tryParse(lengthController.text);
    if (length == null || length <= 0) {
      setState(() => result = "Invalid input");
      return;
    }

    double lengthInMeters;
    if (selectedUnit == "Kilometer")
      lengthInMeters = length * 1000;
    else if (selectedUnit == "Centimeter")
      lengthInMeters = length * 0.01;
    else if (selectedUnit == "Millimeter")
      lengthInMeters = length * 0.001;
    else if (selectedUnit == "Inch")
      lengthInMeters = length * 0.0254;
    else if (selectedUnit == "Feet")
      lengthInMeters = length * 0.3048;
    else if (selectedUnit == "Mile")
      lengthInMeters = length * 1609.34;
    else if (selectedUnit == "Yard")
      lengthInMeters = length * 0.9144;
    else if (selectedUnit == "Nanometer")
      lengthInMeters = length * 1e-9;
    else if (selectedUnit == "Micrometer")
      lengthInMeters = length * 1e-6;
    else
      lengthInMeters = length;

    String output = "";
    for (int i = 0; i < lengthUnits.length; i++) {
      String unit = lengthUnits[i];
      double convertedValue;
      if (unit == "Kilometer")
        convertedValue = lengthInMeters * 0.001;
      else if (unit == "Centimeter")
        convertedValue = lengthInMeters * 100;
      else if (unit == "Millimeter")
        convertedValue = lengthInMeters * 1000;
      else if (unit == "Inch")
        convertedValue = lengthInMeters * 39.37;
      else if (unit == "Feet")
        convertedValue = lengthInMeters * 3.281;
      else if (unit == "Mile")
        convertedValue = lengthInMeters * 0.000621371;
      else if (unit == "Yard")
        convertedValue = lengthInMeters * 1.09361;
      else if (unit == "Nanometer")
        convertedValue = lengthInMeters * 1e9;
      else if (unit == "Micrometer")
        convertedValue = lengthInMeters * 1e6;
      else
        convertedValue = lengthInMeters;
      output += "$convertedValue $unit\n";
    }

    setState(() {
      result = output;
    });
  }

  void clearFields() {
    setState(() {
      selectedUnit = "Meter";
      lengthController.clear();
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
              child: Text("Length Calculator",
                  style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                      color: Colors.red)),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: lengthController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: "Enter Length",
              ),
            ),
            const SizedBox(height: 10),
            DropdownButtonFormField<String>(
              value: selectedUnit,
              items: [
                DropdownMenuItem(value: "Meter", child: Text("Meter")),
                DropdownMenuItem(value: "Kilometer", child: Text("Kilometer")),
                DropdownMenuItem(
                    value: "Centimeter", child: Text("Centimeter")),
                DropdownMenuItem(value: "Inch", child: Text("Inch")),
                DropdownMenuItem(value: "Feet", child: Text("Feet")),
                DropdownMenuItem(value: "Mile", child: Text("Mile")),
                DropdownMenuItem(value: "Yard", child: Text("Yard")),
                DropdownMenuItem(value: "Nanometer", child: Text("Nanometer")),
                DropdownMenuItem(
                    value: "Micrometer", child: Text("Micrometer")),
                DropdownMenuItem(
                    value: "Millimeter", child: Text("Millimeter")),
              ],
              onChanged: (value) => setState(() => selectedUnit = value!),
              decoration: const InputDecoration(border: OutlineInputBorder()),
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ElevatedButton(
                  onPressed: calculateLength,
                  child: const Text(
                    "Calculate",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  style: ElevatedButton.styleFrom(foregroundColor: Colors.red),
                ),
                ElevatedButton(
                    onPressed: clearFields,
                    child: const Text(
                      "Clear",
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    style:
                        ElevatedButton.styleFrom(foregroundColor: Colors.red)),
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
