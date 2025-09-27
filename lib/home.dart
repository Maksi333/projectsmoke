import 'dart:async';
import 'package:flutter/material.dart';
import 'Controller/main_controller.dart';

MainController controller = MainController();
List<String> quotes = controller.quotes;

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Timer? _timer;

  @override
  void initState() {
    super.initState();

    // Refresh every minute
    _timer = Timer.periodic(Duration(minutes: 1), (_) {
      setState(() {}); // triggers rebuild
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topCenter,
      child: Padding(
        padding: const EdgeInsets.only(top: 60),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Welcome Back!',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            const SizedBox(height: 16),
            _buildQuoteBox(),
            const SizedBox(height: 16),
            _buildTimeCleanBox(),
            const SizedBox(height: 16),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                _buildStatBox(
                  'Boxes Saved',
                  controller.calculateSparedBoxes().toStringAsFixed(2),
                  Icons.inbox,
                ),
                _buildStatBox(
                  'Money Saved',
                  '${controller.calculateSavings().toStringAsFixed(2)} Dkk',
                  Icons.savings,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildQuoteBox() {
    return Container(
      width: 350,
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      decoration: BoxDecoration(
        color: Colors.green[100],
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.green, width: 2),
      ),
      child: Column(
        children: [
          Text(
            'Your Daily Quote',
            style: Theme.of(context).textTheme.headlineSmall,
          ),
          const SizedBox(height: 12),
          Text(
            quotes.isNotEmpty
                ? quotes[DateTime.now().day % quotes.length]
                : 'Stay positive and keep pushing forward!',
            style: Theme.of(context).textTheme.bodyMedium,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildTimeCleanBox() {
    return Container(
      width: 350,
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      decoration: BoxDecoration(
        color: Colors.green[100],
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.green, width: 2),
      ),
      child: Column(
        children: [
          Text('Time Clean', style: Theme.of(context).textTheme.headlineMedium),
          const SizedBox(height: 12),
          Text(
            controller.formattedTimeClean(),
            style: Theme.of(context).textTheme.headlineSmall,
          ),
        ],
      ),
    );
  }

  Widget _buildStatBox(String label, String value, IconData icon) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        height: 160,
        width: 165,
        decoration: BoxDecoration(
          color: Colors.green[100],
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.green, width: 2),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 32),
            const SizedBox(height: 8),
            Text(label, style: Theme.of(context).textTheme.labelLarge),
            const SizedBox(height: 8),
            Text(value, style: Theme.of(context).textTheme.headlineMedium),
          ],
        ),
      ),
    );
  }
}
