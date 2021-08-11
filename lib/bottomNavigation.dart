import 'package:flutter/material.dart';

import 'page/qr_scan_page.dart';

class CustomBottomNavigation extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.grey[900],
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.white.withOpacity(.60),
        selectedFontSize: 14,
        unselectedFontSize: 14,
        onTap: (value) {
         Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) {
                  return QRScanPage();
                },
              ),
            );
          // Respond to item press.
        },
        items: [
          BottomNavigationBarItem(
            title: Text('Label'),
            icon: Icon(Icons.star),
          ),
          BottomNavigationBarItem(
            title: Text('Label'),
            icon: Icon(Icons.brightness_1),
          ),
          BottomNavigationBarItem(
            title: Text('Label'),
            icon: Icon(Icons.branding_watermark),
          ),
            BottomNavigationBarItem(
            title: Text('QR'),
            icon: Icon(Icons.eject),
          ),
          BottomNavigationBarItem(
            title: Text('Label'),
            icon: Icon(Icons.satellite),
          ),
        ],
      ),
    );
  }
}
