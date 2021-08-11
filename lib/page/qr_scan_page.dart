//import 'package:easy_permission_validator/easy_permission_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:permission_handler/permission_handler.dart';
import '../size_config.dart';
import '../enter_details.dart';
import '../main.dart';
import 'package:barcode_scan_fix/barcode_scan.dart';

class QRScanPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _QRScanPageState();
}

class _QRScanPageState extends State<QRScanPage> {
  String qrCode = '';

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);

    return Scaffold(
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              SizedBox(height: getProportionateScreenHeight(206)),
              InkWell(
                onTap: () async {
                   
                   //var status = await Permission.camera.status;
 showModalBottomSheet(
            isScrollControlled: true,
            clipBehavior: Clip.none,
            enableDrag: true,
            context: context,
            backgroundColor: Colors.transparent,
            builder: (BuildContext context) {
              return FormScreen();
            });
                     //scanQRCode();

                     // We didn't ask for permission yet.

                },
                child: Container(
                  //padding:EdgeInsets.only(top: getProportionateScreenHeight(206)),
                  height: getProportionateScreenHeight(246),
                  width: getProportionateScreenHeight(246),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                      color: Colors.white),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> scanQRCode() async {
    try {
      final qrCode = await FlutterBarcodeScanner.scanBarcode(
        '#ff6666',
        'Cancel',
        true,
        ScanMode.QR,
      );

      if (!mounted) return;
      print(qrCode);
      this.qrCode = qrCode;
      print(qrCode);
      if (qrCode != '' && qrCode != '-1')
        showModalBottomSheet(
            isScrollControlled: true,
            clipBehavior: Clip.none,
            enableDrag: true,
            context: context,
            backgroundColor: Colors.transparent,
            builder: (BuildContext context) {
              return FormScreen();
            });
    } on PlatformException {
      qrCode = 'Failed to get platform version.';
    }
  }
}
