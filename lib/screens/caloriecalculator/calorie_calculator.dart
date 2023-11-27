import 'package:flutter/material.dart';

class CalorieCalculatorScreen extends StatefulWidget {
  const CalorieCalculatorScreen({super.key});
  @override
  State<CalorieCalculatorScreen> createState() =>
      _CalorieCalculatorScreenState();
}

class _CalorieCalculatorScreenState extends State<CalorieCalculatorScreen> {
  double currentWeight = 0.0;
  double goalWeight = 0.0;
  double height = 160.0; // Default height
  int age = 25; // Default age
  double activityFactor = 1.2; // Default to sedentary
  int weeksToAchieveGoal = 1;
  double maintenanceCalories = 0.0;
  double goalCalories = 0.0;
  String calculationMessage = '';
  bool isMale = true; // Default to male

  final _formKey = GlobalKey<FormState>();

  void calculateCalories() {
    setState(() {
      calculationMessage = 'Calculating...';
    });

    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      // Calculate BMR using Harris-Benedict equation
      double bmr;
      if (isMale) {
        bmr = 88.362 +
            (13.397 * currentWeight) +
            (4.799 * height) -
            (5.677 * age);
      } else {
        bmr = 447.593 +
            (9.247 * currentWeight) +
            (3.098 * height) -
            (4.331 * age);
      }

      // Calculate TDEE
      double tdee = bmr * activityFactor;

      // Calculate caloric deficit/surplus based on goal weight
      double weightDifference = goalWeight - currentWeight;
      goalCalories =
          tdee + (weightDifference * 7700) / (weeksToAchieveGoal * 7);

      setState(() {
        maintenanceCalories = tdee;
        calculationMessage = 'Calculation complete';
      });
    } else {
      setState(() {
        calculationMessage = 'Invalid input. Please enter valid values.';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Calorie Calculator'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: screenHeight * 0.025),
                CustomTextFormField(
                  labelText: 'Current Weight (kg)',
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your current weight.';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    currentWeight = double.parse(value!);
                  },
                ),
                SizedBox(height: screenHeight * 0.025),
                CustomTextFormField(
                  labelText: 'Goal Weight (kg)',
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your goal weight.';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    goalWeight = double.parse(value!);
                  },
                ),
                SizedBox(height: screenHeight * 0.025),
                CustomTextFormField(
                  labelText: 'Height (cm)',
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your height.';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    height = double.parse(value!);
                  },
                ),
                SizedBox(height: screenHeight * 0.025),
                CustomTextFormField(
                  labelText: 'Age',
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your age.';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    age = int.parse(value!);
                  },
                ),
                SizedBox(height: screenHeight * 0.025),
                CustomDropdown(
                  value: activityFactor,
                  onChanged: (value) {
                    setState(() {
                      activityFactor = value!;
                    });
                  },
                  items: const [
                    DropdownMenuItem(value: 1.2, child: Text('Sedentary')),
                    DropdownMenuItem(
                        value: 1.375, child: Text('Lightly active')),
                    DropdownMenuItem(
                        value: 1.55, child: Text('Moderately active')),
                    DropdownMenuItem(value: 1.725, child: Text('Very active')),
                    DropdownMenuItem(value: 1.9, child: Text('Extra active')),
                  ],
                  hintText: 'Select Activity Level',
                ),
                SizedBox(height: screenHeight * 0.025),
                CustomDropdown(
                  value: isMale,
                  onChanged: (value) {
                    setState(() {
                      isMale = value!;
                    });
                  },
                  items: const [
                    DropdownMenuItem(
                      value: true,
                      child: Text('Male'),
                    ),
                    DropdownMenuItem(
                      value: false,
                      child: Text('Female'),
                    ),
                  ],
                  hintText: 'Select Gender',
                ),
                SizedBox(height: screenHeight * 0.025),
                CustomDropdown(
                  value: weeksToAchieveGoal,
                  onChanged: (value) {
                    setState(() {
                      weeksToAchieveGoal = value!;
                    });
                  },
                  items: List.generate(
                    16,
                    (index) => DropdownMenuItem(
                      value: index + 1,
                      child: Text('${index + 1} weeks'),
                    ),
                  ),
                  hintText: 'Select Time Period',
                ),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: calculateCalories,
                  child: const Padding(
                    padding: EdgeInsets.all(10.0),
                    child: Text(
                      'Calculate Calories',
                      style:
                          TextStyle(fontSize: 17, fontWeight: FontWeight.w700),
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                Container(
                  padding: const EdgeInsets.all(16),
                  margin: const EdgeInsets.symmetric(vertical: 16),
                  decoration: BoxDecoration(
                    color: Colors.deepPurple,
                    borderRadius: BorderRadius.circular(15),
                    gradient: const LinearGradient(colors: [
                      Color.fromARGB(255, 214, 208, 225),
                      Color.fromARGB(255, 205, 188, 237)
                    ], begin: Alignment.topLeft, end: Alignment.bottomRight),
                    boxShadow: [
                      BoxShadow(
                          color: Colors.grey.shade400,
                          offset: const Offset(2.0, 2.0),
                          blurRadius: 10,
                          spreadRadius: 1),
                      BoxShadow(
                          color: Colors.grey.shade400,
                          offset: const Offset(-2.0, -2.0),
                          blurRadius: 10,
                          spreadRadius: 1),
                    ],
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        const Text(
                          'Maintenance Calories:',
                          style: TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          '${maintenanceCalories.toStringAsFixed(2)} kcal',
                          style: const TextStyle(
                              fontSize: 22, fontWeight: FontWeight.w700),
                        ),

                        const SizedBox(
                            height: 16), // Add spacing between sections

                        const Text(
                          'Goal Calories:',
                          style: TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          '${goalCalories.toStringAsFixed(2)} kcal',
                          style: const TextStyle(
                              fontWeight: FontWeight.w700, fontSize: 22),
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class CustomTextFormField extends StatelessWidget {
  final String labelText;
  final void Function(String?)? onSaved;
  final String? Function(String?)? validator;

  const CustomTextFormField({
    super.key,
    required this.labelText,
    this.onSaved,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      keyboardType: TextInputType.number,
      decoration: InputDecoration(
        labelText: labelText,
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(
            width: 1,
            color: Color.fromARGB(255, 210, 196, 234),
            style: BorderStyle.solid,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(
            width: 1,
            color: Color.fromARGB(255, 229, 225, 235),
            style: BorderStyle.solid,
          ),
        ),
      ),
      validator: validator,
      onSaved: onSaved != null ? (value) => onSaved!(value!) : null,
    );
  }
}

class CustomDropdown<T> extends StatelessWidget {
  final T value;
  final void Function(T?)? onChanged; // Fix: Accept nullable type T?
  final List<DropdownMenuItem<T>> items;
  final String hintText;

  const CustomDropdown({
    super.key,
    required this.value,
    required this.onChanged,
    required this.items,
    required this.hintText,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 10, right: 10),
      child: DropdownButton<T>(
        value: value,
        onChanged: onChanged,
        items: items,
        hint: Text(
          hintText,
          style: const TextStyle(color: Colors.grey),
        ),
        icon: const Icon(
          Icons.arrow_drop_down,
          color: Colors.deepPurple,
        ),
        underline: Container(
          height: 1,
          color: Colors.deepPurple,
        ),
        style: const TextStyle(
          color: Colors.deepPurple,
          fontSize: 16,
        ),
        isExpanded: true,
      ),
    );
  }
}
