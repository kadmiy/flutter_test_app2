import 'package:flutter/material.dart';
import 'package:flutter_test_app2/domain/models/card.dart';
import 'package:flutter_test_app2/presentation/details_page/details_page.dart';

part 'card.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
//  final Color _color = Colors.orangeAccent;

/*
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(
          'Hello!',
          style: Theme.of(context).textTheme.bodyLarge,
        ),
        backgroundColor: Colors.orangeAccent,
        duration: const Duration(seconds: 1),
      ));
    });
    super.initState();
  }
*/

  @override
  Widget build(BuildContext context) {
    return Scaffold(
//      appBar: AppBar(
//        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
//        title: Text(widget.title),
//      ),
      body: const Body(),
    );
  }

}
