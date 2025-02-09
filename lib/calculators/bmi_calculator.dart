import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'adult_age_calculator.dart';
import 'child_age_calculator.dart';

class BmiCalculator extends StatefulWidget {
  const BmiCalculator({super.key});

  @override
  State<BmiCalculator> createState() => _BmiCalculatorState();
}

class _BmiCalculatorState extends State<BmiCalculator> {
  String ageGroup = "Child Age 2-18";

  void clearFields() {
    setState(() {
      ageGroup = "Child Age 2-19";
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.blue,
        title: Text(
          "BMI Calculator",
          style: GoogleFonts.lobster(fontSize: 25, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding:
              const EdgeInsets.only(left: 10, right: 10, top: 20, bottom: 20),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                DropdownButtonFormField<String>(
                  value: ageGroup,
                  items: const [
                    DropdownMenuItem(
                        value: "Child Age 2-18", child: Text("Child Age 2-18")),
                    DropdownMenuItem(
                        value: "Adult Age 18+", child: Text("Adult Age 18+")),
                  ],
                  onChanged: (value) {
                    setState(() {
                      ageGroup = value!;
                    });
                  },
                  decoration: const InputDecoration(
                    labelText: "Calculate BMI for",
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 16),
                if (ageGroup == "Child Age 2-18") ChildAgeCalculator(),
                if (ageGroup == "Adult Age 18+") AdultAgeCalculator(),
                const SizedBox(height: 16),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
