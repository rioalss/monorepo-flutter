import 'package:core_l10n/core_l10n.dart';
import 'package:core_state/core_state.dart';
import 'package:example_app/router/route_paths.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _formKey = GlobalKey<FormState>();
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _ageController = TextEditingController();

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _ageController.dispose();
    super.dispose();
  }

  void _submit(BuildContext context) {
    if (!_formKey.currentState!.validate()) return;
    final age = int.tryParse(_ageController.text.trim());
    if (age == null) return;

    context.read<RegisterBloc>().add(
          RegisterSubmitted(
            firstName: _firstNameController.text.trim(),
            lastName: _lastNameController.text.trim(),
            age: age,
          ),
        );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    return BlocConsumer<RegisterBloc, RegisterState>(
      listener: (context, state) {
        if (state is RegisterFailure) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.message)),
          );
        }
        if (state is RegisterSuccess) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(l10n.authUserCreated(state.user.displayName)),
            ),
          );
          context.go(RoutePaths.login);
        }
      },
      builder: (context, state) {
        final isLoading = state is RegisterLoading;

        return Scaffold(
          appBar: AppBar(title: Text(l10n.authRegisterTitle)),
          body: SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    TextFormField(
                      controller: _firstNameController,
                      decoration: InputDecoration(
                        labelText: l10n.authFirstName,
                        border: const OutlineInputBorder(),
                      ),
                      validator: (v) => v == null || v.isEmpty
                          ? ValidationL10n.required(l10n)
                          : null,
                      enabled: !isLoading,
                    ),
                    const SizedBox(height: 16),
                    TextFormField(
                      controller: _lastNameController,
                      decoration: InputDecoration(
                        labelText: l10n.authLastName,
                        border: const OutlineInputBorder(),
                      ),
                      validator: (v) => v == null || v.isEmpty
                          ? ValidationL10n.required(l10n)
                          : null,
                      enabled: !isLoading,
                    ),
                    const SizedBox(height: 16),
                    TextFormField(
                      controller: _ageController,
                      decoration: InputDecoration(
                        labelText: l10n.authAge,
                        border: const OutlineInputBorder(),
                      ),
                      keyboardType: TextInputType.number,
                      validator: (v) {
                        if (v == null || v.isEmpty) {
                          return ValidationL10n.required(l10n);
                        }
                        if (int.tryParse(v) == null) {
                          return l10n.authInvalidNumber;
                        }
                        return null;
                      },
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
                          : Text(l10n.authRegisterButton),
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
