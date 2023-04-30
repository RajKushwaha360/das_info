import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_scalable_ocr/flutter_scalable_ocr.dart';

class OcrScreen extends StatefulWidget {
  const OcrScreen({super.key, required this.title});

  final String title;

  @override
  State<OcrScreen> createState() => _OcrScreenState();
}

class _OcrScreenState extends State<OcrScreen> {
  String text = "";
  final StreamController<String> controller = StreamController<String>();

  void setText(value) {
    controller.add(value);
  }

  @override
  void dispose() {
    controller.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              ScalableOCR(
                  paintboxCustom: Paint()
                    ..style = PaintingStyle.stroke
                    ..strokeWidth = 4.0
                    ..color = const Color.fromARGB(153, 102, 160, 241),
                  boxLeftOff: 10,
                  boxBottomOff: 10,
                  boxRightOff:10,
                  boxTopOff: 10,
                  boxHeight: MediaQuery.of(context).size.height / 2,
                  getRawData: (value) {
                    inspect(value);
                  },
                  getScannedText: (value) {
                    setText(value);
                  }),
              StreamBuilder<String>(
                stream: controller.stream,
                builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
                  return Result(text: snapshot.data != null ? snapshot.data! : "");
                },
              )
            ],
          ),
        ));
  }
}

class Result extends StatelessWidget {
  const Result({
    Key? key,
    required this.text,
  }) : super(key: key);

  final String text;

  @override
  Widget build(BuildContext context) {
    return Text("Readed text: $text");
  }
}