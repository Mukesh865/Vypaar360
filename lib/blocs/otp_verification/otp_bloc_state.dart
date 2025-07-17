import 'package:equatable/equatable.dart';

class OtpState extends Equatable {
  final List<String> otpDigits;
  final int countdown;
  final bool hasError;
  final bool isVerifying;
  final bool isSuccess;


 const OtpState({
  required this.otpDigits,
  required this.countdown,
  this.hasError = false,
  this.isVerifying = false,
  this.isSuccess = false,
});

  factory OtpState.initial() => OtpState(
    otpDigits: List.filled(4, ''),
    countdown: 60,
  );

 OtpState copyWith({
  List<String>? otpDigits,
  int? countdown,
  bool? hasError,
  bool? isVerifying,
  bool? isSuccess,
}) {
  return OtpState(
    otpDigits: otpDigits ?? this.otpDigits,
    countdown: countdown ?? this.countdown,
    hasError: hasError ?? this.hasError,
    isVerifying: isVerifying ?? this.isVerifying,
    isSuccess: isSuccess ?? this.isSuccess,
  );
}
  @override
  List<Object> get props => [otpDigits, countdown, hasError, isVerifying, isSuccess];

}
