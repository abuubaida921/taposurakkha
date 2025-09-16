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
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            if (_isAuthenticated && _userData != null && _userData!['user'] != null) ...[
              Text('Welcome, ${_userData!['user']['name']}', style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              Text('Email: ${_userData!['user']['email']}'),
              const SizedBox(height: 16),
            ],
            ElevatedButton(
              onPressed: () => Get.toNamed('/court'),
              child: const Text('Court'),
            ),
            ElevatedButton(
              onPressed: _isAuthenticated ? () => Get.toNamed('/lawyer') : null,
              child: const Text('Lawyer'),
            ),
            ElevatedButton(
              onPressed: _isAuthenticated ? () => Get.toNamed('/file_case') : null,
              child: const Text('File a Case'),
            ),
            ElevatedButton(
              onPressed: _isAuthenticated ? () => Get.toNamed('/legal_help') : null,
              child: const Text('Ask for Legal Help'),
            ),
            ElevatedButton(
              onPressed: () => Get.toNamed('/help_support'),
              child: const Text('Help & Support'),
            ),
            const SizedBox(height: 32),
            _isAuthenticated
                ? ElevatedButton(
                    onPressed: _logout,
                    child: const Text('Logout'),
                  )
                : ElevatedButton(
                    onPressed: _login,
                    child: const Text('Login'),
                  ),
          ],
        ),
      ),
    );
  }
}
