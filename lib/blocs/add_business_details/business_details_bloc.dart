import 'package:flutter_bloc/flutter_bloc.dart';
// import 'dart:io'; // Needed for File
import 'business_details_event.dart';
import 'business_details_state.dart';

class BusinessDetailsBloc extends Bloc<BusinessDetailsEvent, BusinessDetailsState> {
  BusinessDetailsBloc() : super(BusinessDetailsState()) {
    // Handle Business Name
    on<UpdateBusinessName>((event, emit) {
      emit(state.copyWith(businessName: event.businessName));
    });

    // Handle Contact Number
    on<UpdateContactNumber>((event, emit) {
      emit(state.copyWith(contactNumber: event.contactNumber));
    });

    // Handle Email
    on<UpdateEmailAddress>((event, emit) {
      emit(state.copyWith(emailAddress: event.emailAddress));
    });

    // Handle GST Number
    on<UpdateGstNumber>((event, emit) {
      emit(state.copyWith(gstNumber: event.gstNumber));
    });

    // Handle PAN Number
    on<UpdatePanNumber>((event, emit) {
      emit(state.copyWith(panNumber: event.panNumber));
    });

    // Handle Udhyam Number
    on<UpdateUdhyamNumber>((event, emit) {
      emit(state.copyWith(udhyamNumber: event.udhyamNumber));
    });

    // Handle Profile Image Update
    on<UpdateProfileImage>((event, emit) {
      emit(state.copyWith(profileImage: event.imageFile));
    });

    // Simulate Form Submission
    on<SubmitForm>((event, emit) async {
      emit(state.copyWith(isSubmitting: true));
      await Future.delayed(Duration(seconds: 2)); // Simulated delay
      emit(state.copyWith(isSubmitting: false,
        formSubmissionSuccess: true,
      ));
    });
  }
}
