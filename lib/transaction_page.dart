import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:rokdaapp/color_theme.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class TransactionPage extends StatefulWidget {
  final String publicKey, privateKey;
  const TransactionPage({Key key, this.publicKey, this.privateKey})
      : super(key: key);
  @override
  _TransactionPageState createState() => _TransactionPageState();
}

class _TransactionPageState extends State<TransactionPage> {
  var publicKey, privateKey, receiverPublicKey, amount;
  List transactions = [];
  bool _isLoading = false;
  String _getTime() {
    final String formattedDateTime =
        DateFormat('yyyy-MM-dd   kk:mm:ss').format(DateTime.now()).toString();
    return formattedDateTime;
  }

  Widget _transactionTile(dynamic transactionDetails) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.grey),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "${transactionDetails['time']}",
            style: TextStyle(color: primaryColor),
          ),
          SizedBox(
            height: 10,
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("${transactionDetails["receiversPublicKey"]}"),
              SizedBox(
                width: 20,
              ),
              Text("${transactionDetails["amount"]}")
            ],
          ),
        ],
      ),
    );
  }

  List<Widget> _statementWidget() {
    List<Widget> statement = [];
    if (this.transactions.length == 0) {
      return [
        Text(
          'No data available',
          style: TextStyle(
              color: Colors.white, fontWeight: FontWeight.bold, fontSize: 30),
        )
      ];
    }
    for (int i = transactions.length - 1; i >= 0; i--) {
      statement.add(_transactionTile(transactions[i]));
    }
    return statement;
  }

  @override
  void initState() {
    this.privateKey = widget.privateKey;
    this.publicKey = widget.publicKey;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark(),
      home: DefaultTabController(
        initialIndex: 0,
        length: 2,
        child: Container(
          child: Scaffold(
            backgroundColor: backgroundTheme,
            appBar: AppBar(
              leading: TextButton(
                child: Icon(
                  Icons.exit_to_app,
                  color: Colors.grey,
                  size: 25,
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
              actions: [
                Container(
                  height: 20,
                  padding: EdgeInsets.symmetric(horizontal: 12),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      border: Border.all(color: Colors.grey)),
                  child: Icon(
                    Icons.person_rounded,
                    color: Colors.grey,
                    size: 30,
                  ),
                ),
                SizedBox(
                  width: 20,
                ),
              ],
              backgroundColor: backgroundTheme,
              elevation: 0,
              bottomOpacity: 0.9,
              bottom: TabBar(
                indicatorColor: primaryColor,
                labelColor: primaryColor,
                isScrollable: true,
                tabs: [
                  // child: Text('Transaction',style: TextStyle(color: primaryColor,fontWeight: FontWeight.bold),),
                  Tab(
                    text: 'Transaction',
                  ),
                  Tab(
                    text: 'Statement',
                  ),
                ],
              ),
            ),
            body: TabBarView(
              children: [
                Center(
                  child: this._isLoading
                      ? Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Processing your request',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 25,
                                  fontWeight: FontWeight.bold),
                            ),
                            SizedBox(
                              height: 60,
                            ),
                            SpinKitWave(
                              itemBuilder: (BuildContext context, int index) {
                                return DecoratedBox(
                                  decoration: BoxDecoration(
                                    color: primaryColor,
                                  ),
                                );
                              },
                            ),
                          ],
                        )
                      : Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              child: Text(
                                'To',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 25),
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.symmetric(
                                  vertical: 20, horizontal: 30),
                              child: TextField(
                                onChanged: (value) {
                                  this.receiverPublicKey = value;
                                },
                                decoration: textFieldDecoration.copyWith(
                                  labelText: "Public Key",
                                ),
                                cursorColor: primaryColor,
                              ),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Container(
                              child: Text(
                                'Amount',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 25),
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.symmetric(
                                  vertical: 20, horizontal: 30),
                              child: TextField(
                                onChanged: (_) {
                                  this.amount = _;
                                },
                                keyboardType: TextInputType.number,
                                decoration: textFieldDecoration.copyWith(
                                  labelText: "Amount",
                                ),
                                cursorColor: primaryColor,
                              ),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            ElevatedButton(
                              onPressed: () async {
                                setState(() {
                                  this._isLoading = true;
                                });
                                http.Response response = await http.get(
                                  Uri.parse(
                                      "https://serene-refuge-98596.herokuapp.com/leaderboard"),
                                );
                                Map transaction = {
                                  "sendersPublicKey": this.publicKey,
                                  "receiversPublicKey": this.receiverPublicKey,
                                  "amount": this.amount,
                                  "time": _getTime()
                                };
                                if (response.body != null) {
                                  setState(() {
                                    this._isLoading = false;
                                  });
                                  this.transactions.add(transaction);
                                  print(transactions);
                                  await Alert(
                                      image: Image.asset('assets/rokda.png'),
                                      context: context,
                                      title: "Transaction Successful",
                                      desc: "Your transaction is successful",
                                      buttons: [
                                        DialogButton(
                                          child: Text('Okay'),
                                          onPressed: () {
                                            Navigator.of(context).pop();
                                          },
                                          color: primaryColor,
                                        )
                                      ]).show();
                                }
                              },
                              child: Text(
                                'Pay',
                                style: TextStyle(
                                    fontSize: 15,
                                    color: CupertinoColors.black,
                                    fontWeight: FontWeight.bold),
                              ),
                              style: ButtonStyle(
                                elevation: MaterialStateProperty.all(10),
                                backgroundColor: MaterialStateColor.resolveWith(
                                    (states) => primaryColor),
                              ),
                            ),
                          ],
                        ),
                ),
                Center(
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: _statementWidget(),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
