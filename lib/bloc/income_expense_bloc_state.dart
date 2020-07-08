import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

abstract class IncomeExpenseBlocState extends Equatable {
  const IncomeExpenseBlocState();
}

class InitialIncomeExpenseBlocState extends IncomeExpenseBlocState {
  @override
  List<Object> get props => [];
}

class OnSuccess extends IncomeExpenseBlocState {
  @override
  // TODO: implement props
  List<Object> get props => null;
}
