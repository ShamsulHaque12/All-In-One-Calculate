import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:math';

class AreaCalculator extends StatefulWidget {
  const AreaCalculator({super.key});

  @override
  State<AreaCalculator> createState() => _AreaCalculatorState();
}

class _AreaCalculatorState extends State<AreaCalculator> {
  final List<String> lengthUnits = [
    "Meter",
    "Kilometer",
    "Centimeter",
    "Inch",
    "Feet",
    "Mile",
  ];
  String selectedLengthUnit = "Meter";
  String selectedWidthUnit = "Meter";
  String selectedWidth2Unit = "Meter";

  final TextEditingController rectangleLengthController =
      TextEditingController();
  final TextEditingController rectangleWidthController =
      TextEditingController();

  final TextEditingController triangleSideAController = TextEditingController();
  final TextEditingController triangleSideBController = TextEditingController();
  final TextEditingController triangleSideCController = TextEditingController();

  final TextEditingController trapezoidBase1Controller =
      TextEditingController();
  final TextEditingController trapezoidBase2Controller =
      TextEditingController();
  final TextEditingController trapezoidHeightController =
      TextEditingController();

  final TextEditingController circleRadiusController = TextEditingController();

  final TextEditingController parallelogramBase1Controller =
      TextEditingController();
  final TextEditingController parallelogramHeightController =
      TextEditingController();

  String rectangleResult = "";
  String triangleResult = "";
  String trapezoidResult = "";
  String circleResult = "";
  String parallelogramResult = "";

  // Function to convert a value to meters
  double convertToMeters(double value, String unit) {
    switch (unit) {
      case "Kilometer":
        return value * 1000;
      case "Centimeter":
        return value / 100;
      case "Inch":
        return value * 0.0254;
      case "Feet":
        return value * 0.3048;
      case "Mile":
        return value * 1609.34;
      default: // Meter
        return value;
    }
  }

  // Function to calculate the area
  void calculateRectangle() {
    double length = double.tryParse(rectangleLengthController.text) ?? 0.0;
    double width = double.tryParse(rectangleWidthController.text) ?? 0.0;

    if (length <= 0 || width <= 0) {
      setState(() {
        rectangleResult = "Please enter valid length and width values.";
      });
      return;
    }

    double lengthInMeters = convertToMeters(length, selectedLengthUnit);
    double widthInMeters = convertToMeters(width, selectedWidthUnit);

    double rectangle = lengthInMeters * widthInMeters;

    setState(() {
      rectangleResult =
          "Rectangle Area: ${rectangle.toStringAsFixed(2)} square meters";
    });
  }

  void calculateTriangle() {
    double sideA = double.tryParse(triangleSideAController.text) ?? 0.0;
    double sideB = double.tryParse(triangleSideBController.text) ?? 0.0;
    double sideC = double.tryParse(triangleSideCController.text) ?? 0.0;

    // Check for valid inputs
    if (sideA <= 0 || sideB <= 0 || sideC <= 0) {
      setState(() {
        triangleResult = "Please enter valid positive values for all sides.";
      });
      return;
    }

    // Convert all sides to meters
    double sideAInMeters = convertToMeters(sideA, selectedLengthUnit);
    double sideBInMeters = convertToMeters(sideB, selectedWidthUnit);
    double sideCInMeters = convertToMeters(sideC, selectedWidth2Unit);

    // Check if the sides form a valid triangle
    if (!isValidTriangle(sideAInMeters, sideBInMeters, sideCInMeters)) {
      setState(() {
        triangleResult =
            "Invalid triangle! The sum of any two sides must be greater than the third side.";
      });
      return;
    }

    // Calculate semi-perimeter
    double s = (sideAInMeters + sideBInMeters + sideCInMeters) / 2;

    // Calculate area using Heron's formula
    double triangle = sqrt(
        s * (s - sideAInMeters) * (s - sideBInMeters) * (s - sideCInMeters));

    setState(() {
      triangleResult =
          "Triangle Area: ${triangle.toStringAsFixed(2)} square meters";
    });
  }

  void calculateTrapezoid() {
    double base1 = double.tryParse(trapezoidBase1Controller.text) ?? 0.0;
    double base2 = double.tryParse(trapezoidBase2Controller.text) ?? 0.0;
    double height = double.tryParse(trapezoidHeightController.text) ?? 0.0;

    // Check for valid inputs
    if (base1 <= 0 || base2 <= 0 || height <= 0) {
      setState(() {
        trapezoidResult = "Please enter valid positive values for all sides.";
      });
      return;
    }

    // Convert all sides to meters
    double base1InMeters = convertToMeters(base1, selectedLengthUnit);
    double base2InMeters = convertToMeters(base2, selectedWidthUnit);
    double heightInMeters = convertToMeters(height, selectedWidth2Unit);

    double trapezoid = ((base1InMeters + base2InMeters) / 2) * heightInMeters;

    setState(() {
      trapezoidResult =
          "Trapezoid Area: ${trapezoid.toStringAsFixed(2)} square meters";
    });
  }

