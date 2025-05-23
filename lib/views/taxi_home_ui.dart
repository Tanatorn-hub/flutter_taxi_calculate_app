// ignore_for_file: prefer_final_fields, unused_field

import 'package:flutter/material.dart';
import 'package:flutter_taxi_calculate_app/views/taxi_result_ui.dart';

class TaxiHomeUI extends StatefulWidget {
  const TaxiHomeUI({super.key});

  @override
  State<TaxiHomeUI> createState() => _TaxiHomeUIState();
}

class _TaxiHomeUIState extends State<TaxiHomeUI> {
// ตัวแปรควบคุม textfield
  TextEditingController _distanceCtrl = TextEditingController();
  TextEditingController _trafficTimeCtrl = TextEditingController();

// สร้างเมธอด แสดง Dailog แจ้งเตือน
  _wrningDialog(msg) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('คำเตือน'),
        content: Text(msg),
        actions: [
          OutlinedButton(
            onPressed: () {
              Navigator.pop(context); // ปิด dialog
            },
            child: Text('ตกลง'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: Text(
          'คำนวณค่าแท็กซี่',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 40),
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
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
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 55),
                    ),
                    SizedBox(width: 2),
                    Icon(Icons.local_taxi, size: 55),
                    SizedBox(width: 2),
                    Text(
                      "XI",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 55),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 40),
              Image.asset(
                'assets/images/taxi.png',
                width: 150,
              ),
              SizedBox(height: 40),
              TextField(
                controller: _distanceCtrl,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  floatingLabelBehavior:
                      FloatingLabelBehavior.always, //ให้แสดง label ค้างไว้
                  labelText: 'ระยะทาง (กิโลเมตร)',
                  hintText: 'ป้อนระยะทาง',
                  hintStyle: TextStyle(
                    fontSize: 16,
                    color: Colors.grey,
                  ),
                  contentPadding:
                      EdgeInsets.symmetric(vertical: 20, horizontal: 12),
                ),
              ),
              SizedBox(height: 15),
              TextField(
                controller: _trafficTimeCtrl,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    floatingLabelBehavior:
                        FloatingLabelBehavior.always, //ให้แสดง label ค้างไว้
                    labelText: 'เวลารถติด (นาที)',
                    hintText: 'ป้อนเวลารถติด (ไม่มีป้อน 0)',
                    hintStyle: TextStyle(
                      fontSize: 16,
                      color: Colors.grey,
                    ),
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 20, horizontal: 12)),
              ),
              SizedBox(height: 30),
              ElevatedButton(
                onPressed: () {
                  // validate ui หากมีปัญหาให้แสดง dialog แจ้งเตือน
                  if (_distanceCtrl.text.isEmpty) {
                    _wrningDialog("ป้อนระยะทางด้วย..");
                  } else if (_trafficTimeCtrl.text.isEmpty) {
                    _wrningDialog("ป้อนเวลารถติดด้วย..");
                  } else {
                    // พร้อมคำนวณแล้วส่งไปแสดงผลที่หน้า TaxiResultUI
                    // แปลงระยะทาง กับเวลารถติด เป็น ตัวเลข
                    double distanceKm = double.parse(_distanceCtrl.text);
                    double trafficTime = double.parse(_trafficTimeCtrl.text);
// คำนวณค่าระยะทาง
                    double distanceFare = 35.0 +
                        (distanceKm > 1.0 ? (distanceKm - 1.0) * 5.50 : 0.0);

// คำนวณค่ารถติด
                    double trafficFare = trafficTime * 0.50;

// รวม
                    double totalFare = distanceFare + trafficFare;

                    // แสดงผลที่หน้า ResultScreenUI เปิดแบบย้อนกลับได้
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => TaxiResultUI(
                          distanceKm: distanceKm,
                          trafficTime: trafficTime,
                          totalFare: totalFare,
                        ),
                      ),
                    );
                  }
                },
                child: Text(
                  'คำนวณ',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(4),
                  ),
                  minimumSize: Size(
                    double.infinity,
                    55,
                  ),
                ),
              ),
              SizedBox(height: 15),
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    _distanceCtrl.clear();
                    _trafficTimeCtrl.clear();
                  });
                  // เคลียร์ทุกอย่างให้เป็นเหมือนเดิม
                },
                child: Text(
                  'ยกเลิก',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.deepOrange,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(4),
                  ),
                  minimumSize: Size(
                    double.infinity,
                    55,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
