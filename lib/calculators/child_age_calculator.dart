import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ChildAgeCalculator extends StatefulWidget {
  const ChildAgeCalculator({super.key});

  @override
  State<ChildAgeCalculator> createState() => _ChildAgeCalculatorState();
}

class _ChildAgeCalculatorState extends State<ChildAgeCalculator> {
  String weightUnit = "kilograms";
  String gender = "Male";

  final TextEditingController ageYearsController = TextEditingController();
  final TextEditingController ageMonthsController = TextEditingController();
  final TextEditingController weightController = TextEditingController();
  final TextEditingController heightFeetController = TextEditingController();
  final TextEditingController heightInchesController = TextEditingController();

  String result = "";
  String percentile = "";

  // Simplified percentile calculation (placeholder logic)
  String calculatePercentile(
      double bmi, int ageYears, int ageMonths, String gender) {
    // Placeholder logic: This is not accurate and should be replaced with actual growth chart data.
    // For demonstration, we assume a linear relationship between BMI and percentile.
    if (gender == "Male") {
      if (bmi < 16) return "5th percentile (Underweight)";
      if (bmi >= 16 && bmi < 18.5) return "25th percentile (Healthy weight)";
      if (bmi >= 18.5 && bmi < 25) return "50th percentile (Healthy weight)";
      if (bmi >= 25 && bmi < 30) return "75th percentile (Overweight)";
      return "95th percentile (Obese)";
    } else {
      if (bmi < 15) return "5th percentile (Underweight)";
      if (bmi >= 15 && bmi < 18) return "25th percentile (Healthy weight)";
      if (bmi >= 18 && bmi < 24) return "50th percentile (Healthy weight)";
      if (bmi >= 24 && bmi < 29) return "75th percentile (Overweight)";
      return "95th percentile (Obese)";
    }
  }

  void calculateBMI() {
    // Parsing age values
    int ageYears = int.tryParse(ageYearsController.text) ?? 0;
    int ageMonths = int.tryParse(ageMonthsController.text) ?? 0;

    if (ageYears < 0 || ageMonths < 0 || ageMonths > 11) {
      setState(() {
        result = "Invalid Age! Please enter a valid age (months: 0-11).";
        percentile = "";
      });
      return;
    }

    // Parsing weight
    double weight = double.tryParse(weightController.text) ?? 0.0;
    if (weight <= 0) {
      setState(() {
        result = "Invalid weight! Please enter a valid weight.";
        percentile = "";
      });
      return;
    }
    if (weightUnit == "pounds") {
      weight *= 0.453592; // Convert pounds to kilograms
    }

    // Parsing height
    int heightFeet = int.tryParse(heightFeetController.text) ?? 0;
    int heightInches = int.tryParse(heightInchesController.text) ?? 0;

    if (heightFeet < 0 || heightInches < 0 || heightInches > 11) {
      setState(() {
        result = "Invalid height! Please enter valid height (inches: 0-11).";
        percentile = "";
      });
      return;
    }

    double heightInMeters = (heightFeet * 0.3048) + (heightInches * 0.0254);

    if (heightInMeters <= 0) {
      setState(() {
        result = "Invalid height! Please enter a valid height.";
        percentile = "";
      });
      return;
    }

    // Calculate BMI
    double bmi = weight / (heightInMeters * heightInMeters);

    // Calculate percentile
    String percentileResult =
        calculatePercentile(bmi, ageYears, ageMonths, gender);

    setState(() {
      result = "BMI = ${bmi.toStringAsFixed(1)}";
      percentile = "Percentile: $percentileResult";
    });
  }

  void clearFields() {
    setState(() {
      weightUnit = "kilograms";
      gender = "Male";

      ageYearsController.clear();
      ageMonthsController.clear();
      weightController.clear();
      heightFeetController.clear();
      heightInchesController.clear();

      result = "";
      percentile = "";
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(8),
      child: Column(
        children: [
          Center(
            child: Text(
              "Child BMI Calculator",
              style: TextStyle(
                  fontSize: 25, fontWeight: FontWeight.bold, color: Colors.red),
            ),
          ),
          const SizedBox(height: 20),
          Container(
            decoration: BoxDecoration(
              border: Border.all(color: Colors.red, width: 3),
              borderRadius: BorderRadius.circular(10),
            ),
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    const Text("Gender:", style: TextStyle(fontSize: 16)),
                    Radio<String>(
                      value: "Male",
                      groupValue: gender,
                      onChanged: (value) {
                        setState(() {
                          gender = value!;
                        });
                      },
                    ),
                    const Text("Male"),
                    Radio<String>(
                      value: "Female",
                      groupValue: gender,
                      onChanged: (value) {
                        setState(() {
                          gender = value!;
                        });
                      },
                    ),
                    const Text("Female"),
                  ],
                ),
                const SizedBox(height: 16),
                Row(
                  children: [
                    Flexible(
                      child: TextField(
                        controller: ageYearsController,
                        keyboardType: TextInputType.number,
                        decoration: const InputDecoration(
                          labelText: "Age (years)",
                          border: OutlineInputBorder(),
                        ),
                      ),
                    ),
                    const SizedBox(width: 16),
                    Flexible(
                      child: TextField(
                        controller: ageMonthsController,
                        keyboardType: TextInputType.number,
                        decoration: const InputDecoration(
                          labelText: "Age (months)",
                          border: OutlineInputBorder(),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                Row(
                  children: [
                    Flexible(
                      child: TextField(
                        controller: weightController,
                        keyboardType: TextInputType.number,
                        decoration: const InputDecoration(
                          labelText: "Weight",
                          border: OutlineInputBorder(),
                        ),
                      ),
                    ),
                    const SizedBox(width: 16),
                    Flexible(
                      child: DropdownButtonFormField<String>(
                        value: weightUnit,
                        items: const [
                          DropdownMenuItem(
                              value: "kilograms", child: Text("kilograms")),
                          DropdownMenuItem(
                              value: "pounds", child: Text("pounds")),
                        ],
                        onChanged: (value) {
                          setState(() {
                            weightUnit = value!;
                          });
                        },
                        decoration: const InputDecoration(
                          labelText: "Unit",
                          border: OutlineInputBorder(),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                Row(
                  children: [
                    Flexible(
                      child: TextField(
                        controller: heightFeetController,
                        keyboardType: TextInputType.number,
                        decoration: const InputDecoration(
                          labelText: "Height (feet)",
                          border: OutlineInputBorder(),
                        ),
                      ),
                    ),
                    const SizedBox(width: 16),
                    Flexible(
                      child: TextField(
                        controller: heightInchesController,
                        keyboardType: TextInputType.number,
                        decoration: const InputDecoration(
                          labelText: "Height (inches)",
                          border: OutlineInputBorder(),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
              ],
            ),
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ElevatedButton(
                onPressed: clearFields,
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.red,
                ),
                child: const Text("Clear",
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
              ),
              ElevatedButton(
                onPressed: calculateBMI,
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.red,
                ),
                child: const Text("Calculate",
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
              ),
            ],
          ),
          const SizedBox(height: 20),
          if (result.isNotEmpty)
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.blue, width: 3),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(result,
                      style: const TextStyle(
                          fontSize: 18, fontWeight: FontWeight.bold)),
                  Text(percentile, style: const TextStyle(fontSize: 16)),
                ],
              ),
            ),
        ],
      ),
    );
  }
}
