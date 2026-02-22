import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import 'package:maori_health/core/config/assets.dart';
import 'package:maori_health/core/config/string_constants.dart';
import 'package:maori_health/core/router/route_names.dart';
import 'package:maori_health/core/theme/app_colors.dart';
import 'package:maori_health/core/utils/extensions.dart';
import 'package:maori_health/core/utils/form_validators.dart';

import 'package:maori_health/presentation/auth/bloc/bloc.dart';
import 'package:maori_health/presentation/shared/decorations/outline_input_decoration.dart';
import 'package:maori_health/presentation/shared/widgets/solid_button.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _obscurePassword = true;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _onLogin() {
    if (!_formKey.currentState!.validate()) return;

    context.read<AuthBloc>().add(
      AuthLoginEvent(email: _emailController.text.trim(), password: _passwordController.text),
    );
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = context.screenSize.height;

    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is AuthenticatedState) {
          context.goNamed(RouteNames.home);
        } else if (state is AuthErrorState) {
          context.showSnackBar(state.errorMessage, isError: true, onTop: true);
        }
      },
      child: Scaffold(
        body: SingleChildScrollView(child: Column(children: [_buildHeaderSection(screenHeight), _buildFormSection()])),
      ),
    );
  }

  Widget _buildHeaderSection(double screenHeight) {
    return SizedBox(
      height: screenHeight * 0.55,
      width: double.infinity,
      child: Stack(
        fit: StackFit.expand,
        children: [
          Image.asset(Assets.assetsImagesLoginBg, fit: BoxFit.cover),
          Center(
            child: Padding(
              padding: const EdgeInsets.only(bottom: 20),
              child: Image.asset(Assets.assetsImagesBannerLogo, width: 200),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFormSection() {
    return Container(
      width: double.infinity,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [AppColors.primary, Color(0xFF8CF5A4)],
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 28),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: .stretch,
            children: [
              TextFormField(
                controller: _emailController,
                keyboardType: .emailAddress,
                textInputAction: .next,
                validator: FormValidators.email(),
                autovalidateMode: .onUserInteraction,
                decoration: OutlineInputDecoration(context: context, hintText: StringConstants.email),
              ),
              const SizedBox(height: 20),
              TextFormField(
                controller: _passwordController,
                obscureText: _obscurePassword,
                textInputAction: TextInputAction.done,
                onFieldSubmitted: (_) => _onLogin(),
                validator: FormValidators.password(),
                autovalidateMode: .onUserInteraction,
                keyboardType: .visiblePassword,
                decoration: OutlineInputDecoration(
                  context: context,
                  hintText: StringConstants.password,
                  suffixIcon: IconButton(
                    icon: Icon(
                      _obscurePassword ? Icons.visibility_outlined : Icons.visibility_off_outlined,
                      color: context.theme.hintColor,
                      size: 22,
                    ),
                    onPressed: () {
                      setState(() => _obscurePassword = !_obscurePassword);
                    },
                  ),
                ),
              ),
              const SizedBox(height: 8),
              Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                  onPressed: () {
                    // TODO: Navigate to forgot password
                  },
                  child: Text(
                    StringConstants.forgotPassword,
                    style: context.textTheme.bodyMedium?.copyWith(
                      color: const Color(0xFF1A5E2D),
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              BlocBuilder<AuthBloc, AuthState>(
                buildWhen: (prev, curr) => prev.runtimeType != curr.runtimeType,
                builder: (context, state) {
                  return SolidButton(
                    onPressed: _onLogin,
                    isLoading: state is AuthLoadingState,
                    backgroundColor: const Color(0xFF1A5E2D),
                    foregroundColor: Colors.white,
                    child: Text(
                      StringConstants.login,
                      style: context.textTheme.titleMedium?.copyWith(color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                  );
                },
              ),
              const SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }
}
