import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class GpaCalculator extends StatefulWidget {
  const GpaCalculator({super.key});

  @override
  State<GpaCalculator> createState() => _GpaCalculatorState();
}

class _GpaCalculatorState extends State<GpaCalculator> {
  final List<String> grades = List.filled(10, "A+");
  final List<String> types = List.filled(10, "TH");
  final List<TextEditingController> creditControllers = List.generate(10, (index) => TextEditingController());
  final List<TextEditingController> codeControllers = List.generate(10, (index) => TextEditingController());
  final List<TextEditingController> nameControllers = List.generate(10, (index) => TextEditingController());
  String result = "";

  void calculateGPA() {
    double totalCredits = 0;
    double totalGradePoints = 0;

    for (int i = 0; i < 10; i++) {
      final creditText = creditControllers[i].text;
      if (creditText.isEmpty) continue;

      final credit = double.tryParse(creditText) ?? 0;
      final grade = grades[i];

      final gradePoint = _getGradePoint(grade);
      totalGradePoints += gradePoint * credit;
      totalCredits += credit;
    }

    if (totalCredits == 0) {
      setState(() {
        result = "Invalid input";
      });
      return;
    }

    final gpa = totalGradePoints / totalCredits;
    setState(() {
      result = "Total Credit: ${totalCredits.toStringAsFixed(2)}"
          "\nAND "
          "\nYour GPA: ${gpa.toStringAsFixed(2)}";
    });
  }

  double _getGradePoint(String grade) {
    switch (grade) {
      case "A+":
        return 4.0;
      case "A":
        return 3.75;
      case "A-":
        return 3.50;
      case "B+":
        return 3.25;
      case "B":
        return 3.0;
      case "B-":
        return 2.75;
      case "C+":
        return 2.50;
      case "C":
        return 2.25;
      case "D":
        return 2.0;
      case "F":
        return 0.0;
      default:
        return 0.0;
    }
  }

  void clearFields() {
    setState(() {
      grades.fillRange(0, 10, "A+");
      types.fillRange(0, 10, "TH");
      for (final controller in creditControllers) {
        controller.clear();
      }
      for (final controller in codeControllers) {
        controller.clear();
      }
      for (final controller in nameControllers) {
        controller.clear();
      }
      result = "";
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.blue,
        title: Text(
          "GPA Calculator",
          style: GoogleFonts.lobster(fontSize: 25, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(left: 0.0,top: 10.0,right: 0.0,bottom: 10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Text(
                  "Calculate your GPA",
                  style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold, color: Colors.red),
                ),
              ),
              const SizedBox(height: 15),
              Center(
                child: Container(
                  height: 4,
                  width: 350,
                  color: Colors.blue,
                ),
              ),
              const SizedBox(height: 15),
              Container(
                padding: const EdgeInsets.all(5),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.blue, style: BorderStyle.solid, width: 2),
                  borderRadius: BorderRadius.circular(5),
                ),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        _buildHeader("Course\nCode"),
                        _buildHeader("Course\nName"),
                        _buildHeader("Course\nCredit"),
                        _buildHeader("Course\nType"),
                        _buildHeader("Course\nGrade"),
                      ],
                    ),
                    ...List.generate(10, (index) => _buildCourseRow(index)),
                  ],
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
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ElevatedButton(
                    onPressed: clearFields,
                    style: ElevatedButton.styleFrom(backgroundColor: Colors.blue, foregroundColor: Colors.red),
                    child: const Text("Clear", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
                  ),
                  ElevatedButton(
                    onPressed: calculateGPA,
                    style: ElevatedButton.styleFrom(backgroundColor: Colors.blue, foregroundColor: Colors.red),
                    child: const Text("Calculate", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Center(
                child: Text("Result Show", style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold, color: Colors.red)),
              ),
              const SizedBox(height: 10),
              if (result.isNotEmpty)
                Center(
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.red, style: BorderStyle.solid, width: 5),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    padding: EdgeInsets.all(5),
                    child: Text(result, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader(String text) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.red, style: BorderStyle.solid, width: 2),
        borderRadius: BorderRadius.circular(5),
      ),
      child: Padding(
        padding: const EdgeInsets.all(4.0),
        child: Text(text, style: const TextStyle(fontWeight: FontWeight.bold)),
      ),
    );
  }

  Widget _buildTextField(String hint, TextEditingController controller) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 0.0),
        child: TextField(
          controller: controller,
          decoration: InputDecoration(border: const OutlineInputBorder(), hintText: hint),
        ),
      ),
    );
  }

  Widget _buildGradeDropdown(int index) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 0.0),
        child: DropdownButtonFormField<String>(
          value: grades[index],
          items: const [
            DropdownMenuItem(value: "A+", child: Text("A+")),
            DropdownMenuItem(value: "A", child: Text("A")),
            DropdownMenuItem(value: "A-", child: Text("A-")),
            DropdownMenuItem(value: "B+", child: Text("B+")),
            DropdownMenuItem(value: "B", child: Text("B")),
            DropdownMenuItem(value: "B-", child: Text("B-")),
            DropdownMenuItem(value: "C+", child: Text("C+")),
            DropdownMenuItem(value: "C", child: Text("C")),
            DropdownMenuItem(value: "D", child: Text("D")),
            DropdownMenuItem(value: "F", child: Text("F")),
          ],
          onChanged: (value) {
            setState(() {
              grades[index] = value!;
            });
          },
          decoration: const InputDecoration(border: OutlineInputBorder()),
        ),
      ),
    );
  }

  Widget _buildTypeDropdown(int index) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 0.0),
        child: DropdownButtonFormField<String>(
          value: types[index],
          items: const [
            DropdownMenuItem(value: "TH", child: Text("TH")),
            DropdownMenuItem(value: "LB", child: Text("LB")),
          ],
          onChanged: (value) {
            setState(() {
              types[index] = value!;
            });
          },
          decoration: const InputDecoration(border: OutlineInputBorder()),
        ),
      ),
    );
  }

  Widget _buildCourseRow(int index) {
    return Column(
      children: [
        const SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _buildTextField("Code", codeControllers[index]),
            _buildTextField("Name", nameControllers[index]),
            _buildTextField("Credit", creditControllers[index]),
            _buildTypeDropdown(index),
            _buildGradeDropdown(index),
          ],
        ),
      ],
    );
  }
}