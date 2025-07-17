import 'dart:ui';
import 'package:vypaar360/blocs/add_business_details/business_details_bloc.dart';
import 'package:vypaar360/blocs/login/login_bloc.dart';
import 'package:vypaar360/screens/businessdetails_screen.dart';
import 'package:vypaar360/screens/loginScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vypaar360/blocs/signup/signup_bloc.dart';
import 'package:vypaar360/blocs/signup/signup_event.dart';
import 'package:vypaar360/blocs/signup/signup_state.dart';
import 'package:vypaar360/widgets/frosted_glass_text_field.dart';
import 'package:vypaar360/widgets/glassy_background_scaffold.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  late final TextEditingController fullNameController;
  late final TextEditingController emailController;
  late final TextEditingController passwordController;

  @override
  void initState() {
    super.initState();
    fullNameController = TextEditingController();
    emailController = TextEditingController();
    passwordController = TextEditingController();
  }

  @override
  void dispose() {
    fullNameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    final isLandscape =
        MediaQuery.of(context).orientation == Orientation.landscape;
    final isTablet = screenWidth > 600;

    return BlocProvider(
      create: (_) => SignupBloc(),
      child: BlocListener<SignupBloc, SignupState>(
        listenWhen: (previous, current) => previous.status != current.status,
        listener: (context, state) {
          /// ✅ Navigate to Dashboard on success
          if (state.status == SignupStatus.success && context.mounted) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder:
                      (_) => BlocProvider(
                        create: (_) => BusinessDetailsBloc(),
                        child: BusinessDetailsScreen(),
                      ),
                ),
              );
            });
          }
          /// ✅ Show Error SnackBar on failure
          else if (state.status == SignupStatus.failure && context.mounted) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text("Signup failed. Please try again.")),
            );
          }
        },
        child: GlassyBackgroundScaffold(
          child: SafeArea(
            child: GestureDetector(
              onTap:
                  () =>
                      FocusScope.of(
                        context,
                      ).unfocus(), // ✅ Dismiss keyboard on outside tap
              child: Center(
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 900),
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: isTablet ? 32 : 16,
                      vertical: 16,
                    ),
                    child: Builder(
                      builder: (innerContext) {
                        return isLandscape && isTablet
                            ? _buildLandscapeLayout(innerContext, screenHeight)
                            : _buildPortraitLayout(innerContext, screenHeight);
                      },
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  /// -------- Portrait Layout (Mobile Portrait) --------
  Widget _buildPortraitLayout(BuildContext context, double screenHeight) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isTablet = screenWidth > 600;

    Widget formContent = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 40),
        Image.asset('assets/images/logo.png', height: 70),
        const SizedBox(height: 24),
        const Text(
          "Create Your Account \nto get started with \nVyapaar360",
          style: TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 32),
        _buildFormFields(context),
      ],
    );

    return SingleChildScrollView(
      keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
      child: ConstrainedBox(
        constraints: BoxConstraints(minHeight: screenHeight - 48),
        child:
            isTablet
                ? Center(
                  child: ConstrainedBox(
                    constraints: const BoxConstraints(maxWidth: 600),
                    child: formContent,
                  ),
                )
                : formContent,
      ),
    );
  }

  /// -------- Landscape Layout (Tablet & Mobile Landscape) --------
  Widget _buildLandscapeLayout(BuildContext context, double screenHeight) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isTablet = screenWidth > 600;

    return SizedBox(
      height: screenHeight - 48,
      child: Row(
        children: [
          /// Left: Logo and Text
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image.asset(
                    'assets/images/logo.png',
                    height: isTablet ? 120 : 80,
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    "Create Your Account \nto get started with \nVyapaar360",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(width: 24),

          /// Right: Scrollable Form
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: SingleChildScrollView(
                keyboardDismissBehavior:
                    ScrollViewKeyboardDismissBehavior.onDrag,
                child: _buildFormFields(context),
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// -------- Form Fields (Common for Both Layouts) --------
  Widget _buildFormFields(BuildContext context) {
    return ConstrainedBox(
      constraints: const BoxConstraints(maxWidth: 600),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          /// Full Name
          BlocBuilder<SignupBloc, SignupState>(
            buildWhen: (p, c) => p.fullName != c.fullName,
            builder:
                (context, state) => FrostedGlassTextField(
                  hintText: "Full Name",
                  controller: fullNameController,
                  errorText: state.fullNameError,
                  onChanged:
                      (val) =>
                          context.read<SignupBloc>().add(FullNameChanged(val)),
                ),
          ),
          const SizedBox(height: 16),

          /// Email
          BlocBuilder<SignupBloc, SignupState>(
            buildWhen: (p, c) => p.email != c.email,
            builder:
                (context, state) => FrostedGlassTextField(
                  hintText: "Email Address",
                  controller: emailController,
                  keyboardType: TextInputType.emailAddress,
                  errorText: state.emailError,
                  onChanged:
                      (val) =>
                          context.read<SignupBloc>().add(EmailChanged(val)),
                ),
          ),
          const SizedBox(height: 16),

          /// Password with Visibility Toggle
          BlocBuilder<SignupBloc, SignupState>(
            buildWhen:
                (p, c) =>
                    p.password != c.password ||
                    p.isPasswordVisible != c.isPasswordVisible,
            builder:
                (context, state) => FrostedGlassTextField(
                  hintText: "Password",
                  controller: passwordController,
                  obscureText: !state.isPasswordVisible,
                  errorText: state.passwordError,
                  onChanged:
                      (val) =>
                          context.read<SignupBloc>().add(PasswordChanged(val)),
                  suffixIcon: IconButton(
                    icon: Icon(
                      state.isPasswordVisible
                          ? Icons.visibility
                          : Icons.visibility_off,
                      color: Colors.white70,
                    ),
                    onPressed:
                        () => context.read<SignupBloc>().add(
                          TogglePasswordVisibility(),
                        ),
                  ),
                ),
          ),
          const SizedBox(height: 16),

          /// Terms Agreement Checkbox
          BlocBuilder<SignupBloc, SignupState>(
            buildWhen: (p, c) => p.isChecked != c.isChecked,
            builder:
                (context, state) => Row(
                  children: [
                    Checkbox(
                      value: state.isChecked,
                      onChanged:
                          (_) => context.read<SignupBloc>().add(
                            SignupAgreementToggled(),
                          ),
                      activeColor: Colors.white,
                      checkColor: Colors.black,
                    ),
                    const Expanded(
                      child: Text(
                        "By signing up, you agree to the Terms of Service and Privacy Policy",
                        style: TextStyle(fontSize: 12, color: Colors.white70),
                      ),
                    ),
                  ],
                ),
          ),
          const SizedBox(height: 16),

          /// Signup Button
          BlocBuilder<SignupBloc, SignupState>(
            builder: (context, state) => _buildSubmitButton(context, state),
          ),
          const SizedBox(height: 16),

          /// Already Have an Account
          TextButton(
            onPressed: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder:
                      (_) => BlocProvider(
                        create: (_) => LoginBloc(),
                        child: GlassyLoginScreen(),
                      ),
                ),
              );
            },
            child: const Text(
              "Already have an account? Sign In",
              style: TextStyle(color: Colors.white70),
            ),
          ),
        ],
      ),
    );
  }

  /// -------- Glassy Signup Button --------
  Widget _buildSubmitButton(BuildContext context, SignupState state) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(25),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
        child: Container(
          height: 55,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(25),
            gradient: const LinearGradient(
              colors: [Color(0x33FFFFFF), Color(0x22FFFFFF)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            border: Border.all(color: Colors.white.withOpacity(0.3)),
            boxShadow: [
              BoxShadow(
                color: Colors.white.withOpacity(0.15),
                blurRadius: 12,
                offset: const Offset(0, 6),
              ),
            ],
          ),
          child: ElevatedButton(
            onPressed:
                state.isFormValid
                    ? () => context.read<SignupBloc>().add(SubmitSignup())
                    : null,
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.transparent,
              shadowColor: Colors.transparent,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(25),
              ),
            ),
            child: const Text(
              "Sign Up",
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w600,
                letterSpacing: 0.5,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
