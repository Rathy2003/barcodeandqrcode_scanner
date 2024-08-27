import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:url_launcher/url_launcher.dart';

void main() {
  SystemChrome.setPreferredOrientations(
    [
      DeviceOrientation.portraitUp
    ]
  );
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
      if(result!="-1")
        _showDiaglog(context);
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
      if(result!="-1")
        _showDiaglog(context);
    }on PlatformException{

    }
  }

  Future<void> _showDiaglog(BuildContext context)async {
  return showDialog(
      context: context,
      builder: (context) {
    return AlertDialog(
      title: Text(""),
      content: Text(qrcoderesult,style: TextStyle(
          fontSize: 17),
      textAlign: TextAlign.center,
      ),
      insetPadding: EdgeInsets.zero,
      clipBehavior: Clip.antiAliasWithSaveLayer,
      contentPadding: EdgeInsets.all(14),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8)
      ),
      actions: [
        TextButton(
            onPressed: (){
              Navigator.pop(context);
            },
            child: Text("Close")
        ),
        TextButton(
            onPressed: (){
              _launchUrl(Uri.parse(qrcoderesult));
            },
            child: Text("Open")
        )
      ],
    );
  });
  }

  Future<void> _launchUrl(Uri _url) async {
    if (!await launchUrl(_url)) {
      throw Exception('Could not launch $_url');
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
      backgroundColor: Colors.black38,
      body: Container(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              InkWell(
                onTap: (){
                  scanQRCode();
                },
                child: Container(
                  width: 190,
                  height: 60,
                  padding: EdgeInsets.symmetric(vertical: 14),
                  decoration: BoxDecoration(
                    color: Color(0xFF121212),
                    borderRadius: BorderRadius.circular(8)
                  ),
                  child: Image.asset("assets/images/qr-code.png"),
                ),
              ),
              SizedBox(height: 25,),
              InkWell(
                onTap: (){
                  scanBarCode();
                },
                child: Container(
                  width: 190,
                  height: 60,
                  padding: EdgeInsets.symmetric(vertical: 10),
                  decoration: BoxDecoration(
                      color: Color(0xFF121212),
                      borderRadius: BorderRadius.circular(8)
                  ),
                  child: Image.asset("assets/images/barcode.png",)
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

