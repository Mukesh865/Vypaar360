import 'package:vypaar360/blocs/add_expense/add_expense_event.dart';
import 'package:vypaar360/blocs/add_expense/add_expense_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SigningBloc extends Bloc<SigningEvent, SigningState> {
  SigningBloc() : super(SigningState()) {
    on<UploadTapped>((event, emit) async {
      emit(state.copyWith(isUploading: true));

      // Simulate a file upload or use file picker here
      await Future.delayed(const Duration(seconds: 2));

      emit(state.copyWith(isUploading: false));
    });
  }
}
