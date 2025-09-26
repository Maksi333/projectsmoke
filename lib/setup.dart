import 'package:flutter/material.dart';

class StartPage extends StatelessWidget {
  final VoidCallback onSetupComplete;
  const StartPage({super.key, required this.onSetupComplete});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text('setup page', style: Theme.of(context).textTheme.headlineMedium),
          ElevatedButton(onPressed: onSetupComplete, child: Text('Start')),
        ],
      ),
    );
  }
}
