import 'package:flutter/material.dart';
import 'package:newsapi/viewmodel/fetchapi.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('News App'),
        ),
        body: FutureBuilder(
          future: fetchApi(),
          builder: (context, snapshot) {
            return SizedBox();
          },
        ),
      ),
    );
  }
}
