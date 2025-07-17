import 'package:vypaar360/blocs/signup/signup_event.dart';
import 'package:vypaar360/blocs/signup/signup_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/**
 * Bloc responsible for managing the Signup screen state and logic.
 * Handles form field changes, form validation, agreement toggling, and submission process.
 */
class SignupBloc extends Bloc<SignupEvent, SignupState> {
  SignupBloc() : super(SignupState()) {
    
    // Event: User updated Full Name field
    on<FullNameChanged>((event, emit) {
      emit(_validateForm(fullName: event.fullName));
    });

    // Event: User updated Email field
    on<EmailChanged>((event, emit) {
      emit(_validateForm(email: event.email));
    });

    // Event: User updated Password field
    on<PasswordChanged>((event, emit) {
      emit(_validateForm(password: event.password));
    });

    // Event: User toggled agreement checkbox (Terms & Conditions)
    on<SignupAgreementToggled>((event, emit) {
      emit(_validateForm(isChecked: !state.isChecked));
    });

    // Event: User submitted the signup form
    on<SubmitSignup>((event, emit) async {
      final fullNameError =
          state.fullName.trim().isEmpty ? 'Full name is required' : null;

      final emailError =
          !state.email.contains('@') ? 'Enter a valid email' : null;

      final passwordError =
          state.password.length < 6 ? 'Minimum 6 characters required' : null;

      final isFormValid =
          fullNameError == null &&
          emailError == null &&
          passwordError == null &&
          state.isChecked;

      // Emit updated state with validation errors and form validity flag
      emit(
        state.copyWith(
          fullNameError: fullNameError,
          emailError: emailError,
          passwordError: passwordError,
          isFormValid: isFormValid,
        ),
      );

      // Stop submission if form is invalid
      if (!isFormValid) return;

      // Emit submitting state (show loading UI)
      emit(state.copyWith(status: SignupStatus.submitting));

      try {
        await Future.delayed(Duration(seconds: 1)); // Simulate API call delay
        // On success, emit success state
        emit(state.copyWith(status: SignupStatus.success));
      } catch (_) {
        // On failure, emit failure state
        emit(state.copyWith(status: SignupStatus.failure));
      }
    });
  }

  /**
   * Validates the signup form fields and returns updated state.
   * This is called whenever a form field changes or checkbox is toggled.
   */
  SignupState _validateForm({
    String? fullName,
    String? email,
    String? password,
    bool? isChecked,
  }) {
    final name = fullName ?? state.fullName;
    final mail = email ?? state.email;
    final pass = password ?? state.password;
    final checked = isChecked ?? state.isChecked;

    final fullNameError = name.trim().isEmpty ? 'Full name is required' : null;
    final emailError = !mail.contains('@') ? 'Enter a valid email' : null;
    final passwordError = pass.length < 6 ? 'Minimum 6 characters required' : null;

    final isFormValid =
        fullNameError == null &&
        emailError == null &&
        passwordError == null &&
        checked;

    return state.copyWith(
      fullName: name,
      email: mail,
      password: pass,
      isChecked: checked,
      fullNameError: fullNameError,
      emailError: emailError,
      passwordError: passwordError,
      isFormValid: isFormValid,
    );
  }
}
