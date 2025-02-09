import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AdultAgeCalculator extends StatefulWidget {
  const AdultAgeCalculator({super.key});

  @override
  State<AdultAgeCalculator> createState() => _BMICalculatorState();
}

class _BMICalculatorState extends State<AdultAgeCalculator> {
  String weightUnit = "kilograms";
  final TextEditingController weightController = TextEditingController();
  final TextEditingController heightFeetController = TextEditingController();
  final TextEditingController heightInchesController = TextEditingController();
  String result = "";

  void calculateBMI() {
    double weight = double.tryParse(weightController.text) ?? 0.0;
    int heightFeet = int.tryParse(heightFeetController.text) ?? 0;
    int heightInches = int.tryParse(heightInchesController.text) ?? 0;

    if (weightUnit == "pounds") {
      weight *= 0.453592; // Convert pounds to kilograms
    }

    double heightInMeters = (heightFeet * 0.3048) + (heightInches * 0.0254);

    if (weight <= 0 || heightInMeters <= 0) {
      setState(() {
        result = "Invalid input! Please enter valid weight and height.";
      });
      return;
    }

    double bmi = weight / (heightInMeters * heightInMeters);

    double minNormalWeight = 18.5 * (heightInMeters * heightInMeters);
    double maxNormalWeight = 24.9 * (heightInMeters * heightInMeters);

    if (bmi < 18.5) {
      setState(() {
        result = "BMI = ${bmi.toStringAsFixed(1)}\n"
            "Underweight\n"
            "This BMI is below 18.5 and is considered underweight for an adult at this height.\n"
            "A normal weight range for your height is ${minNormalWeight.toStringAsFixed(2)} kg to ${maxNormalWeight.toStringAsFixed(2)} kg.\n"
            "A healthy BMI range for adults is 18.5 to 24.9.";
      });
    } else if (bmi >= 18.5 && bmi <= 24.9) {
      setState(() {
        result = "BMI = ${bmi.toStringAsFixed(1)}\n"
            "Normal\n"
            "This BMI is between 18.5 and 24.9, which is considered normal.\n"
            "A normal weight range for your height is ${minNormalWeight.toStringAsFixed(2)} kg to ${maxNormalWeight.toStringAsFixed(2)} kg.\n"
            "A healthy BMI range for adults is 18.5 to 24.9.";
      });
    } else if (bmi >= 25.0 && bmi <= 39.9) {
      setState(() {
        result = "BMI = ${bmi.toStringAsFixed(1)}\n"
            "Overweight\n"
            "This BMI is between 25.0 and 39.9 and is considered overweight.\n"
            "A normal weight range for your height is ${minNormalWeight.toStringAsFixed(2)} kg to ${maxNormalWeight.toStringAsFixed(2)} kg.\n"
            "A healthy BMI range for adults is 18.5 to 24.9.";
      });
    } else {
      setState(() {
        result = "BMI = ${bmi.toStringAsFixed(1)}\n"
            "Obese\n"
            "This BMI is 40.0 or higher and is considered obese.\n"
            "A normal weight range for your height is ${minNormalWeight.toStringAsFixed(2)} kg to ${maxNormalWeight.toStringAsFixed(2)} kg.\n"
            "A healthy BMI range for adults is 18.5 to 24.9.";
      });
    }
  }

  void clearFields() {
    setState(() {
      weightUnit = "kilograms";
      weightController.clear();
      heightFeetController.clear();
      heightInchesController.clear();
      result = "";
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Center(
            child: Text(
              "BMI Calculator",
              style: TextStyle(
                  fontSize: 25, fontWeight: FontWeight.bold, color: Colors.red),
            ),
          ),
          const SizedBox(height: 10),
          Container(
            decoration: BoxDecoration(
              border: Border.all(color: Colors.red, width: 3),
              borderRadius: BorderRadius.circular(10),
            ),
            padding: const EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
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
          const SizedBox(height: 15),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ElevatedButton(
                onPressed: clearFields,
                style: ElevatedButton.styleFrom(foregroundColor: Colors.red),
                child: const Text("Clear",
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
              ),
              ElevatedButton(
                onPressed: calculateBMI,
                style: ElevatedButton.styleFrom(foregroundColor: Colors.red),
                child: const Text("Calculate",
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
              ),
            ],
          ),
          const SizedBox(height: 15),
          Center(
            child: Text(
              "Result Show",
              style: TextStyle(
                  fontSize: 25, fontWeight: FontWeight.bold, color: Colors.red),
            ),
          ),
          const SizedBox(height: 10),
          if (result.isNotEmpty)
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.blue, width: 3),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(result,
                  style: const TextStyle(
                      fontSize: 18, fontWeight: FontWeight.bold)),
            ),
        ],
      ),
    );
  }
}
