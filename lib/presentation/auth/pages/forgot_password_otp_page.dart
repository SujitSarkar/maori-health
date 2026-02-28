import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:maori_health/core/router/route_names.dart';
import 'package:pinput/pinput.dart';

import 'package:maori_health/core/config/string_constants.dart';
import 'package:maori_health/core/utils/extensions.dart';

import 'package:maori_health/presentation/auth/bloc/auth_bloc.dart';
import 'package:maori_health/presentation/auth/bloc/auth_state.dart';
import 'package:maori_health/presentation/auth/widgets/auth_back_bar_widget.dart';
import 'package:maori_health/presentation/auth/widgets/auth_layout.dart';
import 'package:maori_health/presentation/shared/decorations/pin_decoration.dart';
import 'package:maori_health/presentation/shared/widgets/solid_button.dart';

class ForgotPasswordOtpPage extends StatefulWidget {
  const ForgotPasswordOtpPage({super.key, required this.email});
  final String email;

  @override
  State<ForgotPasswordOtpPage> createState() => _ForgotPasswordOtpPageState();
}

class _ForgotPasswordOtpPageState extends State<ForgotPasswordOtpPage> {
  final _otpController = TextEditingController();
  final _otpFocusNode = FocusNode();

  @override
  void initState() {
    _otpFocusNode.requestFocus();
    super.initState();
  }

  @override
  void dispose() {
    _otpFocusNode.dispose();
    _otpController.dispose();
    super.dispose();
  }

  void _onVerifyCode() {
    if (_otpController.text.trim().length != 6) {
      return;
    }
    context.goNamed(RouteNames.resetPassword, extra: {'email': widget.email});
    // context.read<AuthBloc>().add(
    //   AuthLoginEvent(email: _emailController.text.trim(), password: _passwordController.text),
    // );
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = context.screenSize.height;

    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is AuthenticatedState) {
          // context.goNamed(RouteNames.home);
        } else if (state is AuthErrorState) {
          context.showSnackBar(state.errorMessage, isError: true, onTop: true);
        }
      },
      child: AuthLayout(child: _buildFormSection(screenHeight)),
    );
  }

  Widget _buildFormSection(double screenHeight) {
    return Column(
      crossAxisAlignment: .start,
      children: [
        AuthBackBarWidget(
          title: StringConstants.checkYourEmail,
          subTitle: 'We sent a reset link to ${widget.email}\nenter 6 digit code that mentioned in the email',
        ),
        const SizedBox(height: 40),
        Pinput(
          controller: _otpController,
          focusNode: _otpFocusNode,
          length: 6,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          defaultPinTheme: DefaultPinTheme(),
          focusedPinTheme: FocusedPinTheme(),
          keyboardType: TextInputType.number,
          inputFormatters: [FilteringTextInputFormatter.digitsOnly],
        ),
        const SizedBox(height: 40),
        BlocBuilder<AuthBloc, AuthState>(
          buildWhen: (prev, curr) => prev.runtimeType != curr.runtimeType,
          builder: (context, state) {
            return SolidButton(
              onPressed: _onVerifyCode,
              isLoading: state is AuthLoadingState,
              backgroundColor: const Color(0xFF1A5E2D),
              foregroundColor: Colors.white,
              child: Text(
                StringConstants.verifyCode,
                style: context.textTheme.titleMedium?.copyWith(color: Colors.white, fontWeight: .bold),
              ),
            );
          },
        ),
        SizedBox(height: screenHeight * 0.25),
      ],
    );
  }
}
