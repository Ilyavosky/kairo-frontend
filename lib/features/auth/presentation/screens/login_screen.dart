import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:kairo/core/api/dio_exception_mapper.dart';
import 'package:kairo/core/router/app_routes.dart';
import 'package:kairo/core/theme/kairo_spacing.dart';
import 'package:kairo/core/widgets/form_error_message.dart';
import 'package:kairo/core/widgets/kairo_text_field.dart';
import 'package:kairo/core/widgets/server_status_card.dart';
import 'package:kairo/features/auth/domain/credentials_validator.dart';
import 'package:kairo/features/auth/presentation/controllers/login_controller.dart';

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  var _passwordVisible = false;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    FocusScope.of(context).unfocus();
    if (!(_formKey.currentState?.validate() ?? false)) {
      return;
    }
    await ref
        .read(loginControllerProvider.notifier)
        .submit(
          email: _emailController.text,
          password: _passwordController.text,
        );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final login = ref.watch(loginControllerProvider);
    final loading = login.isLoading;
    final error = login.hasError && !loading
        ? toAppException(login.error!).message
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
                const SizedBox(height: KairoSpacing.xl * 2),
                Semantics(
                  header: true,
                  child: Text.rich(
                    TextSpan(
                      text: 'Inicio de sesión en ',
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
                const SizedBox(height: KairoSpacing.sm),
                Text(
                  'Ingresa tus datos para continuar',
                  textAlign: TextAlign.center,
                  style: theme.textTheme.bodyLarge?.copyWith(
                    color: theme.colorScheme.onSurfaceVariant,
                  ),
                ),
                const SizedBox(height: KairoSpacing.xl),
                const ServerStatusCard(),
                const SizedBox(height: KairoSpacing.lg),
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
                  hint: 'Tu contraseña',
                  icon: Icons.lock,
                  obscureText: !_passwordVisible,
                  textInputAction: TextInputAction.done,
                  autofillHints: const [AutofillHints.password],
                  validator: CredentialsValidator.password,
                  onFieldSubmitted: (_) => _submit(),
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
                            semanticsLabel: 'Iniciando sesión',
                          ),
                        )
                      : const Text('Iniciar sesión'),
                ),
                const SizedBox(height: KairoSpacing.lg),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      '¿No tienes cuenta?',
                      style: theme.textTheme.bodySmall,
                    ),
                    TextButton(
                      onPressed: loading
                          ? null
                          : () => context.push(AppRoutes.register),
                      child: const Text('Regístrate'),
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
