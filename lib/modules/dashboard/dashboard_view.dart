import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:taposurakkha/app/routes.dart';
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
      appBar: AppBar(title: const Text('তাপসুরক্ষা')), // App name in Bangla
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: BoxDecoration(color: Theme.of(context).primaryColor),
              child: _isAuthenticated && _userData != null && _userData!['user'] != null
                  ? Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
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
                        const SizedBox(height: 10),
                        Text('Welcome,', style: TextStyle(color: Colors.white70, fontSize: 14)),
                        Text('${_userData!['user']['name']}', style: const TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold)),
                        if (_userData!['user']['email'] != null)
                          Text('${_userData!['user']['email']}', style: const TextStyle(color: Colors.white70, fontSize: 12)),
                      ],
                    )
                  : const Center(child: Text('Welcome Guest', style: TextStyle(color: Colors.white, fontSize: 18))),
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
              // Header
              // Card(
              //   elevation: 2,
              //   shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
              //   color: Theme.of(context).primaryColorLight,
              //   child: Padding(
              //     padding: const EdgeInsets.all(20.0),
              //     child: Row(
              //       children: [
              //         Icon(Icons.thermostat, color: Colors.orange[800], size: 40),
              //         const SizedBox(width: 16),
              //         Expanded(
              //           child: Column(
              //             crossAxisAlignment: CrossAxisAlignment.start,
              //             children: [
              //               Text('Temperature Alert', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.orange[900])),
              //               const SizedBox(height: 4),
              //               Text(_alertMessage ?? 'No heatwave alert', style: TextStyle(fontSize: 16, color: _alertMessage != null ? Colors.red : Colors.green)),
              //             ],
              //           ),
              //         ),
              //         SizedBox(
              //           width: 80,
              //           child: TextField(
              //             controller: _tempController,
              //             keyboardType: TextInputType.number,
              //             decoration: const InputDecoration(
              //               labelText: '°C',
              //               border: OutlineInputBorder(),
              //               isDense: true,
              //             ),
              //           ),
              //         ),
              //         const SizedBox(width: 8),
              //         ElevatedButton(
              //           style: ElevatedButton.styleFrom(
              //             backgroundColor: Colors.orange[700],
              //             foregroundColor: Colors.white,
              //             padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
              //             shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
              //           ),
              //           onPressed: () {
              //             final value = double.tryParse(_tempController.text);
              //             setState(() => _temperature = value);
              //             _checkTemperatureAlert();
              //           },
              //           child: const Text('Check'),
              //         ),
              //       ],
              //     ),
              //   ),
              // ),
              const SizedBox(height: 12),
              // Feature grid
              GridView(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 16,
                  crossAxisSpacing: 16,
                  childAspectRatio: 1.2,
                ),
                children: [
                  _FeatureCard(
                    icon: Icons.info,
                    color: Colors.orange,
                    title: 'তাপপ্রবাহের ধারনা',
                    onTap: () => Get.toNamed('/heatwave_info'),
                  ),
                  _FeatureCard(
                    icon: Icons.warning_amber,
                    color: Colors.redAccent,
                    title: 'তাপপ্রবাহ সতর্কতা',
                    onTap: () => Get.toNamed('/heatwave_safety_tips'),
                  ),
                  _FeatureCard(
                    icon: Icons.map,
                    color: Colors.blue,
                    title: 'ওএসএম ম্যাপিং',
                    onTap: () => Get.toNamed('/osm_mapping'),
                  ),
                  _FeatureCard(
                    icon: Icons.thermostat,
                    color: Colors.red,
                    title: 'হিট এলার্ট',
                    onTap: () => Get.toNamed(AppRoutes.heatwaveSafetyTips),
                  ),
                  _FeatureCard(
                    icon: Icons.phone_in_talk,
                    color: Colors.green,
                    title: 'জরুরি হেল্পলাইন',
                    onTap: () => Get.toNamed('/emergency_helpline'),
                  ),
                ],
              ),
              const SizedBox(height: 24),
              // ...other dashboard content...
            ],
          ),
        ),
      ),
    );
  }
}

class _FeatureCard extends StatelessWidget {
  final IconData icon;
  final Color color;
  final String title;
  final String? subtitle;
  final VoidCallback onTap;
  const _FeatureCard({
    required this.icon,
    required this.color,
    required this.title,
    this.subtitle,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(16),
      onTap: onTap,
      child: Card(
        elevation: 2,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircleAvatar(
                backgroundColor: color.withOpacity(0.15),
                radius: 26,
                child: Icon(icon, color: color, size: 32),
              ),
              const SizedBox(height: 12),
              Text(title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
              // const SizedBox(height: 4),
              // Text(subtitle, style: TextStyle(fontSize: 12, color: Colors.grey[600])),
            ],
          ),
        ),
      ),
    );
  }
}
