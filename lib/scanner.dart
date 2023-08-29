import 'dart:developer';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:scanner/home_page.dart';


class MyQRScanner extends StatelessWidget {
  const MyQRScanner({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Flutter Demo Home Page')),
      body: const QRViewExample(),
    );
  }
}

class QRViewExample extends StatefulWidget {
  const QRViewExample({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _QRViewExampleState();
}

class _QRViewExampleState extends State<QRViewExample> {
  Barcode? result;
  QRViewController? controller;
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');

  // In order to get hot reload to work we need to pause the camera if the platform
  // is android, or resume the camera if the platform is iOS.
  @override
  void reassemble() {
    super.reassemble();
    if (Platform.isAndroid) {
      controller!.pauseCamera();
    }
    controller!.resumeCamera();
  }

  // @override
  void _test() {
    Map<String, dynamic> testObject = {};

    final now = DateTime.now();
    
    if(now.hour >= 05 && now.hour <= 12) {
      testObject = {
        "idMON" : 0,
        "Name" : "Morning",
        "Icon": Icons.done.toString(),
        "periodDate" : DateTime(now.year, now.month, now.day).toString(),
      };
    } else if (now.hour >= 16 && now.minute <= 24) {
      testObject = {
        "idMON" : 1,
        "Name" : "Night",
        "Icon": Icons.done.toString(),
        "periodDate" : DateTime(now.year, now.month, now.day).toString(),
      };
    }
    
    Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => MyHomePage(period: testObject),
    ));

    controller!.dispose();
    controller!.stopCamera();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          Expanded(flex: 4, child: _buildQrView(context)),
          ElevatedButton(onPressed: _test, child: Text("123")),
          Expanded(
            flex: 1,
            child: FittedBox(
              fit: BoxFit.contain,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  if (result != null)
                    Text(
                        'Barcode Type: ${describeEnum(result!.format)}   Data: ${result!.code}')
                  else
                    const Text('Scan a code'),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Container(
                        margin: const EdgeInsets.all(8),
                        child: ElevatedButton(
                            onPressed: () async {
                              await controller?.toggleFlash();
                              setState(() {});
                            },
                            child: FutureBuilder(
                              future: controller?.getFlashStatus(),
                              builder: (context, snapshot) {
                                return Text('Flash: ${snapshot.data}');
                              },
                            )),
                      ),
                      Container(
                        margin: const EdgeInsets.all(8),
                        child: ElevatedButton(
                            onPressed: () async {
                              await controller?.flipCamera();
                              setState(() {});
                            },
                            child: FutureBuilder(
                              future: controller?.getCameraInfo(),
                              builder: (context, snapshot) {
                                if (snapshot.data != null) {
                                  return Text(
                                      'Camera facing ${describeEnum(snapshot.data!)}');
                                } else {
                                  return const Text('loading');
                                }
                              },
                            )),
                      )
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      // ElevatedButton(
                      //   // style: style,
                      //   onPressed:  _test,
                      //   child: const Text('TEST 123'),
                      // ),
                      Container(
                        margin: const EdgeInsets.all(8),
                        child: ElevatedButton(
                          onPressed: () async {
                            await controller?.pauseCamera();
                          },
                          child: const Text('pause',
                              style: TextStyle(fontSize: 20)),
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.all(8),
                        child: ElevatedButton(
                          onPressed: () async {
                            await controller?.resumeCamera();
                          },
                          child: const Text('resume',
                              style: TextStyle(fontSize: 20)),
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _buildQrView(BuildContext context) {
    // For this example we check how width or tall the device is and change the scanArea and overlay accordingly.
    var scanArea = (MediaQuery.of(context).size.width < 400 ||
            MediaQuery.of(context).size.height < 400)
        ? 150.0
        : 300.0;
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
    // log("TESTESTETESTETES");
    // debugPrint('movieTitle: SASASASA');
    setState(() {
      this.controller = controller;
    });

    controller.resumeCamera();

    controller.scannedDataStream.listen((scanData) {
      setState(() {
        if(scanData.code == "rama") {
          _sendDataBack(context);
          result = scanData;
        }
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

  void _sendDataBack(BuildContext context) {
    Map<String, dynamic> testObject = {};

    final now = DateTime.now();
    
    if(now.hour >= 05 && now.hour <= 12) {
      testObject = {
        "idMON" : 0,
        "Name" : "Morning",
        "Icon": Icons.done.toString(),
        "periodDate" : DateTime(now.year, now.month, now.day).toString(),
      };
    } else if (now.hour >= 16 && now.minute <= 24) {
      testObject = {
        "idMON" : 1,
        "Name" : "Night",
        "Icon": Icons.done.toString(),
        "periodDate" : DateTime(now.year, now.month, now.day).toString(),
      };
    }
    
    Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => MyHomePage(period: testObject),
    ));

    controller!.dispose();
    controller!.stopCamera();
  }
}