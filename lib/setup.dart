import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'Controller/main_controller.dart';

MainController controller = MainController();

class SetupPage extends StatelessWidget {
  final VoidCallback onSetupComplete;
  const SetupPage({super.key, required this.onSetupComplete});

  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();

    return Scaffold(
      body: SingleChildScrollView(
        child: Form(
          key: formKey, // <-- assign the formKey here
          child: Column(
            children: [
              const SizedBox(height: 40),
              Center(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    'Welcome to your snus quitting journey!',
                    style: Theme.of(context).textTheme.headlineMedium,
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
              Center(
                child: Padding(
                  padding: const EdgeInsets.only(top: 30.0),
                  child: Text(
                    'Lets get you set up!',
                    style: Theme.of(context).textTheme.headlineMedium,
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 15.0, bottom: 10),
                child: Text(
                  'What is the price of one box of snus?',
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: TextFormField(
                  keyboardType: TextInputType.number,
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a value';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    controller.boxPrice = double.parse(value!);
                  },
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Price in DKK',
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 15.0, bottom: 10),
                child: Text(
                  'How many pouches do you use per day?',
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: TextFormField(
                  keyboardType: TextInputType.number,
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a value';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    controller.pouchesPerDay = int.parse(value!);
                  },
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Pouches per day',
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 15.0, bottom: 10),
                child: Text(
                  'How many pouches are in one box?',
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: TextFormField(
                  keyboardType: TextInputType.number,
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a value';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    controller.pouchesInBox = int.parse(value!);
                  },
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Puches in a box',
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: ElevatedButton(
                  onPressed: () async {
                    if (formKey.currentState!.validate()) {
                      formKey.currentState!.save();
                      controller.startDate = DateTime.now();
                      onSetupComplete();
                      await saveSetup();
                    }
                  },
                  child: const Text('Complete Setup'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> saveSetup() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setDouble('boxPrice', controller.boxPrice);
    await prefs.setInt('pouchesPerDay', controller.pouchesPerDay);
    await prefs.setInt('pouchesInBox', controller.pouchesInBox);
    await prefs.setString('startDate', controller.startDate.toIso8601String());
  }
}
