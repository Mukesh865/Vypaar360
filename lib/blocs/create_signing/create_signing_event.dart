import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

/// Abstract base class for all Create Signing form events.
/// This allows the Bloc to listen and react to various user actions.
abstract class CreateSigningEvent extends Equatable {
  const CreateSigningEvent();

  @override
  List<Object?> get props => [];
}

/// Event triggered when the service name field changes
class ServiceNameChanged extends CreateSigningEvent {
  final String serviceName;

  const ServiceNameChanged(this.serviceName);

  @override
  List<Object?> get props => [serviceName];
}

/// Event triggered when the signing date is selected or changed
class SigningDateChanged extends CreateSigningEvent {
  final DateTime date;

  const SigningDateChanged(this.date);

  @override
  List<Object?> get props => [date];
}

/// Event triggered when the signing time is selected or changed
class SelectTimeChanged extends CreateSigningEvent {
  final TimeOfDay time;

  const SelectTimeChanged(this.time);

  @override
  List<Object?> get props => [time];
}

/// Event triggered when the amount field changes
class AmountChanged extends CreateSigningEvent {
  final String amount;

  const AmountChanged(this.amount);

  @override
  List<Object?> get props => [amount];
}

/// Event triggered when the signer field changes
class SignerChanged extends CreateSigningEvent {
  final String signer;

  const SignerChanged(this.signer);

  @override
  List<Object?> get props => [signer];
}

/// Event triggered when the GST number field changes
class GstNoChanged extends CreateSigningEvent {
  final String gstNo;

  const GstNoChanged(this.gstNo);

  @override
  List<Object?> get props => [gstNo];
}

/// Event triggered when the property address field changes
class PropertyAddressChanged extends CreateSigningEvent {
  final String address;

  const PropertyAddressChanged(this.address);

  @override
  List<Object?> get props => [address];
}

/// Event triggered when the user submits the create signing form
class SubmitCreateSigning extends CreateSigningEvent {}
