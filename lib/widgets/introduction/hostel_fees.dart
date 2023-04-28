import 'package:flutter/material.dart';

class HostelFees extends StatelessWidget {
  const HostelFees({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Icon(
            Icons.file_copy,
            size: 200,
            color: Theme.of(context).primaryColor,
          ),
          SizedBox(
            height: 100,
            child: Column(
              children: [
                Text(
                  "Hostel Fees",
                  style: TextStyle(
                      color: Theme.of(context).primaryColor,
                      fontWeight: FontWeight.bold,
                      fontSize: 18),
                ),
                const SizedBox(height: 20,),
                const Text(
                  "To manage students fees details\nalso download invoice",
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
