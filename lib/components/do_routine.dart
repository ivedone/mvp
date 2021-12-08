import 'package:flutter/material.dart';

class DoRoutineWidget extends StatelessWidget {
  const DoRoutineWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        /// DemonstrationWidget
        SizedBox(
            height: MediaQuery.of(context).size.height / 3,
            child: Container(
                color: Colors.red[300],
                child: const Center(child: Text('DoRoutineDetailWidget')))),

        /// DoRoutineListWidget
        Expanded(
            child: Container(
          color: Colors.black87,
          child: const Center(child: Text('DoRoutineListWidget')),
        )),
      ],
    );
  }
}
