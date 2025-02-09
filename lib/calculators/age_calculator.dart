import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AgeCalculator extends StatefulWidget {
  const AgeCalculator({super.key});

  @override
  State<AgeCalculator> createState() => _AgeCalculatorState();
}

class _AgeCalculatorState extends State<AgeCalculator> {
  final TextEditingController fromDate = TextEditingController();
  final TextEditingController fromYear = TextEditingController();
  final TextEditingController toDate = TextEditingController();
  final TextEditingController toYear = TextEditingController();
  final TextEditingController fromMonth = TextEditingController();
  final TextEditingController toMonth = TextEditingController();

  String result = "";

  void calculateAge() {
    int birthDate = int.tryParse(fromDate.text) ?? 0;
    int birthMonth = int.tryParse(fromMonth.text) ?? 0;
    int birthYear = int.tryParse(fromYear.text) ?? 0;
    int currentDate = int.tryParse(toDate.text) ?? 0;
    int currentMonth = int.tryParse(toMonth.text) ?? 0;
    int currentYear = int.tryParse(toYear.text) ?? 0;

    int years = currentYear - birthYear;
    int months = currentMonth - birthMonth;
    int days = currentDate - birthDate;

    if (days < 0) {
      months--;
      days += 30;
    }

    if (months < 0) {
      years--;
      months += 12;
    }

    int totalMonths = years * 12 + months;
    int totalDays = (totalMonths * 30.436875).round();
    int totalWeeks = totalDays ~/ 7;
    int remainingDays = totalDays % 7;
    int totalHours = totalDays * 24;
    int totalMinutes = totalHours * 60;
    int totalSeconds = totalMinutes * 60;

    setState(() {
      result = "$years years, $months months, $days days, "
          "\nOR $totalMonths months, $days days"
          "\nOR $totalWeeks weeks, $remainingDays days"
          "\nOR $totalDays days,"
          "\nOR $totalHours hours, "
          "\nOR $totalMinutes minutes, "
          "\nOR $totalSeconds seconds";
    });
  }

  void clearFields() {
    setState(() {
      fromDate.clear();
      fromMonth.clear();
      fromYear.clear();
      toDate.clear();
      toMonth.clear();
      toYear.clear();
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
          "Age Calculator",
          style: GoogleFonts.lobster(fontSize: 25, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Text(
                  "Calculate Your Age To Given Date.....",
                  style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                      color: Colors.red),
                ),
              ),
              SizedBox(height: 15),
              Center(
                child: Container(
                  height: 4,
                  width: 350,
                  color: Colors.blue,
                ),
              ),
              SizedBox(height: 15),
              Row(
                children: [
                  Text("Your \nBirth Date \n(From Date):"),
                  SizedBox(width: 15),
                  Flexible(
                    child: TextField(
                      controller: fromDate,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        labelText: "Date",
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),
                  SizedBox(width: 15),
                  Flexible(
                    child: TextField(
                      controller: fromMonth,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        labelText: "Months",
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),
                  SizedBox(width: 15),
                  Flexible(
                    child: TextField(
                      controller: fromYear,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        labelText: "Year",
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 15),
              Row(
                children: [
                  Text("Current Date \n(To Date):"),
                  SizedBox(width: 15),
                  Flexible(
                    child: TextField(
                      controller: toDate,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        labelText: "Date",
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),
                  SizedBox(width: 15),
                  Flexible(
                    child: TextField(
                      controller: toMonth,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        labelText: "Months",
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),
                  SizedBox(width: 15),
                  Flexible(
                    child: TextField(
                      controller: toYear,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        labelText: "Year",
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ElevatedButton(
                    onPressed: clearFields,
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue,
                        foregroundColor: Colors.red),
                    child: Text(
                      "CLEAR",
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: calculateAge,
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue,
                        foregroundColor: Colors.red),
                    child: Text(
                      "CALCULATE",
                      style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                  )
                ],
              ),
              SizedBox(height: 10),
              Center(
                child: Text(
                  "Result Show",
                  style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      color: Colors.red),
                ),
              ),
              SizedBox(height: 20),
              if (result.isNotEmpty)
                Center(
                  child: Container(
                    padding: EdgeInsets.all(15),
                    decoration: BoxDecoration(
                        border: Border.all(
                            color: Colors.red,
                            style: BorderStyle.solid,
                            width: 4),
                        borderRadius: BorderRadius.circular(10)),
                    child: Text(
                      result,
                      style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
