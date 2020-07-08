import 'dart:async';
import 'package:bloc/bloc.dart';
import './bloc.dart';

class IncomeExpenseBlocBloc extends Bloc<IncomeExpenseBlocEvent, IncomeExpenseBlocState> {
  @override
  IncomeExpenseBlocState get initialState => InitialIncomeExpenseBlocState();

  @override
  Stream<IncomeExpenseBlocState> mapEventToState(
    IncomeExpenseBlocEvent event,
  ) async* {
    // TODO: Add Logic
    if (event is ShowChart) {
      yield OnSuccess();
    }
  }
}
