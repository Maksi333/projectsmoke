import 'dart:async';
import 'package:flutter/material.dart';
import 'dart:core';
import 'package:shared_preferences/shared_preferences.dart';
import 'setup.dart';
import 'stats.dart';
import 'home.dart';
import 'money_saved.dart';
import 'Controller/main_controller.dart';

MainController controller = MainController();
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
  Timer? _timer;
  var selectedIndex = 1;

  @override
  void initState() {
    super.initState();

    initializeApp();
    _timer = Timer.periodic(Duration(minutes: 1), (_) {
      setState(() {}); // triggers rebuild to update time clean
    });
    _checkSetupStatus();
  }

  Future<void> initializeApp() async {
    final prefs = await SharedPreferences.getInstance();
    debugPrint(prefs.getDouble('boxPrice').toString());
    debugPrint(prefs.getInt('pouchesPerDay').toString());
    debugPrint(prefs.getInt('pouchesInBox').toString());
    debugPrint(prefs.getString('startDate').toString());
    await loadSetup();
    await _checkSetupStatus();
    setState(() {});
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

  Future<void> loadSetup() async {
    final prefs = await SharedPreferences.getInstance();
    controller.boxPrice = prefs.getDouble('boxPrice') ?? -1;
    controller.pouchesPerDay = prefs.getInt('pouchesPerDay') ?? -1;
    controller.pouchesInBox = prefs.getInt('pouchesInBox') ?? -1;
    String? startDateString = prefs.getString('startDate');
    if (startDateString != null) {
      controller.startDate = DateTime.parse(startDateString);
    }
  }

  // void tempSetup() async {
  //   final pref = await SharedPreferences.getInstance();
  //   await pref.setBool('setup_done', true);
  //   setState(() {
  //     isSetupDone = false;
  //   });
  // }
}
