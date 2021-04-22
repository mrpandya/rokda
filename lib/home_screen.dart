import 'package:flutter/material.dart';
import 'package:rokdaapp/color_theme.dart';
import 'package:rokdaapp/login_page.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      darkTheme: ThemeData.dark(),
      home: Scaffold(
        backgroundColor: backgroundTheme,
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: EdgeInsets.all(25),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomCenter,
                    colors: [
                      Color(0xff040506),
                      backgroundTheme,
                      backgroundTheme,
                    ],
                  ),
                  borderRadius: BorderRadius.circular(150),
                ),
                // child: Icon(
                //   Icons.fingerprint,
                //   size: 150,
                //   color: primaryColor,
                // ),
                child:Image.asset('assets/rokda.png',height: 150,color: primaryColor,),
              ),
              SizedBox(
                height: 30,
              ),
              Text(
                'Login',
                style: TextStyle(
                  fontSize: 30,
                  color: Color(0xffffffff),
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(
                height: 30,
              ),
              FloatingActionButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => LoginPage(),
                    ),
                  );
                },
                elevation: 10,
                backgroundColor: primaryColor,
                child: Icon(
                  Icons.arrow_right_alt_outlined,
                  size: 35,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
