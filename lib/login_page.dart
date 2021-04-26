import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rokdaapp/color_theme.dart';
import 'package:rokdaapp/transaction_page.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  var publicKey, privateKey;
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark(),
      home: Scaffold(
        backgroundColor: backgroundTheme,
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    'assets/rokda.png',
                    height: 100,
                    color: primaryColor,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    'Rokda',
                    style: TextStyle(
                      color: CupertinoColors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 35,
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 30, vertical: 20),
                child: TextField(
                  onChanged: (value) {
                    this.publicKey = value;
                  },
                  cursorColor: primaryColor,
                  decoration: textFieldDecoration.copyWith(
                    labelText: 'Public Key',
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 30, vertical: 20),
                child: TextField(
                  onChanged: (value) {
                    this.privateKey = value;
                  },
                  cursorColor: primaryColor,
                  decoration:
                      textFieldDecoration.copyWith(labelText: 'Private Key'),
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  if (this.privateKey != null && this.publicKey != null) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => TransactionPage(
                            publicKey: this.publicKey,
                            privateKey: this.privateKey),
                      ),
                    );
                  }
                },
                child: Text(
                  'Continue',
                  style: TextStyle(
                      fontSize: 15,
                      color: CupertinoColors.black,
                      fontWeight: FontWeight.bold),
                ),
                style: ButtonStyle(
                  elevation: MaterialStateProperty.all(10),
                  backgroundColor:
                      MaterialStateColor.resolveWith((states) => primaryColor),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
