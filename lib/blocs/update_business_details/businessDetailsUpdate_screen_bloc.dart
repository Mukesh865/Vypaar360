import 'package:flutter_bloc/flutter_bloc.dart';
import 'businessDetailsUpdate_screen_event.dart';
import 'businessDetailsUpdate_screen_state.dart';

class BusinessDetailsUpdateBloc extends Bloc<BusinessDetailsUpdateEvent, BusinessDetailsUpdateState> {
  BusinessDetailsUpdateBloc() : super(BusinessDetailsUpdateState()) {
    on<InitializeBusinessDetails>(_onInitialize);
    on<BusinessFieldChanged>(_onFieldChanged);
    on<SubmitBusinessDetails>(_onSubmit);
  }

  void _onInitialize(
      InitializeBusinessDetails event,
      Emitter<BusinessDetailsUpdateState> emit,
      ) {
    emit(state.copyWith(
      businessName: event.businessName,
      contactNumber: event.contactNumber,
      email: event.email,
      gstNo: event.gstNo,
      panNo: event.panNo,
      udhyamNo: event.udhyamNo,
    ));
  }

  void _onFieldChanged(
      BusinessFieldChanged event,
      Emitter<BusinessDetailsUpdateState> emit,
      ) {
    switch (event.field) {
      case 'taxCode':
        emit(state.copyWith(taxCode: event.value));
        break;
      case 'address':
        emit(state.copyWith(address: event.value));
        break;
      case 'email':
        emit(state.copyWith(email: event.value));
        break;
      case 'gstNo':
        emit(state.copyWith(gstNo: event.value));
        break;
      case 'panNo':
        emit(state.copyWith(panNo: event.value));
        break;
    }
  }

  void _onSubmit(
      SubmitBusinessDetails event,
      Emitter<BusinessDetailsUpdateState> emit,
      ) async {
    emit(state.copyWith(isSubmitting: true, isSuccess: false, isFailure: false));

    await Future.delayed(const Duration(seconds: 2)); // Simulate network call

    // Simulate success (or failure logic here)
    final isValid = state.email.isNotEmpty && state.address.isNotEmpty;

    if (isValid) {
      emit(state.copyWith(isSubmitting: false, isSuccess: true));
    } else {
      emit(state.copyWith(isSubmitting: false, isFailure: true));
    }
  }
}
