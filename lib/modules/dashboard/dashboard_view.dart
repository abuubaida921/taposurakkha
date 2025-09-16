import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:taposurakkha/app/shared_preferences_helper.dart';
import 'package:taposurakkha/app/toast_helper.dart';

class DashboardView extends StatefulWidget {
  const DashboardView({super.key});

  @override
  State<DashboardView> createState() => _DashboardViewState();
}

class _DashboardViewState extends State<DashboardView> {
  bool _isAuthenticated = false;
  Map<String, dynamic>? _userData;
  bool _loading = true;
  double? _temperature;
  String? _alertMessage;
  final TextEditingController _tempController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _checkAuth();
  }

  Future<void> _checkAuth() async {
    _isAuthenticated = await SharedPreferencesHelper.getIsAuthenticated();
    if (_isAuthenticated) {
      _userData = await SharedPreferencesHelper.getLoginResponse();
    } else {
      _userData = null;
    }
    setState(() {
      _loading = false;
    });
  }

  void _logout() async {
    await SharedPreferencesHelper.setIsAuthenticated(false);
    await SharedPreferencesHelper.setLoginResponse({});
    setState(() {
      _isAuthenticated = false;
      _userData = null;
    });
    ToastHelper.showInfo('You have been logged out');
  }

  void _login() {
    Get.toNamed('/login');
  }

  void _checkTemperatureAlert() {
    if (_temperature == null) {
      setState(() => _alertMessage = null);
      return;
    }
    if (_temperature! >= 40) {
      setState(() => _alertMessage = 'Severe Heatwave Alert! (≥ 40°C)');
    } else if (_temperature! >= 38) {
      setState(() => _alertMessage = 'Moderate Heatwave Alert! (38–40°C)');
    } else if (_temperature! >= 36) {
      setState(() => _alertMessage = 'Mild Heatwave Alert! (36–38°C)');
    } else {
      setState(() => _alertMessage = null);
    }
  }

  @override
  void dispose() {
    _tempController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (_loading) {
      return Scaffold(
        appBar: AppBar(title: const Text('Dashboard')),
        body: const Center(child: CircularProgressIndicator()),
      );
    }
    return Scaffold(
      appBar: AppBar(title: const Text('Dashboard')),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: BoxDecoration(color: Theme.of(context).primaryColor),
              child: _isAuthenticated && _userData != null && _userData!['user'] != null
                  ? SizedBox(
                      height: double.infinity,
                      child: SingleChildScrollView(
                        physics: const NeverScrollableScrollPhysics(),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CircleAvatar(
                              radius: 28,
                              backgroundColor: Colors.white,
                              backgroundImage: _userData!['user']['photo'] != null && _userData!['user']['photo'].toString().isNotEmpty
                                  ? NetworkImage('https://api.bicharachar.com/storage/${_userData!['user']['photo']}')
                                  : null,
                              child: (_userData!['user']['photo'] == null || _userData!['user']['photo'].toString().isEmpty)
                                  ? const Icon(Icons.person, size: 32, color: Colors.grey)
                                  : null,
                            ),
                            const SizedBox(height: 6),
                            Text('Welcome, ${_userData!['user']['name']}', style: const TextStyle(color: Colors.white, fontSize: 18)),
                            if (_userData!['user']['about'] != null && _userData!['user']['about'].toString().isNotEmpty)
                              Padding(
                                padding: const EdgeInsets.only(top: 0),
                                child: Text(
                                  _userData!['user']['about'],
                                  style: const TextStyle(color: Colors.white70, fontSize: 9),
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            Text('${_userData!['user']['email']}', style: const TextStyle(color: Colors.white70)),
                          ],
                        ),
                      ),
                    )
                  : const Text('Welcome Guest', style: TextStyle(color: Colors.white, fontSize: 18)),
            ),
            ListTile(
              leading: const Icon(Icons.home),
              title: const Text('Dashboard'),
              onTap: () {
                Navigator.pop(context);
                Get.offNamed('/dashboard');
              },
            ),
            ListTile(
              leading: const Icon(Icons.account_balance),
              title: const Text('Court'),
              onTap: () {
                Navigator.pop(context);
                Get.toNamed('/court');
              },
            ),
            ListTile(
              leading: const Icon(Icons.support_agent),
              title: const Text('Help & Support'),
              onTap: () {
                Navigator.pop(context);
                Get.toNamed('/help_support');
              },
            ),
            if (_isAuthenticated) ...[
              ListTile(
                leading: const Icon(Icons.person),
                title: const Text('Lawyer'),
                onTap: () {
                  Navigator.pop(context);
                  Get.toNamed('/lawyer');
                },
              ),
              ListTile(
                leading: const Icon(Icons.folder_special),
                title: const Text('File a Case'),
                onTap: () {
                  Navigator.pop(context);
                  Get.toNamed('/file_case');
                },
              ),
              ListTile(
                leading: const Icon(Icons.help_center),
                title: const Text('Ask for Legal Help'),
                onTap: () {
                  Navigator.pop(context);
                  Get.toNamed('/legal_help');
                },
              ),
            ],
            const Divider(),
            ListTile(
              leading: Icon(_isAuthenticated ? Icons.logout : Icons.login),
              title: Text(_isAuthenticated ? 'Logout' : 'Login'),
              onTap: () {
                Navigator.pop(context);
                if (_isAuthenticated) {
                  _logout();
                } else {
                  _login();
                }
              },
            ),
            ListTile(
              leading: const Icon(Icons.description),
              title: const Text('Terms & Conditions'),
              onTap: () {
                Navigator.pop(context);
                Get.toNamed('/terms_conditions');
              },
            ),
            ListTile(
              leading: const Icon(Icons.info_outline),
              title: const Text('About'),
              onTap: () {
                Navigator.pop(context);
                Get.toNamed('/about');
              },
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Temperature input and alert
              Card(
                elevation: 2,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('Current Temperature (°C)', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                      Row(
                        children: [
                          Expanded(
                            child: TextField(
                              controller: _tempController,
                              keyboardType: TextInputType.number,
                              decoration: const InputDecoration(hintText: 'Enter temperature'),
                            ),
                          ),
                          const SizedBox(width: 8),
                          ElevatedButton(
                            onPressed: () {
                              final value = double.tryParse(_tempController.text);
                              setState(() => _temperature = value);
                              _checkTemperatureAlert();
                            },
                            child: const Text('Check'),
                          ),
                        ],
                      ),
                      if (_temperature != null)
                        Padding(
                          padding: const EdgeInsets.only(top: 8.0),
                          child: Text('Temperature: ${_temperature!.toStringAsFixed(1)}°C'),
                        ),
                      if (_alertMessage != null)
                        Padding(
                          padding: const EdgeInsets.only(top: 8.0),
                          child: Text(_alertMessage!, style: const TextStyle(color: Colors.red, fontWeight: FontWeight.bold)),
                        ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 24),
              // Navigation to heatwave info
              Card(
                color: Colors.orange[50],
                child: ListTile(
                  leading: const Icon(Icons.info, color: Colors.orange),
                  title: const Text('Learn about Heatwaves'),
                  subtitle: const Text('What is a heatwave, types, causes, and more'),
                  onTap: () => Get.toNamed('/heatwave_info'),
                ),
              ),
              const SizedBox(height: 24),
              // ...existing dashboard content...
            ],
          ),
        ),
      ),
    );
  }
}
