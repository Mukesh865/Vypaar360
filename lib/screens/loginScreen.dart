import 'package:vypaar360/blocs/login/login_bloc.dart';
import 'package:vypaar360/blocs/login/login_event.dart';
import 'package:vypaar360/blocs/login/login_state.dart';
import 'package:vypaar360/screens/OTP_Screen.dart';
import 'package:vypaar360/screens/dashboard_screen.dart';
import 'package:vypaar360/widgets/frosted_glass_text_field.dart';
import 'package:vypaar360/widgets/glassy_background_scaffold.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class GlassyLoginScreen extends StatefulWidget {
  const GlassyLoginScreen({super.key});

  @override
  State<GlassyLoginScreen> createState() => _GlassyLoginScreenState();
}

class _GlassyLoginScreenState extends State<GlassyLoginScreen> {
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController emailController = TextEditingController();

  bool _obscureText = true; //  Password visibility toggle

  @override
  Widget build(BuildContext context) {
    return GlassyBackgroundScaffold(
      child: BlocListener<LoginBloc, LoginState>(
        listener: (context, state) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            if (state.isSuccess) {
              ScaffoldMessenger.of(
                context,
              ).showSnackBar(const SnackBar(content: Text("Login successful")));
              // Navigator.pushReplacement(
              //   context,
              //   MaterialPageRoute(
              //     builder: (context) => const DashboardScreen(),
              //   ),
              // );

              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => OtpScreen()),
              );
            } else if (state.isFailure) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text("Invalid email or password")),
              );
            }
          });
        },
        child: SizedBox(
          width: 390,
          height: 844,
          child: Stack(
            children: [
              // 🔥 Logo
              Positioned(
                top: 55,
                left: 20,
                child: SizedBox(
                  width: 160,
                  height: 134,
                  child: Image.asset('assets/images/logo.png'),
                ),
              ),

              // 🔥 Tagline
              Positioned(
                top: 218,
                left: 20,
                child: const SizedBox(
                  width: 177,
                  height: 72,
                  child: Text(
                    'Empower Your Business',
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      color: Colors.white,
                      fontSize: 22,
                      fontWeight: FontWeight.w600,
                      letterSpacing: 0.5,
                      height: 1.2,
                    ),
                  ),
                ),
              ),

              // 📧 Email Field
              Positioned(
                top: 320,
                left: 20,
                child: SizedBox(
                  width: 315,
                  height: 55,
                  child: FrostedGlassTextField(
                    hintText: 'Email Address',
                    controller: emailController,
                    keyboardType: TextInputType.emailAddress,
                    onChanged: (value) {
                      context.read<LoginBloc>().add(EmailChanged(value));
                    },
                  ),
                ),
              ),

              // 🔒 Password Field with eye toggle
              Positioned(
                top: 405,
                left: 20,
                child: SizedBox(
                  width: 315,
                  height: 55,
                  child: FrostedGlassTextField(
                    hintText: 'Password',
                    controller: passwordController,
                    obscureText: _obscureText,
                    onChanged: (value) {
                      context.read<LoginBloc>().add(PasswordChanged(value));
                    },
                    suffixIcon: IconButton(
                      icon: Icon(
                        _obscureText ? Icons.visibility_off : Icons.visibility,
                        color: Colors.white,
                      ),
                      onPressed: () {
                        setState(() {
                          _obscureText = !_obscureText;
                        });
                      },
                    ),
                  ),
                ),
              ),

              // 🔥 Sign In Button
              Positioned(
                top: 491,
                left: 20,
                child: SizedBox(
                  width: 315,
                  height: 43,
                  child: BlocBuilder<LoginBloc, LoginState>(
                    buildWhen:
                        (prev, curr) => prev.isSubmitting != curr.isSubmitting,
                    builder: (context, state) {
                      return GestureDetector(
                        onTap:
                        state.isSubmitting
                            ? null
                            : () {
                          FocusScope.of(context).unfocus();
                          context.read<LoginBloc>().add(
                            LoginSubmitted(),
                          );
                        },
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(35),
                          child: Container(
                            alignment: Alignment.center,
                            color: Colors.white.withOpacity(0.1),
                            child:
                            state.isSubmitting
                                ? const CircularProgressIndicator(
                              valueColor: AlwaysStoppedAnimation<Color>(
                                Colors.white,
                              ),
                              strokeWidth: 2,
                            )
                                : const Text(
                              'Sign In',
                              style: TextStyle(
                                fontFamily: 'Poppins',
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                letterSpacing: 1.2,
                                fontSize: 16,
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),

              // 🌐 Social Sign-In Prompt
              const Positioned(
                top: 564,
                left: 28,
                child: SizedBox(
                  width: 93,
                  height: 21,
                  child: Text(
                    'or sign in via',
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      color: Colors.white,
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      letterSpacing: 0.5,
                    ),
                  ),
                ),
              ),

              // 🟢 Google Icon
              Positioned(
                top: 598,
                left: 60,
                right: 60,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Image.asset(
                      'assets/icons/google.png',
                      width: 30,
                      height: 25,
                    ),
                    Image.asset(
                      'assets/icons/apple.png',
                      width: 30,
                      height: 40,
                    ),
                    Image.asset(
                      'assets/icons/linkedin.png',
                      width: 30,
                      height: 40,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
