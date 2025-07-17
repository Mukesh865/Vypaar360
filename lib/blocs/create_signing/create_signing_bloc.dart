import 'package:flutter_bloc/flutter_bloc.dart';
import 'create_signing_event.dart';
import 'create_signing_state.dart';

/// Bloc responsible for handling all create signing form-related logic.
/// It listens for form field changes and submission events,
/// then updates the state accordingly.
class CreateSigningBloc extends Bloc<CreateSigningEvent, CreateSigningState> {
  CreateSigningBloc() : super(const CreateSigningState()) {
    
    /// Event handler for updating the service name field
    on<ServiceNameChanged>((event, emit) {
      emit(state.copyWith(serviceName: event.serviceName));
    });

    /// Event handler for updating the signing date field
    on<SigningDateChanged>((event, emit) {
      emit(state.copyWith(signingDate: event.date));
    });

    /// Event handler for updating the selected time field
    on<SelectTimeChanged>((event, emit) {
      emit(state.copyWith(selectedTime: event.time));
    });

    /// Event handler for updating the amount field
    on<AmountChanged>((event, emit) {
      emit(state.copyWith(amount: event.amount));
    });

    /// Event handler for updating the signer field
    on<SignerChanged>((event, emit) {
      emit(state.copyWith(signer: event.signer));
    });

    /// Event handler for updating the GST number field
    on<GstNoChanged>((event, emit) {
      emit(state.copyWith(gstNo: event.gstNo));
    });

    /// Event handler for updating the property address field
    on<PropertyAddressChanged>((event, emit) {
      emit(state.copyWith(propertyAddress: event.address));
    });

    /// Event handler for form submission
    on<SubmitCreateSigning>((event, emit) {
      // Set loading state before submission process starts
      emit(state.copyWith(isSubmitting: true));

      // Simulate a network call or processing delay
      Future.delayed(const Duration(seconds: 1), () {
        // After delay, mark submission as successful
        emit(state.copyWith(
          isSubmitting: false,
          isSuccess: true,
        ));
      });
    });
  }
}
