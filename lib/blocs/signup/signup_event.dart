/// Abstract base class for all signup-related events.
/// Every form field change or button action will extend this.
abstract class SignupEvent {}

/// Event: Triggered when user updates the Full Name field
class FullNameChanged extends SignupEvent {
  final String fullName; // New full name entered by the user

  FullNameChanged(this.fullName);
}

/// Event: Triggered when user updates the Email field
class EmailChanged extends SignupEvent {
  final String email; // New email entered by the user

  EmailChanged(this.email);
}

/// Event: Triggered when user updates the Password field
class PasswordChanged extends SignupEvent {
  final String password; // New password entered by the user

  PasswordChanged(this.password);
}

/// Event: Triggered when user taps the password visibility toggle icon
/// (Used to show/hide password text field contents)
class TogglePasswordVisibility extends SignupEvent {}

/// Event: Triggered when user toggles the signup agreement checkbox
/// (e.g., Terms & Conditions or Privacy Policy agreement)
class SignupAgreementToggled extends SignupEvent {}

/// Event: Triggered when user submits the signup form
/// Starts validation and submission flow inside the Bloc
class SubmitSignup extends SignupEvent {}
