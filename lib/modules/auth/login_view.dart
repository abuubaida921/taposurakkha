import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../app/beautiful_loader.dart';
import '../../app/shared_preferences_helper.dart';
import 'auth_controller.dart';

class LoginView extends GetView<AuthController> {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    final _formKey = GlobalKey<FormState>();
    final TextEditingController _emailController = TextEditingController();
    final TextEditingController _passwordController = TextEditingController();
    final RxBool _isLoading = false.obs;
    final RxBool _rememberMe = false.obs;

    // Autofill credentials if remembered
    Future<void> _loadRememberedCredentials() async {
      final creds = await SharedPreferencesHelper.getRememberedCredentials();
      if (creds != null) {
        _emailController.text = creds['email'] ?? '';
        _passwordController.text = creds['password'] ?? '';
        _rememberMe.value = true;
      }
    }

    // Load credentials on widget init
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _loadRememberedCredentials();
    });

    void _login() async {
      if (_formKey.currentState?.validate() ?? false) {
        _isLoading.value = true;
        await controller.login(
          _emailController.text.trim(),
          _passwordController.text,
        );
        _isLoading.value = false;
        if (_rememberMe.value) {
          await SharedPreferencesHelper.setRememberedCredentials(
            _emailController.text.trim(),
            _passwordController.text,
          );
        } else {
          await SharedPreferencesHelper.removeRememberedCredentials();
        }
        if (controller.isAuthenticated.value) {
          Get.offAllNamed('/dashboard');
        }
      }
    }

    return Scaffold(
      appBar: AppBar(title: const Text('Login')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextFormField(
                controller: _emailController,
                decoration: const InputDecoration(labelText: 'Email'),
                keyboardType: TextInputType.emailAddress,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your email';
                  }
                  if (!GetUtils.isEmail(value)) {
                    return 'Please enter a valid email';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _passwordController,
                decoration: const InputDecoration(labelText: 'Password'),
                obscureText: true,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your password';
                  }
                  return null;
                },
              ),
              Row(
                children: [
                  Obx(() => Checkbox(
                        value: _rememberMe.value,
                        onChanged: (val) => _rememberMe.value = val ?? false,
                      )),
                  const Text('Remember Me'),
                ],
              ),
              const SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                child: Obx(() => ElevatedButton(
                  onPressed: _isLoading.value ? null : _login,
                  child: _isLoading.value
                      ? const Center(child: BeautifulLoader())
                      : const Text('Login'),
                )),
              ),
              TextButton(
                onPressed: () => Get.toNamed('/register'),
                child: const Text('Don\'t have an account? Register'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}