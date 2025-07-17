import 'dart:async';
import 'package:vypaar360/blocs/otp_verification/OTP_Event.dart';
import 'package:vypaar360/blocs/otp_verification/otp_bloc_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class OtpBloc extends Bloc<OtpEvent, OtpState> {
  Timer? _timer;

  OtpBloc() : super(OtpState.initial()) {
    on<OtpDigitChanged>(_onDigitChanged);
    on<OtpVerifyRequested>(_onVerifyRequested);
    on<OtpResendRequested>(_onResendRequested);
    on<OtpCountdownTicked>(_onCountdownTicked);

    _startTimer();
  }

  void _onDigitChanged(OtpDigitChanged event, Emitter<OtpState> emit) {
    final updated = List<String>.from(state.otpDigits);
    updated[event.index] = event.value;
    emit(state.copyWith(otpDigits: updated, hasError: false));
  }

  Future<void> _onVerifyRequested(
    OtpVerifyRequested event,
    Emitter<OtpState> emit,
  ) async {
    if (state.otpDigits.any((d) => d.isEmpty)) {
      emit(state.copyWith(hasError: true));
      return;
    }

    emit(state.copyWith(isVerifying: true));

    // ✅ Wait for the delay properly
    await Future.delayed(const Duration(seconds: 1));

    if (!isClosed) {
      emit(state.copyWith(isVerifying: false, isSuccess: true));
    }
  }

  void _onResendRequested(OtpResendRequested event, Emitter<OtpState> emit) {
    if (state.isVerifying) return; // Prevent resend during verification
    emit(OtpState.initial());
    _startTimer();
  }

  void _onCountdownTicked(OtpCountdownTicked event, Emitter<OtpState> emit) {
    if (state.countdown > 0) {
      emit(state.copyWith(countdown: state.countdown - 1));
    } else {
      _timer?.cancel();
    }
  }

  void _startTimer() {
    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 1), (_) {
      add(OtpCountdownTicked());
    });
  }

  @override
  Future<void> close() {
    _timer?.cancel();
    return super.close();
  }
}


/*import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'otp_bloc_state.dart';

class OtpCubit extends Cubit<OtpState> {
  Timer? _timer;

  OtpCubit() : super(OtpState.initial()) {
    _startTimer();
  }

  void updateDigit(int index, String value) {
    final updated = List<String>.from(state.otpDigits);
    updated[index] = value;
    emit(state.copyWith(otpDigits: updated, hasError: false));
  }

  void _startTimer() {
    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (state.countdown == 0) {
        timer.cancel();
      } else {
        emit(state.copyWith(countdown: state.countdown - 1));
      }
    });
  }

  void resendOtp() {
    emit(OtpState.initial());
    _startTimer();
  }

  bool isOtpComplete() {
    return state.otpDigits.every((digit) => digit.isNotEmpty);
  }

  void verifyOtp() {
    if (!isOtpComplete()) {
      emit(state.copyWith(hasError: true));
      return;
    }

    emit(state.copyWith(isVerifying: true));
    final otp = state.otpDigits.join();
    // Simulate verification delay
    Future.delayed(const Duration(seconds: 1), () {
      emit(state.copyWith(isVerifying: false));
      // You can emit success/failure states here
      print('Verifying OTP: $otp');
    });
  }

  @override
  Future<void> close() {
    _timer?.cancel();
    return super.close();
  }
}
*/