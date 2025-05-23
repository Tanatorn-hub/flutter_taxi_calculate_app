import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TaxiResultUI extends StatefulWidget {
  // สร้างตัวแปรสําหรับรับค่าจากหน้าก่อนหน้า
  double? distanceKm;
  double? trafficTime;
  double? totalFare;

// เอาตัวแปรมารอรับค่าที่ส่งมา
  TaxiResultUI({
    super.key,
    this.distanceKm,
    this.trafficTime,
    this.totalFare,
  });

  @override
  State<TaxiResultUI> createState() => _TaxiResultUIState();
}

class _TaxiResultUIState extends State<TaxiResultUI> {
  @override
  Widget build(BuildContext context) {
    // กำหนดรูปแบบของตัวเลข คอมมาคันหลักพันเพื่อในกรณีเหมาไปต่างจังหวัด และทศนิยม 1 ตำแหน่ง
    NumberFormat fm = NumberFormat("#,##0.0");

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: Text(
          'คำนวณค่าแท็กซี่',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.arrow_back_ios,
            color: Colors.white,
          ),
        ),
      ),
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 130),
            Container(
              color: Color(0xffFFD700),
              width: 180,
              height: 80,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "T",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 55),
                  ),
                  SizedBox(width: 2),
                  Icon(Icons.local_taxi, size: 55),
                  SizedBox(width: 2),
                  Text(
                    "XI",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 55),
                  ),
                ],
              ),
            ),
            SizedBox(height: 30),
            Image.asset(
              'assets/images/taxi.png',
              width: 150,
            ),
            SizedBox(height: 40),
            Text(
              '---ค่าแท็กซี่---',
              style: TextStyle(
                color: Colors.black,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 20),
            Text.rich(
              TextSpan(
                children: [
                  TextSpan(
                    text: 'ระยะทาง ${widget.distanceKm} กิโลเมตร',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ), // สีแดงเฉพาะตัวเลข
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),
            Text(
              ' เวลารถติด ${widget.trafficTime} นาที',
              style: TextStyle(
                color: Colors.black,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ), // สีปกติ
            ),
            SizedBox(height: 20),
            Text(
              'คิดเป็นเงินที่ต้องจ่าย ${fm.format(widget.totalFare)} บาท',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
