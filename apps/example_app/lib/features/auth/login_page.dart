import 'package:core_l10n/core_l10n.dart';
import 'package:core_state/core_state.dart';
import 'package:example_app/router/route_paths.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final _usernameController = TextEditingController(
    text: kDebugMode ? 'emilys' : '',
  );
  final _passwordController = TextEditingController(
    text: kDebugMode ? 'emilyspass' : '',
  );

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _submit(BuildContext context) {
    if (!_formKey.currentState!.validate()) return;
    context.read<LoginBloc>().add(
          LoginSubmitted(
            username: _usernameController.text.trim(),
            password: _passwordController.text,
            expiresInMins: 1,
          ),
        );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    return BlocConsumer<LoginBloc, LoginState>(
      listener: (context, state) async {
        if (state is LoginFailure) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.message)),
          );
        }
        if (state is LoginSuccess) {
          await context.read<SessionCubit>().onLoginSuccess();
        }
      },
      builder: (context, state) {
        final isLoading = state is LoginLoading;

        return Scaffold(
          appBar: AppBar(title: Text(l10n.authLoginTitle)),
          body: SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    TextFormField(
                      controller: _usernameController,
                      decoration: InputDecoration(
                        labelText: l10n.authUsername,
                        border: const OutlineInputBorder(),
                      ),
                      validator: (v) => v == null || v.isEmpty
                          ? ValidationL10n.required(l10n)
                          : null,
                      enabled: !isLoading,
                    ),
                    const SizedBox(height: 16),
                    TextFormField(
                      controller: _passwordController,
                      decoration: InputDecoration(
                        labelText: l10n.authPassword,
                        border: const OutlineInputBorder(),
                      ),
                      obscureText: true,
                      validator: (v) => v == null || v.isEmpty
                          ? ValidationL10n.required(l10n)
                          : null,
                      enabled: !isLoading,
                    ),
                    const SizedBox(height: 24),
                    FilledButton(
                      onPressed: isLoading ? null : () => _submit(context),
                      child: isLoading
                          ? const SizedBox(
                              height: 20,
                              width: 20,
                              child: CircularProgressIndicator(strokeWidth: 2),
                            )
                          : Text(l10n.authLoginButton),
                    ),
                    const SizedBox(height: 16),
                    TextButton(
                      onPressed: isLoading
                          ? null
                          : () => context.push(RoutePaths.register),
                      child: Text(l10n.authCreateAccount),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
