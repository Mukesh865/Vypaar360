/// Enum representing the status of the signup process
/**
 * - initial: Before form submission starts
 * - submitting: While the form is being submitted (loading state)
 * - success: When signup succeeds
 * - failure: When signup fails (API error, etc.)
 */
enum SignupStatus { initial, submitting, success, failure }

/**
 * State class for the Signup screen.
 * Holds all form fields, validation errors, form status, and submission state.
 */
class SignupState {
  final String fullName; // User's entered full name
  final String email; // User's entered email
  final String password; // User's entered password
  final bool isPasswordVisible; // Controls password field visibility (show/hide)
  final bool isChecked; // Whether user agreed to terms (checkbox)
  final SignupStatus status; // Current signup process status
  final bool isFormValid; // Whether the form is currently valid (all fields + checkbox)

  final String? fullNameError; // Validation error for full name field (null = no error)
  final String? emailError; // Validation error for email field (null = no error)
  final String? passwordError; // Validation error for password field (null = no error)

  /// Constructor with default values for initial state
  SignupState({
    this.fullName = '',
    this.email = '',
    this.password = '',
    this.isPasswordVisible = false,
    this.isChecked = false,
    this.status = SignupStatus.initial,
    this.isFormValid = false,
    this.fullNameError,
    this.emailError,
    this.passwordError,
  });

  /**
   * Returns a new SignupState by copying the current state and
   * replacing only the fields provided as parameters.
   * Helps maintain immutability for Bloc state management.
   */
  SignupState copyWith({
    String? fullName,
    String? email,
    String? password,
    bool? isPasswordVisible,
    bool? isChecked,
    SignupStatus? status,
    bool? isFormValid,
    String? fullNameError,
    String? emailError,
    String? passwordError,
  }) {
    return SignupState(
      fullName: fullName ?? this.fullName,
      email: email ?? this.email,
      password: password ?? this.password,
      isPasswordVisible: isPasswordVisible ?? this.isPasswordVisible,
      isChecked: isChecked ?? this.isChecked,
      status: status ?? this.status,
      isFormValid: isFormValid ?? this.isFormValid,
      fullNameError: fullNameError,
      emailError: emailError,
      passwordError: passwordError,
    );
  }
}
