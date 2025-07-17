import 'package:equatable/equatable.dart';

abstract class OtpEvent extends Equatable {
  const OtpEvent();
  @override
  List<Object> get props => [];
}

class OtpDigitChanged extends OtpEvent {
  final int index;
  final String value;
  const OtpDigitChanged(this.index, this.value);
  @override
  List<Object> get props => [index, value];
}

class OtpVerifyRequested extends OtpEvent {}

class OtpResendRequested extends OtpEvent {}

class OtpCountdownTicked extends OtpEvent {}
