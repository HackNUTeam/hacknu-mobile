import 'package:flutter/material.dart';

class LoadingPage extends StatelessWidget {
  const LoadingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            width: MediaQuery.of(context).size.width,
            height: 150.0,
          ),
          const SizedBox(height: 30.0),
          const Text(
            "FireUpp",
            style: TextStyle(
              color: Color.fromARGB(255, 107, 39, 39),
              fontSize: 60.0,
              fontWeight: FontWeight.w600,
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width,
            height: 100.0,
          ),
          const Icon(
            Icons.fire_hydrant_alt_outlined,
            size: 100.0,
            color: Color.fromARGB(255, 107, 39, 39),
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width,
            height: 200.0,
          ),
          const Text(
            "Loading",
            style: TextStyle(
              color: Color.fromARGB(255, 75, 49, 49),
              fontSize: 30.0,
              fontWeight: FontWeight.w300,
            ),
          ),
        ],
      ),
    );
  }
}
