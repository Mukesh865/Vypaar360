import 'package:vypaar360/blocs/expense/expense_screen_event.dart';
import 'package:vypaar360/blocs/expense/expense_screen_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


class ExpenseBloc extends Bloc<ExpenseEvent, ExpenseState> {
  ExpenseBloc() : super(ExpenseState()) {
    on<ChangeFilter>((event, emit) {
      emit(state.copyWith(selectedFilter: event.filter));
    });
  }
}
