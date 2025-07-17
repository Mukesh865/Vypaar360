import 'package:vypaar360/blocs/login/login_bloc.dart';
import 'package:vypaar360/blocs/otp_verification/OTP_Event.dart';
import 'package:vypaar360/blocs/otp_verification/otp_bloc_state.dart';
import 'package:vypaar360/blocs/otp_verification/otp_bloc_state_builder.dart';
import 'package:vypaar360/screens/dashboard_screen.dart';
// import 'package:vypaar360/screens/dashboard_screen.dart';
import 'package:vypaar360/screens/loginScreen.dart';
import 'package:vypaar360/widgets/frosted_glass_text_field.dart';
import 'package:vypaar360/widgets/glassy_background_scaffold.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class OtpScreen extends StatefulWidget {
  const OtpScreen({super.key});

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  late final List<TextEditingController> _controllers;

  @override
  void initState() {
    super.initState();
    _controllers = List.generate(4, (_) => TextEditingController());
  }

  @override
  void dispose() {
    for (final controller in _controllers) {
      controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => OtpBloc(),
      child: BlocListener<OtpBloc, OtpState>(
        listenWhen:
            (previous, current) => previous.isSuccess != current.isSuccess,
        listener: (context, state) {
          if (state.isSuccess) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              // Navigator.pushReplacement(
              //   context,
              //   MaterialPageRoute(
              //     builder:
              //         (_) => BlocProvider(
              //           create: (_) => LoginBloc(),
              //           child: const GlassyLoginScreen(),
              //         ),
              //   )
              // );

              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => const DashboardScreen(),
                ),
              );
            });
          }
        },
        child: BlocBuilder<OtpBloc, OtpState>(
          builder: (context, state) {
            final bloc = context.read<OtpBloc>();

            return GlassyBackgroundScaffold(
              child: Stack(
                children: [
                  // Title & Subtitle
                  const Positioned(
                    top: 63,
                    left: 27,
                    child: Text(
                      'OTP Verification',
                      style: TextStyle(color: Colors.white, fontSize: 20),
                    ),
                  ),
                  const Positioned(
                    top: 215,
                    left: 36,
                    child: Text(
                      'An OTP has been sent to your number',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),

                  // OTP Input Fields
                  ...List.generate(4, (index) {
                    final offset = Offset(37 + (index * 77), 269);
                    return Positioned(
                      top: offset.dy,
                      left: offset.dx,
                      child: SizedBox(
                        width: 58,
                        child: FrostedGlassTextField(
                          hintText: '',
                          controller: _controllers[index],
                          keyboardType: TextInputType.number,
                          onChanged: (val) {
                            final filtered = val.replaceAll(RegExp(r'\D'), '');
                            bloc.add(OtpDigitChanged(index, filtered));
                            if (filtered.length == 1 && index < 3) {
                              FocusScope.of(context).nextFocus();
                            }
                          },
                        ),
                      ),
                    );
                  }),

                  // Verify Button
                  Positioned(
                    top: 360,
                    left: 16,
                    child: ElevatedButton(
                      onPressed: () => bloc.add(OtpVerifyRequested()),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white.withOpacity(0.15),
                      ),
                      child: const Text(
                        'Verify OTP',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),

                  // Countdown or Resend Button
                  Positioned(
                    top: 442,
                    left: 85,
                    child: GestureDetector(
                      onTap:
                          state.countdown == 0
                              ? () => bloc.add(OtpResendRequested())
                              : null,
                      child: Text(
                        state.countdown == 0
                            ? 'Resend OTP'
                            : 'Resend OTP in ${state.countdown}s',
                        style: const TextStyle(color: Color(0xFF6CD3FF)),
                      ),
                    ),
                  ),

                  // Feedback Overlay (optional)
                  if (state.isVerifying)
                    const Center(
                      child: CircularProgressIndicator(color: Colors.white),
                    ),
                  if (state.hasError)
                    const Center(
                      child: Text(
                        'Please fill all digits',
                        style: TextStyle(color: Colors.redAccent),
                      ),
                    ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
