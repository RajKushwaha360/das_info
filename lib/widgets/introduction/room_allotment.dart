import 'package:flutter/material.dart';

class RoomAllotment extends StatelessWidget {
  const RoomAllotment({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Icon(
            Icons.computer,
            size: 200,
            color: Theme.of(context).primaryColor,
          ),
          SizedBox(
            height: 100,
            child: Column(
              children: [
                Text(
                  "Room Allotment",
                  style: TextStyle(
                      color: Theme.of(context).primaryColor,
                      fontWeight: FontWeight.bold,
                      fontSize: 18),
                ),
                const SizedBox(height: 20,),
                const Text(
                  "It's to find rooms available\nor not",
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
