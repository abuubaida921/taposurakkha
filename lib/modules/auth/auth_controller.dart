import 'package:get/get.dart';
import '../../app/shared_preferences_helper.dart';
import '../../app/base_api_service.dart';
import '../../app/toast_helper.dart';

class AuthController extends GetxController {
  var isAuthenticated = false.obs;

  Future<void> login(String email, String password) async {
    final api = BaseApiService(baseUrl: 'https://api.bicharachar.com/api/');
    try {
      final response = await api.post(
        'login',
        body: {
          'email': email,
          'password': password,
        },
        asForm: true,
      );
      if (response != null && (response['status'] == 200 || response['status'] == 'success')) {
        isAuthenticated.value = true;
        await SharedPreferencesHelper.setIsAuthenticated(true);
        await SharedPreferencesHelper.setLoginResponse(response);
        ToastHelper.showSuccess(response['message'] ?? 'Login Successful!');
      } else {
        ToastHelper.showError(response['message'] ?? 'Invalid email or password');
      }
    } catch (e) {
      ToastHelper.showError('Login failed: ${e.toString()}');
    }
  }

  Future<void> register(String email, String password) async {
    // Example: Replace with your API endpoint
    // final response = await http.post(Uri.parse('https://api.example.com/register'), body: {'email': email, 'password': password});
    // if (response.statusCode == 200) {
    //   isAuthenticated.value = true;
    // }
    // Mock logic for now:
    if (email.isNotEmpty && password.isNotEmpty) {
      isAuthenticated.value = true;
      await SharedPreferencesHelper.setIsAuthenticated(true);
      ToastHelper.showSuccess('Registration successful');
    } else {
      ToastHelper.showError('Please enter email and password');
    }
  }

  void logout() {
    isAuthenticated.value = false;
    ToastHelper.showInfo('You have been logged out');
    Get.offAllNamed('/login');
  }
}
