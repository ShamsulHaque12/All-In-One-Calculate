import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class WeightCalculator extends StatefulWidget {
  const WeightCalculator({super.key});

  @override
  State<WeightCalculator> createState() => _WeightCalculatorState();
}

class _WeightCalculatorState extends State<WeightCalculator> {
  final List<String> weightUnits = [
    "Kilogram",
    "Gram",
    "Pound",
    "Milligram",
    "Metric Ton",
    "Ounce"
  ];
  String selectedUnit = "Kilogram";
  final TextEditingController weightController = TextEditingController();
  String result = "";

  void calculateWeight() {
    final weight = double.tryParse(weightController.text);
    if (weight == null || weight == 0) {
      setState(() => result = "Invalid input");
      return;
    }

    // Convert input weight to Kilograms
    double weightInKilograms;
    if (selectedUnit == "Gram") {
      weightInKilograms = weight / 1000;
    } else if (selectedUnit == "Pound")
      weightInKilograms = weight / 2.20462;
    else if (selectedUnit == "Milligram")
      weightInKilograms = weight / 1000000; // Correct conversion factor
    else if (selectedUnit == "Metric Ton")
      weightInKilograms = weight * 1000; // Correct conversion factor
    else if (selectedUnit == "Ounce")
      weightInKilograms = weight / 35.274;
    else
      weightInKilograms = weight;

    String output = "";
    for (int i = 0; i < weightUnits.length; i++) {
      String unit = weightUnits[i];
      double convertedValue;

      // Conversion from Kilograms to other units
      if (unit == "Gram") {
        convertedValue = weightInKilograms * 1000;
      } else if (unit == "Pound")
        convertedValue = weightInKilograms * 2.20462;
      else if (unit == "Milligram")
        convertedValue =
            weightInKilograms * 1000000; // Correct conversion factor
      else if (unit == "Metric Ton")
        convertedValue = weightInKilograms * 0.001; // Correct conversion factor
      else if (unit == "Ounce")
        convertedValue = weightInKilograms * 35.274;
      else
        convertedValue = weightInKilograms;

      // Round to 2 decimal places
      convertedValue = double.parse(convertedValue.toStringAsFixed(2));
      output += "$convertedValue $unit\n";
    }

    setState(() {
      result = output;
    });
  }

  void clearFields() {
    setState(() {
      selectedUnit = "Kilogram";
      weightController.clear();
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
              child: Text("Weight Calculator",
                  style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                      color: Colors.red)),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: weightController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: "Enter Weight",
              ),
            ),
            const SizedBox(height: 10),
            DropdownButtonFormField<String>(
              value: selectedUnit,
              items: [
                DropdownMenuItem(value: "Kilogram", child: Text("Kilogram")),
                DropdownMenuItem(value: "Gram", child: Text("Gram")),
                DropdownMenuItem(value: "Pound", child: Text("Pound")),
                DropdownMenuItem(value: "Milligram", child: Text("Milligram")),
                DropdownMenuItem(
                    value: "Metric Ton", child: Text("Metric Ton")),
                DropdownMenuItem(value: "Ounce", child: Text("Ounce")),
              ],
              onChanged: (value) => setState(() => selectedUnit = value!),
              decoration: const InputDecoration(border: OutlineInputBorder()),
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ElevatedButton(
                  onPressed: calculateWeight,
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