  void calculateCircle() {
    double radius = double.tryParse(circleRadiusController.text) ?? 0.0;
    if (radius <= 0) {
      setState(() {
        circleResult = "Please enter a valid positive radius.";
      });
      return;
    }
    double circle = pi * radius * radius;
    setState(() {
      circleResult = "Circle Area: ${circle.toStringAsFixed(2)} square meters";
    });
  }

  void calculateParallelogram() {
    double base1 = double.tryParse(parallelogramBase1Controller.text) ?? 0.0;
    double height = double.tryParse(parallelogramHeightController.text) ?? 0.0;
    if (base1 <= 0 || height <= 0) {
      setState(() {
        parallelogramResult =
            "Please enter valid positive values for all sides.";
      });
      return;
    }
    double parallelogram = base1 * height;
    setState(() {
      parallelogramResult =
          "Parallelogram Area: ${parallelogram.toStringAsFixed(2)} square meters";
    });
  }

  // Function to check if the sides form a valid triangle
  bool isValidTriangle(double sideA, double sideB, double sideC) {
    return (sideA + sideB > sideC) &&
        (sideA + sideC > sideB) &&
        (sideB + sideC > sideA);
  }

  void clearRectangleFields() {
    setState(() {
      rectangleLengthController.clear();
      rectangleWidthController.clear();
      rectangleResult = "";
    });
  }

  void clearTriangleFields() {
    setState(() {
      triangleSideAController.clear();
      triangleSideBController.clear();
      triangleSideCController.clear();
      triangleResult = "";
    });
  }

  void clearTrapezoidFields() {
    setState(() {
      trapezoidBase1Controller.clear();
      trapezoidBase2Controller.clear();
      trapezoidHeightController.clear();
      trapezoidResult = "";
    });
  }

  void clearCircleFields() {
    setState(() {
      circleRadiusController.clear();
      circleResult = "";
    });
  }

