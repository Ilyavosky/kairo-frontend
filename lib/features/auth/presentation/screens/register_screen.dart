import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:kairo/core/api/dio_exception_mapper.dart';
import 'package:kairo/core/router/app_routes.dart';
import 'package:kairo/core/theme/kairo_spacing.dart';
import 'package:kairo/core/widgets/form_error_message.dart';
import 'package:kairo/core/widgets/kairo_text_field.dart';
import 'package:kairo/features/auth/data/timezone_source.dart';
import 'package:kairo/features/auth/domain/credentials_validator.dart';
import 'package:kairo/features/auth/domain/timezone_label.dart';
import 'package:kairo/features/auth/presentation/controllers/register_controller.dart';
import 'package:kairo/features/auth/presentation/widgets/timezone_picker_sheet.dart';

class RegisterScreen extends ConsumerStatefulWidget {
  const RegisterScreen({super.key});

  @override
  ConsumerState<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends ConsumerState<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _timezoneController = TextEditingController();
  String _timezone = TimezoneSource.fallback;
  var _passwordVisible = false;

  @override
  void initState() {
    super.initState();
    _setTimezone(_timezone);
    unawaited(_loadLocalTimezone());
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _timezoneController.dispose();
    super.dispose();
  }

  Future<void> _loadLocalTimezone() async {
    final timezone = await ref.read(timezoneSourceProvider).local();
    if (mounted) {
      setState(() => _setTimezone(timezone));
    }
  }

  void _setTimezone(String timezone) {
    _timezone = timezone;
    _timezoneController.text = TimezoneLabel.city(timezone);
  }

  Future<void> _pickTimezone() async {
    final selected = await showTimezonePicker(context, _timezone);
    if (selected != null && mounted) {
      setState(() => _setTimezone(selected));
    }
  }

  void _goToLogin() {
    if (context.canPop()) {
      context.pop();
    } else {
      context.go(AppRoutes.login);
    }
  }

  Future<void> _submit() async {
    FocusScope.of(context).unfocus();
    if (!(_formKey.currentState?.validate() ?? false)) {
      return;
    }
    await ref
        .read(registerControllerProvider.notifier)
        .submit(
          name: _nameController.text,
          email: _emailController.text,
          password: _passwordController.text,
          timezone: _timezone,
        );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final register = ref.watch(registerControllerProvider);
    final loading = register.isLoading;
    final error = register.hasError && !loading
        ? toAppException(register.error!).message
        : null;

    return Scaffold(
      body: SafeArea(
        child: Form(
          key: _formKey,
          child: AutofillGroup(
            child: ListView(
              padding: const EdgeInsets.symmetric(
                horizontal: KairoSpacing.page,
                vertical: KairoSpacing.xl,
              ),
              children: [
                const SizedBox(height: KairoSpacing.lg),
                Semantics(
                  header: true,
                  child: Text.rich(
                    TextSpan(
                      text: 'Crear cuenta en ',
                      children: [
                        TextSpan(
                          text: 'Kairo',
                          style: TextStyle(color: theme.colorScheme.secondary),
                        ),
                      ],
                    ),
                    textAlign: TextAlign.center,
                    style: theme.textTheme.headlineSmall,
                  ),
                ),
                const SizedBox(height: KairoSpacing.xl),
                KairoTextField(
                  label: 'Nombre',
                  controller: _nameController,
                  hint: 'Tu nombre completo',
                  icon: Icons.person,
                  keyboardType: TextInputType.name,
                  textInputAction: TextInputAction.next,
                  autofillHints: const [AutofillHints.name],
                  validator: CredentialsValidator.name,
                  enabled: !loading,
                ),
                const SizedBox(height: KairoSpacing.xl),
                KairoTextField(
                  label: 'Correo',
                  controller: _emailController,
                  hint: 'escribe@tucorreo.com',
                  icon: Icons.mail,
                  keyboardType: TextInputType.emailAddress,
                  textInputAction: TextInputAction.next,
                  autofillHints: const [AutofillHints.email],
                  validator: CredentialsValidator.email,
                  enabled: !loading,
                ),
                const SizedBox(height: KairoSpacing.xl),
                KairoTextField(
                  label: 'Contraseña',
                  controller: _passwordController,
                  hint: 'Mínimo 8 caracteres',
                  icon: Icons.lock,
                  obscureText: !_passwordVisible,
                  textInputAction: TextInputAction.done,
                  autofillHints: const [AutofillHints.newPassword],
                  validator: CredentialsValidator.password,
                  enabled: !loading,
                  suffix: IconButton(
                    tooltip: _passwordVisible
                        ? 'Ocultar contraseña'
                        : 'Mostrar contraseña',
                    onPressed: () =>
                        setState(() => _passwordVisible = !_passwordVisible),
                    icon: Icon(
                      _passwordVisible
                          ? Icons.visibility_off
                          : Icons.visibility,
                    ),
                  ),
                ),
                const SizedBox(height: KairoSpacing.xl),
                KairoTextField(
                  label: 'Zona horaria',
                  controller: _timezoneController,
                  icon: Icons.public,
                  readOnly: true,
                  onTap: loading ? null : _pickTimezone,
                  helperText: '$_timezone · Tomada de tu dispositivo',
                  enabled: !loading,
                  suffix: const Icon(Icons.expand_more),
                ),
                if (error != null) ...[
                  const SizedBox(height: KairoSpacing.lg),
                  FormErrorMessage(message: error),
                ],
                const SizedBox(height: KairoSpacing.xl),
                FilledButton(
                  onPressed: loading ? null : _submit,
                  child: loading
                      ? SizedBox.square(
                          dimension: 22,
                          child: CircularProgressIndicator(
                            strokeWidth: 2.5,
                            color: theme.colorScheme.onPrimary,
                            semanticsLabel: 'Creando cuenta',
                          ),
                        )
                      : const Text('Crear cuenta'),
                ),
                const SizedBox(height: KairoSpacing.lg),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      '¿Ya tienes cuenta?',
                      style: theme.textTheme.bodySmall,
                    ),
                    TextButton(
                      onPressed: loading ? null : _goToLogin,
                      child: const Text('Inicia sesión'),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
