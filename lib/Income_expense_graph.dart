import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:incomeexpenseapp/utils/ModalRoundedProgressBar.dart';
import 'package:pie_chart/pie_chart.dart';

import 'bloc/bloc.dart';

class PieChartPage extends StatelessWidget {
  final double creditedAmount;
  final double debitedAmount;
  PieChartPage({this.creditedAmount, this.debitedAmount});
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) {
        return IncomeExpenseBlocBloc();
      },
      child: MaterialApp(
        title: 'Pie chart',
        home: PieChartPagestfull(
          debitedAmount: debitedAmount,
          creditedAmount: creditedAmount,
        ),
      ),
    );
  }
}

class PieChartPagestfull extends StatefulWidget {
  final double creditedAmount;
  final double debitedAmount;
  PieChartPagestfull({this.creditedAmount, this.debitedAmount});
  @override
  _PieChartPageState createState() => _PieChartPageState();
}

class _PieChartPageState extends State<PieChartPagestfull> {
  _PieChartPageState();
  bool toggle = false;
  Map<String, double> dataMap = Map();
  List<Color> colorList = [
    Colors.green,
    Colors.red,
  ];

  ProgressBarHandler _handler;

  @override
  void initState() {
    super.initState();
    dataMap.putIfAbsent("Credited Amount", () => widget.creditedAmount);
    dataMap.putIfAbsent("Debited Amount", () => widget.debitedAmount);
  }

  @override
  Widget build(BuildContext context) {
    var progressBar = ModalRoundedProgressBar(
      handleCallback: (handler) {
        _handler = handler;
        return;
      },
    );
    return BlocListener<IncomeExpenseBlocBloc, IncomeExpenseBlocState>(
      listener: (context, state) {
        if (state is OnSuccess) {
          togglePieChart();
          print("onsucces state called");
        }
      },
      child: BlocBuilder<IncomeExpenseBlocBloc, IncomeExpenseBlocState>(
        builder: (context, state) {
          return Stack(children: <Widget>[mainUI(), progressBar]);
        },
      ),
    );
  }

  mainUI() {
    return Scaffold(
      appBar: AppBar(
        title: Text("Income & Expenses"),
        centerTitle: true,
      ),
      body: Container(
        child: Center(
          child: toggle
              ? PieChart(
                  dataMap: dataMap,
                  animationDuration: Duration(milliseconds: 800),
                  chartLegendSpacing: 32.0,
                  chartRadius: MediaQuery.of(context).size.width / 2.7,
                  showChartValuesInPercentage: true,
                  showChartValues: true,
                  showChartValuesOutside: false,
                  chartValueBackgroundColor: Colors.grey[200],
                  colorList: colorList,
                  showLegends: true,
                  legendPosition: LegendPosition.right,
                  decimalPlaces: 1,
                  showChartValueLabel: true,
                  initialAngle: 0,
                  chartValueStyle: defaultChartValueStyle.copyWith(
                    color: Colors.blueGrey[900].withOpacity(0.9),
                  ),
                  chartType: ChartType.disc,
                )
              : Text("Press FAB to Know the Income&Expenses"),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          BlocProvider.of<IncomeExpenseBlocBloc>(context).add(
            ShowChart(),
          );
        },
        child: Icon(Icons.insert_chart),
      ),
    );
  }

  void togglePieChart() {
    setState(() {
      toggle = !toggle;
    });
  }
}
