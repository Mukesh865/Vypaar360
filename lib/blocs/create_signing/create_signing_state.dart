import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

/// State class representing the current state of the Create Signing form.
/// It holds all the user-input fields, form status flags, and supports immutability.
class CreateSigningState extends Equatable {
  // --- Form Fields ---

  /// Name of the service for which signing is being created
  final String serviceName;

  /// Selected date for the signing
  final DateTime? signingDate;

  /// Selected time for the signing
  final TimeOfDay? selectedTime;

  /// Entered amount for the signing
  final String amount;

  /// Name of the signer involved
  final String signer;

  /// GST number entered (if any)
  final String gstNo;

  /// Property address entered for the signing
  final String propertyAddress;

  // --- Form Status Flags ---

  /// Flag to indicate if form submission is in progress (loading state)
  final bool isSubmitting;

  /// Flag to indicate if form submission was successful
  final bool isSuccess;

  /// Flag to indicate if form submission failed
  final bool isFailure;

  /// Constructor with default values for all fields
  const CreateSigningState({
    this.serviceName = '',
    this.signingDate,
    this.selectedTime,
    this.amount = '',
    this.signer = '',
    this.gstNo = '',
    this.propertyAddress = '',
    this.isSubmitting = false,
    this.isSuccess = false,
    this.isFailure = false,
  });

  /// Creates a new state object by copying the current state
  /// and replacing only the fields that are provided.
  CreateSigningState copyWith({
    String? serviceName,
    DateTime? signingDate,
    TimeOfDay? selectedTime,
    String? amount,
    String? signer,
    String? gstNo,
    String? propertyAddress,
    bool? isSubmitting,
    bool? isSuccess,
    bool? isFailure,
  }) {
    return CreateSigningState(
      serviceName: serviceName ?? this.serviceName,
      signingDate: signingDate ?? this.signingDate,
      selectedTime: selectedTime ?? this.selectedTime,
      amount: amount ?? this.amount,
      signer: signer ?? this.signer,
      gstNo: gstNo ?? this.gstNo,
      propertyAddress: propertyAddress ?? this.propertyAddress,
      isSubmitting: isSubmitting ?? this.isSubmitting,
      isSuccess: isSuccess ?? this.isSuccess,
      isFailure: isFailure ?? this.isFailure,
    );
  }

  /// Required for Bloc state comparison (equatable package).
  /// Ensures that Bloc only emits new state when data actually changes.
  @override
  List<Object?> get props => [
        serviceName,
        signingDate,
        selectedTime,
        amount,
        signer,
        gstNo,
        propertyAddress,
        isSubmitting,
        isSuccess,
        isFailure,
      ];
}
