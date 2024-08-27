import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Barcode and QRCode Scanner',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  String qrcoderesult = "Result is here";
  Future<void> scanQRCode()async {
    try{
      String result;

      result = await FlutterBarcodeScanner.scanBarcode("#FE9900", "Cancel", true, ScanMode.QR);
      setState(() {
        qrcoderesult = result;
      });
    }on PlatformException{

    }
  }

  Future<void> scanBarCode() async{
    String result;
    try{
      result = await FlutterBarcodeScanner.scanBarcode("#FE9900", "Cancel", true, ScanMode.BARCODE);
      setState(() {
        qrcoderesult = result;
      });
    }on PlatformException{

    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Barcode and QRCode Scanner"),
      ),
      body: Container(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(qrcoderesult),
              SizedBox(height: 10,),
              Container(
                width: 190,
                height: 60,
                decoration: BoxDecoration(
                  color: Colors.red,
                  borderRadius: BorderRadius.circular(8)
                ),
                child: ElevatedButton(
                    onPressed: (){
                      scanQRCode();
                    },
                    child: Icon(Icons.qr_code,color: Colors.white,size: 33,),
                  style: ElevatedButton.styleFrom(
                    elevation: 0,
                    backgroundColor: Colors.transparent,
                  ),
                ),
              ),
              SizedBox(height: 15,),
              Container(
                width: 190,
                height: 60,
                decoration: BoxDecoration(
                    color: Colors.red,
                    borderRadius: BorderRadius.circular(8)
                ),
                child: ElevatedButton(
                  onPressed: (){
                    scanBarCode();
                  },
                  child: Icon(Icons.code,color: Colors.white,size: 33,),
                  style: ElevatedButton.styleFrom(
                    elevation: 0,
                    backgroundColor: Colors.transparent,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

