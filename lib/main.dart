import 'package:flutter/material.dart';
import 'package:incomeexpenseapp/Income_expense_graph.dart';
import 'package:sms/sms.dart';
import 'package:bloc/bloc.dart' as prefix0;

class SimpleBlocDelegate extends prefix0.BlocDelegate {
  @override
  void onEvent(prefix0.Bloc bloc, Object event) {
    super.onEvent(bloc, event);
    print(event);
  }

  @override
  void onTransition(prefix0.Bloc bloc, prefix0.Transition transition) {
    super.onTransition(bloc, transition);
    print(transition);
  }

  @override
  void onError(prefix0.Bloc bloc, Object error, StackTrace stacktrace) {
    super.onError(bloc, error, stacktrace);
    print(error);
  }
}

void main() {
  prefix0.BlocSupervisor.delegate = SimpleBlocDelegate();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  double creditedAmount = 0;
  double debitedAmount = 0;
// This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'InCome Expenses',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(creditedAmount, debitedAmount),
    );
  }
}

class MyHomePage extends StatefulWidget {
  double creditedAmount = 0;
  double debitedAmount = 0;
  MyHomePage(this.creditedAmount, this.debitedAmount);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  static const List<String> transactions = <String>["Pie-chart"];
  double creditedAmount = 0;
  double debitedAmount = 0;
  SmsQuery query = SmsQuery();
  List messages = List();
  List messagesShow = List();
  List messagesShowDebit = List();
  String creditedStringPossibleOne = 'credited with';
  String creditedStringPossibleTwo = 'credited for ';
  String debitedStringPossibleOne = 'debited with ';
  String debitedStringPossibleTwo = 'debited for ';

  static final RegExp amountRegex = RegExp(r'\b\d+\.\d+\b');

  fetchMessage(tab) async {
    messages = await query.getAllSms;
    for (var i = 0; i < messages.length; i++) {
      if (((messages[i].body).toString().contains(creditedStringPossibleOne) ||
              (messages[i].body)
                  .toString()
                  .contains(creditedStringPossibleTwo)) &&
          tab == 0) {
        if (amountRegex.hasMatch(messages[i].body))
          creditedAmount = creditedAmount +
              double.parse(amountRegex.stringMatch(messages[i].body));
        messagesShow.add((messages[i].body).toString());
      } else if (((messages[i].body)
                  .toString()
                  .contains(debitedStringPossibleOne) ||
              (messages[i].body)
                  .toString()
                  .contains(debitedStringPossibleTwo)) &&
          tab == 1) {
        if (amountRegex.hasMatch(messages[i].body))
          debitedAmount = debitedAmount +
              double.parse(amountRegex.stringMatch(messages[i].body));
        messagesShowDebit.add((messages[i].body).toString());
      }
    }
    setState(() {});
  }

  @override
  void initState() {
    fetchMessage(0);
    fetchMessage(1);
// TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          bottom: TabBar(
              onTap: (val) {
                if (val == 0) {
                  creditedAmount = 0;
                  messagesShow.clear();
                } else {
                  debitedAmount = 0;
                  messagesShowDebit.clear();
                }
                messages.clear();
                fetchMessage(val);
              },
              tabs: [
                Tab(
                  text: "Credited Amount",
                ),
                Tab(
                  text: "Debited Amount",
                ),
              ]),
          actions: <Widget>[
            PopupMenuButton<String>(
              icon: IconButton(
                icon: Icon(Icons.more_vert),
                onPressed: () {
                  Navigator.push(context, new MaterialPageRoute(
                    builder: (context) {
                      return PieChartPage(
                        creditedAmount: creditedAmount,
                        debitedAmount: debitedAmount,
                      );
                    },
                  ));
                },
              ),
              itemBuilder: (BuildContext context) {
                return transactions.map((String choice) {
                  return PopupMenuItem<String>(
                    value: choice,
                    child: Text(choice),
                  );
                }).toList();
              },
            )
          ],
        ),
        body: TabBarView(
          children: [
            ListView.separated(
              itemCount: messagesShow.length,
              itemBuilder: (context1, int index) {
                return ListTile(
                  title: Text(messagesShow.length == 0
                      ? "No data found"
                      : messagesShow[index].toString()),
                );
              },
              separatorBuilder: (context1, index) {
                return Divider(
                  color: Colors.green,
                );
              },
            ),
            ListView.separated(
              itemCount: messagesShowDebit.length,
              itemBuilder: (context2, int index) {
                return ListTile(
                  title: Text(messagesShowDebit.length == 0
                      ? "No data found"
                      : messagesShowDebit[index].toString()),
                );
              },
              separatorBuilder: (context2, index) {
                return Divider(
                  color: Colors.green,
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

//class CreditedAmount extends StatefulWidget {
// @override
// CreditedAmountState createState() => CreditedAmountState();
//}
//
//class _CreditedAmountState extends State<CreditedAmount> {
// MyHomePageState obj = MyHomePageState();
// var num = obj()
// @override
// Widget build(BuildContext context) {
// return Container();
// }
//}
