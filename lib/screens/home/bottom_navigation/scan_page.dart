import 'dart:async';
import 'dart:developer';
import 'dart:io';

import 'package:das_info/screens/home/bottom_navigation/qr_result.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_scalable_ocr/flutter_scalable_ocr.dart';
import 'package:get/get.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

import '../../../widgets/scan_tools/ocr_widget.dart';

class ScanPage extends StatefulWidget {
  const ScanPage({super.key});

  @override
  State<ScanPage> createState() => _ScanPageState();
}

class _ScanPageState extends State<ScanPage> {
  Barcode? result;
  QRViewController? controller;
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');

  //OCR
  String text = "";
  final StreamController<String> ocrController = StreamController<String>();

  void setText(value) {
    ocrController.add(value);
  }

  bool isQr = true;

  @override
  void reassemble() {
    super.reassemble();
    if (Platform.isAndroid) {
      controller!.pauseCamera();
    }
    controller!.resumeCamera();
  }

  Widget _buildQrView(BuildContext context) {
    // For this example we check how width or tall the device is and change the scanArea and overlay accordingly.
    var scanArea = (MediaQuery.of(context).size.width < 400 ||
            MediaQuery.of(context).size.height < 400)
        ? 280.0
        : 280.0;
    // To ensure the Scanner view is properly sizes after rotation
    // we need to listen for Flutter SizeChanged notification and update controller
    return QRView(
      key: qrKey,
      onQRViewCreated: _onQRViewCreated,
      overlay: QrScannerOverlayShape(
          borderColor: Colors.red,
          borderRadius: 10,
          borderLength: 30,
          borderWidth: 10,
          cutOutSize: scanArea),
      onPermissionSet: (ctrl, p) => _onPermissionSet(context, ctrl, p),
    );
  }

  void _onQRViewCreated(QRViewController controller) {
    setState(() {
      this.controller = controller;
    });
    controller.scannedDataStream.listen((scanData) {
      setState(() {
        result = scanData;
      });
    });
  }

  void _onPermissionSet(BuildContext context, QRViewController ctrl, bool p) {
    log('${DateTime.now().toIso8601String()}_onPermissionSet $p');
    if (!p) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('no Permission')),
      );
    }
  }

  @override
  void dispose() {
    controller?.dispose();
    ocrController.close();
    super.dispose();
  }

  Widget callResult() {
    if (result != null) {
      controller?.dispose();
      Get.put(
        () => QrResultsPage(
          mobileNumber: result!.code!,
        ),
      );
    }

    return SizedBox(
      height: 0,
      width: 0,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        isQr
            ? Expanded(
                flex: 2,
                child: _buildQrView(context),
              )
            : Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  ScalableOCR(
                      paintboxCustom: Paint()
                        ..style = PaintingStyle.stroke
                        ..strokeWidth = 4.0
                        ..color = const Color.fromARGB(153, 102, 160, 241),
                      boxLeftOff: 4,
                      boxBottomOff: 2.8,
                      boxRightOff: 4,
                      boxTopOff: 2.8,
                      boxHeight: MediaQuery.of(context).size.height / 2,
                      getRawData: (value) {
                        inspect(value);
                      },
                      getScannedText: (value) {
                        setText(value);
                      }),
                  StreamBuilder<String>(
                    stream: ocrController.stream,
                    builder:
                        (BuildContext context, AsyncSnapshot<String> snapshot) {
                      return Result(
                          text: snapshot.data != null ? snapshot.data! : "");
                    },
                  )
                ],
              ),
        Expanded(
          flex: 2,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              if (result != null)
                TextButton(
                  child: Text(
                    'Open Profile',
                    style: TextStyle(
                      color: Colors.blue,
                      fontSize: 20,
                    ),
                  ),
                  onPressed: () {
                    Get.to(QrResultsPage(mobileNumber: result!.code!));
                  },
                ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  isQr
                      ? ElevatedButton(
                          onPressed: () {},
                          child: Text('QR Code'),
                        )
                      : TextButton(
                          onPressed: () {
                            setState(() {
                              isQr = !isQr;
                            });
                          },
                          child: Text('QR Code'),
                        ),
                  isQr
                      ? TextButton(
                          onPressed: () {
                            setState(() {
                              isQr = !isQr;
                            });
                          },
                          child: Text('OCR Code'),
                        )
                      : ElevatedButton(
                          onPressed: () {},
                          child: Text('OCR Code'),
                        ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
