import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../convertor_calculator/area_cal.dart';
import '../convertor_calculator/length_cal.dart';
import '../convertor_calculator/temp_cal.dart';
import '../convertor_calculator/weight_cal.dart';

class ConverterCal extends StatefulWidget {
  const ConverterCal({super.key});

  @override
  State<ConverterCal> createState() => _ConverterCalState();
}

class _ConverterCalState extends State<ConverterCal> {
  int selectedOption = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.blue,
        centerTitle: true,
        title: Text(
          "Converter Calculator",
          style: GoogleFonts.lobster(fontSize: 25, fontWeight: FontWeight.bold),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Center(
              child: Text(
                "Enter Your Choice...",
                style: const TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: Colors.red),
              ),
            ),
            const SizedBox(height: 10),
            Center(
              child: Container(
                height: 4,
                width: 350,
                color: Colors.blue,
              ),
            ),
            const SizedBox(height: 10),
            Wrap(
              spacing: 5, // Spacing between items
              alignment: WrapAlignment.spaceBetween,
              children: [
                SizedBox(
                  width: 170, // Set a fixed width for better alignment
                  child: ListTile(
                    title: const Text("Length"),
                    leading: Radio<int>(
                      value: 1,
                      groupValue: selectedOption,
                      activeColor: Colors.red,
                      onChanged: (int? value) {
                        setState(() {
                          selectedOption = value!;
                        });
                      },
                    ),
                  ),
                ),
                SizedBox(
                  width: 215,
                  child: ListTile(
                    title: const Text("Temperature"),
                    leading: Radio<int>(
                      value: 2,
                      groupValue: selectedOption,
                      activeColor: Colors.red,
                      onChanged: (int? value) {
                        setState(() {
                          selectedOption = value!;
                        });
                      },
                    ),
                  ),
                ),
                SizedBox(
                  width: 170,
                  child: ListTile(
                    title: const Text("Area"),
                    leading: Radio<int>(
                      value: 3,
                      groupValue: selectedOption,
                      activeColor: Colors.red,
                      onChanged: (int? value) {
                        setState(() {
                          selectedOption = value!;
                        });
                      },
                    ),
                  ),
                ),
                SizedBox(
                  width: 170,
                  child: ListTile(
                    title: const Text("Weight"),
                    leading: Radio<int>(
                      value: 4,
                      groupValue: selectedOption,
                      activeColor: Colors.red,
                      onChanged: (int? value) {
                        setState(() {
                          selectedOption = value!;
                        });
                      },
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Center(
              child: Container(
                height: 4,
                width: 350,
                color: Colors.blue,
              ),
            ),
            const SizedBox(height: 10),
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                border: Border.all(
                    color: Colors.red, style: BorderStyle.solid, width: 2),
                borderRadius: BorderRadius.circular(5),
                color: Colors.blueGrey.shade200,
              ),
              child: Column(
                children: [
                  if (selectedOption == 1)
                    LengthCalculator(),
                  if (selectedOption == 2)
                     TemperatureCalculator(),
                  if (selectedOption == 3)
                     AreaCalculator(),
                  if (selectedOption == 4)
                     WeightCalculator(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}