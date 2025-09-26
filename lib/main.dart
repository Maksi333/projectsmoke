import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'setup.dart';
import 'stats.dart';
import 'home.dart';
import 'money_saved.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool? isSetupDone;
  var selectedIndex = 1;

  @override
  void initState() {
    super.initState();
    tempSetup(); //remove later
    //_checkSetupStatus(); implement this again
  }

  //todo
  Future<void> _checkSetupStatus() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      isSetupDone = prefs.getBool('setup_done') ?? false;
    });
  }

  //change issetupdone to true
  Future<void> _completeSetup() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('setup_done', true);
    setState(() {
      isSetupDone = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (isSetupDone == null) {
      // Loading state
      return Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    if (!isSetupDone!) {
      return SetupPage(onSetupComplete: _completeSetup);
    }

    Widget page;
    switch (selectedIndex) {
      case 0:
        page = StatsPage();
        break;
      case 1:
        page = HomePage();
        break;
      case 2:
        page = MoneySavedPage();
        break;
      default:
        throw UnimplementedError('no widget for $selectedIndex');
    }

    return Scaffold(
      body: page,
      bottomNavigationBar: NavigationBar(
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.star_outline),
            selectedIcon: Icon(Icons.star),
            label: 'Stats',
          ),
          NavigationDestination(
            icon: Icon(Icons.home_outlined),
            selectedIcon: Icon(Icons.home),
            label: 'Home',
          ),
          NavigationDestination(
            icon: Icon(Icons.monetization_on_outlined),
            selectedIcon: Icon(Icons.monetization_on),
            label: 'Savings',
          ),
        ],
        selectedIndex: selectedIndex,
        onDestinationSelected: (value) {
          setState(() {
            selectedIndex = value;
          });
        },
      ),
    );
  }

  void tempSetup() async {
    final pref = await SharedPreferences.getInstance();
    await pref.setBool('setup_done', true);
    setState(() {
      isSetupDone = false;
    });
  }
}