  void clearParallelogramFields() {
    setState(() {
      parallelogramBase1Controller.clear();
      parallelogramHeightController.clear();
      parallelogramResult = "";
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(5),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Text(
                "Area Calculator",
                style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                    color: Colors.red),
              ),
            ),
            const SizedBox(height: 20),
            Container(
              decoration: BoxDecoration(
                border: Border.all(color: Colors.blue, width: 2),
                borderRadius: BorderRadius.circular(10),
              ),
              padding: const EdgeInsets.all(10),
              child: Column(
                children: [
                  Center(
                    child: Text(
                      "Rectangle",
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.red),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: TextField(
                          controller: rectangleLengthController,
                          keyboardType: TextInputType.number,
                          decoration: const InputDecoration(
                            labelText: "Length",
                            border: OutlineInputBorder(),
                          ),
                        ),
                      ),
                      const SizedBox(width: 5),
                      Expanded(
                        child: DropdownButtonFormField<String>(
                          value: selectedLengthUnit,
                          items: lengthUnits
                              .map((unit) => DropdownMenuItem(
                                    value: unit,
                                    child: Text(unit),
                                  ))
                              .toList(),
                          onChanged: (value) =>
                              setState(() => selectedLengthUnit = value!),
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: TextField(
                          controller: rectangleWidthController,
                          keyboardType: TextInputType.number,
                          decoration: const InputDecoration(
                            labelText: "Width",
                            border: OutlineInputBorder(),
                          ),
                        ),
                      ),
                      const SizedBox(width: 5),
                      Expanded(
                        child: DropdownButtonFormField<String>(
                          value: selectedWidthUnit,
                          items: lengthUnits
                              .map((unit) => DropdownMenuItem(
                                    value: unit,
                                    child: Text(unit),
                                  ))
                              .toList(),
                          onChanged: (value) =>
                              setState(() => selectedWidthUnit = value!),
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      ElevatedButton(
                        onPressed: clearRectangleFields,
                        style: ElevatedButton.styleFrom(
                          foregroundColor: Colors.red,
                        ),
                        child: const Text(
                          "Clear",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      ElevatedButton(
                        onPressed: calculateRectangle,
                        style: ElevatedButton.styleFrom(
                          foregroundColor: Colors.red,
                        ),
                        child: const Text(
                          "Calculate",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  if (rectangleResult.isNotEmpty)
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.green, width: 2),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Text(
                        rectangleResult,
                        style: const TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                    ),
                ],
              ),
            ),
            SizedBox(
              height: 15,
            ),
            Container(
              decoration: BoxDecoration(
                border: Border.all(color: Colors.blue, width: 2),
                borderRadius: BorderRadius.circular(10),
              ),
              padding: const EdgeInsets.all(10),
              child: Column(
                children: [
                  Center(
                    child: Text(
                      "Triangle",
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.red),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: TextField(
                          controller: triangleSideAController,
                          keyboardType: TextInputType.number,
                          decoration: const InputDecoration(
                            labelText: "Side A",
                            border: OutlineInputBorder(),
                          ),
                        ),
                      ),
                      const SizedBox(width: 5),
                      Expanded(
                        child: DropdownButtonFormField<String>(
                          value: selectedLengthUnit,
                          items: lengthUnits
                              .map((unit) => DropdownMenuItem(
                                    value: unit,
                                    child: Text(unit),
                                  ))
                              .toList(),
                          onChanged: (value) =>
                              setState(() => selectedLengthUnit = value!),
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: TextField(
                          controller: triangleSideBController,
                          keyboardType: TextInputType.number,
                          decoration: const InputDecoration(
                            labelText: "Side B",
                            border: OutlineInputBorder(),
                          ),
                        ),
                      ),
                      const SizedBox(width: 5),
                      Expanded(
                        child: DropdownButtonFormField<String>(
                          value: selectedWidthUnit,
                          items: lengthUnits
                              .map((unit) => DropdownMenuItem(
                                    value: unit,
                                    child: Text(unit),
                                  ))
                              .toList(),
                          onChanged: (value) =>
                              setState(() => selectedWidthUnit = value!),
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: TextField(
                          controller: triangleSideCController,
                          keyboardType: TextInputType.number,
                          decoration: const InputDecoration(
                            labelText: "Side C",
                            border: OutlineInputBorder(),
                          ),
                        ),
                      ),
                      const SizedBox(width: 5),
                      Expanded(
                        child: DropdownButtonFormField<String>(
                          value: selectedWidth2Unit,
                          items: lengthUnits
                              .map((unit) => DropdownMenuItem(
                                    value: unit,
                                    child: Text(unit),
                                  ))
                              .toList(),
                          onChanged: (value) =>
                              setState(() => selectedWidth2Unit = value!),
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      ElevatedButton(
                        onPressed: clearTriangleFields,
                        style: ElevatedButton.styleFrom(
                          foregroundColor: Colors.red,
                        ),
                        child: const Text(
                          "Clear",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      ElevatedButton(
                        onPressed: calculateTriangle,
                        style: ElevatedButton.styleFrom(
                          foregroundColor: Colors.red,
                        ),
                        child: const Text(
                          "Calculate",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  if (triangleResult.isNotEmpty)
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.green, width: 2),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Text(
                        triangleResult,
                        style: const TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                    ),
                ],
              ),
            ),
            SizedBox(
              height: 15,
            ),
            Container(
              decoration: BoxDecoration(
                border: Border.all(color: Colors.blue, width: 2),
                borderRadius: BorderRadius.circular(10),
              ),
              padding: const EdgeInsets.all(10),
              child: Column(
                children: [
                  Center(
                    child: Text(
                      "Trapezoid",
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.red),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: TextField(
                          controller: trapezoidBase1Controller,
                          keyboardType: TextInputType.number,
                          decoration: const InputDecoration(
                            labelText: "Base(b1)",
                            border: OutlineInputBorder(),
                          ),
                        ),
                      ),
                      const SizedBox(width: 5),
                      Expanded(
                        child: DropdownButtonFormField<String>(
                          value: selectedLengthUnit,
                          items: lengthUnits
                              .map((unit) => DropdownMenuItem(
                                    value: unit,
                                    child: Text(unit),
                                  ))
                              .toList(),
                          onChanged: (value) =>
                              setState(() => selectedLengthUnit = value!),
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: TextField(
                          controller: trapezoidBase2Controller,
                          keyboardType: TextInputType.number,
                          decoration: const InputDecoration(
                            labelText: "Base(b2)",
                            border: OutlineInputBorder(),
                          ),
                        ),
                      ),
                      const SizedBox(width: 5),
                      Expanded(
                        child: DropdownButtonFormField<String>(
                          value: selectedWidthUnit,
                          items: lengthUnits
                              .map((unit) => DropdownMenuItem(
                                    value: unit,
                                    child: Text(unit),
                                  ))
                              .toList(),
                          onChanged: (value) =>
                              setState(() => selectedWidthUnit = value!),
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: TextField(
                          controller: trapezoidHeightController,
                          keyboardType: TextInputType.number,
                          decoration: const InputDecoration(
                            labelText: "Height(h)",
                            border: OutlineInputBorder(),
                          ),
                        ),
                      ),
                      const SizedBox(width: 5),
                      Expanded(
                        child: DropdownButtonFormField<String>(
                          value: selectedWidth2Unit,
                          items: lengthUnits
                              .map((unit) => DropdownMenuItem(
                                    value: unit,
                                    child: Text(unit),
                                  ))
                              .toList(),
                          onChanged: (value) =>
                              setState(() => selectedWidth2Unit = value!),
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      ElevatedButton(
                        onPressed: clearTrapezoidFields,
                        style: ElevatedButton.styleFrom(
                          foregroundColor: Colors.red,
                        ),
                        child: const Text(
                          "Clear",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      ElevatedButton(
                        onPressed: calculateTrapezoid,
                        style: ElevatedButton.styleFrom(
                          foregroundColor: Colors.red,
                        ),
                        child: const Text(
                          "Calculate",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  if (trapezoidResult.isNotEmpty)
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.green, width: 2),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Text(
                        trapezoidResult,
                        style: const TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                    ),
                ],
              ),
            ),
            SizedBox(
              height: 15,
            ),
            Container(
              decoration: BoxDecoration(
                border: Border.all(color: Colors.blue, width: 2),
                borderRadius: BorderRadius.circular(10),
              ),
              padding: const EdgeInsets.all(10),
              child: Column(
                children: [
                  Center(
                    child: Text(
                      "Circle",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                        color: Colors.red,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: TextField(
                          controller: circleRadiusController,
                          keyboardType: TextInputType.number,
                          decoration: const InputDecoration(
                            labelText: "Radius",
                            border: OutlineInputBorder(),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Expanded(
                        child: DropdownButtonFormField<String>(
                          value: selectedLengthUnit,
                          items: lengthUnits
                              .map((unit) => DropdownMenuItem(
                                    value: unit,
                                    child: Text(unit),
                                  ))
                              .toList(),
                          onChanged: (value) =>
                              setState(() => selectedLengthUnit = value!),
                          decoration: const InputDecoration(
                              border: OutlineInputBorder()),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      ElevatedButton(
                        onPressed: clearCircleFields,
                        style: ElevatedButton.styleFrom(
                            foregroundColor: Colors.red),
                        child: const Text(
                          "Clear",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      ElevatedButton(
                        onPressed: calculateCircle,
                        style: ElevatedButton.styleFrom(
                            foregroundColor: Colors.red),
                        child: const Text(
                          "Calculate",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  if (circleResult.isNotEmpty)
                    Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.green, width: 2),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Text(
                        circleResult,
                        style: const TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                    ),
                ],
              ),
            ),
            SizedBox(
              height: 15,
            ),
            Container(
              decoration: BoxDecoration(
                border: Border.all(color: Colors.blue, width: 2),
                borderRadius: BorderRadius.circular(10),
              ),
              padding: const EdgeInsets.all(10),
              child: Column(
                children: [
                  Center(
                    child: Text(
                      "Parallelogram",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.red,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: TextField(
                          controller: parallelogramBase1Controller,
                          keyboardType: TextInputType.number,
                          decoration: const InputDecoration(
                            labelText: "Height",
                            border: OutlineInputBorder(),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Expanded(
                        child: DropdownButtonFormField<String>(
                          value: selectedLengthUnit,
                          items: lengthUnits
                              .map((unit) => DropdownMenuItem(
                                    value: unit,
                                    child: Text(unit),
                                  ))
                              .toList(),
                          onChanged: (value) =>
                              setState(() => selectedLengthUnit = value!),
                          decoration: const InputDecoration(
                              border: OutlineInputBorder()),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: TextField(
                          controller: parallelogramHeightController,
                          keyboardType: TextInputType.number,
                          decoration: const InputDecoration(
                            labelText: "Width",
                            border: OutlineInputBorder(),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Expanded(
                        child: DropdownButtonFormField<String>(
                          value: selectedLengthUnit,
                          items: lengthUnits
                              .map((unit) => DropdownMenuItem(
                                    value: unit,
                                    child: Text(unit),
                                  ))
                              .toList(),
                          onChanged: (value) =>
                              setState(() => selectedLengthUnit = value!),
                          decoration: const InputDecoration(
                              border: OutlineInputBorder()),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      ElevatedButton(
                        onPressed: clearParallelogramFields,
                        style: ElevatedButton.styleFrom(
                          foregroundColor: Colors.red,
                        ),
                        child: const Text(
                          "Clear",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      ElevatedButton(
                        onPressed: calculateParallelogram,
                        style: ElevatedButton.styleFrom(
                          foregroundColor: Colors.red,
                        ),
                        child: const Text(
                          "Calculate",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  if (parallelogramResult.isNotEmpty)
                    Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.green, width: 2),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      padding: const EdgeInsets.all(10),
                      child: Text(
                        parallelogramResult,
                        style: const TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
