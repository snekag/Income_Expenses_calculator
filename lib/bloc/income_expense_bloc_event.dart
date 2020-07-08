import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:flutter/material.dart';

@immutable
abstract class IncomeExpenseBlocEvent extends Equatable {
  const IncomeExpenseBlocEvent();
}

class ShowChart extends IncomeExpenseBlocEvent {

  const ShowChart();

  @override
  // TODO: implement props
  List<Object> get props => [];
}