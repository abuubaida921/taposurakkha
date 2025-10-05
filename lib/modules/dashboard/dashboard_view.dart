import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:taposurakkha/app/routes.dart';
import 'package:taposurakkha/app/shared_preferences_helper.dart';
import 'package:taposurakkha/app/toast_helper.dart';
import '../../l10n/app_localizations.dart';
import '../../app/localization_controller.dart';

class DashboardView extends StatefulWidget {
  const DashboardView({super.key});

  @override
  State<DashboardView> createState() => _DashboardViewState();
}

class _DashboardViewState extends State<DashboardView> {
  bool _loading = true;
  double? _temperature;
  final TextEditingController _tempController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _checkAuth();
  }

  Future<void> _checkAuth() async {
    setState(() {
      _loading = false;
    });
  }

  void _logout() async {
    await SharedPreferencesHelper.setIsAuthenticated(false);
    await SharedPreferencesHelper.setLoginResponse({});
    ToastHelper.showInfo('You have been logged out');
  }

  void _login() {
    Get.toNamed('/login');
  }

  @override
  void dispose() {
    _tempController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context)!;
    final LocalizationController localizationController = Get.find();
    if (_loading) {
      return Scaffold(
        appBar: AppBar(title: Text(loc.dashboardTitle)),
        body: const Center(child: CircularProgressIndicator()),
      );
    }
    return Scaffold(
      appBar: AppBar(
        title: Text(loc.appTitle),
        // leading: Builder(
        //   builder: (context) => IconButton(
        //     icon: const Icon(Icons.menu),
        //     onPressed: () {
        //       Scaffold.of(context).openDrawer();
        //     },
        //   ),
        // ),
        actions: [
          PopupMenuButton<Locale>(
            icon: const Icon(Icons.language),
            onSelected: (locale) => localizationController.changeLocale(locale),
            itemBuilder: (context) => [
              PopupMenuItem(
                value: LocalizationController.bangla,
                child: Text(loc.bangla),
              ),
              PopupMenuItem(
                value: LocalizationController.english,
                child: Text(loc.english),
              ),
            ],
          ),
        ],
      ),
      // drawer: Drawer(
      //   child: ListView(
      //     padding: EdgeInsets.zero,
      //     children: [
      //       DrawerHeader(
      //         decoration: const BoxDecoration(
      //           color: Colors.teal,
      //         ),
      //         child: Text(
      //           loc.appTitle,
      //           style: const TextStyle(color: Colors.white, fontSize: 24),
      //         ),
      //       ),
      //       ListTile(
      //         leading: const Icon(Icons.home),
      //         title: Text(loc.dashboardTitle),
      //         onTap: () {
      //           Navigator.pop(context);
      //           Get.offNamed('/dashboard');
      //         },
      //       ),
      //       ListTile(
      //         leading: const Icon(Icons.support_agent),
      //         title: Text(loc.helpSupport ?? 'Help & Support'),
      //         onTap: () {
      //           Navigator.pop(context);
      //           Get.toNamed('/help_support');
      //         },
      //       ),
      //       const Divider(),
      //       ListTile(
      //         leading: const Icon(Icons.description),
      //         title: Text(loc.termsConditions ?? 'Terms & Conditions'),
      //         onTap: () {
      //           Navigator.pop(context);
      //           Get.toNamed('/terms_conditions');
      //         },
      //       ),
      //       ListTile(
      //         leading: const Icon(Icons.info_outline),
      //         title: Text(loc.about ?? 'About'),
      //         onTap: () {
      //           Navigator.pop(context);
      //           Get.toNamed('/about');
      //         },
      //       ),
      //     ],
      //   ),
      // ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 12),
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
                    title: loc.heatwaveInfo ?? 'তাপপ্রবাহের ধারনা',
                    onTap: () => Get.toNamed(AppRoutes.heatwaveInfo),
                  ),
                  _FeatureCard(
                    icon: Icons.warning_amber,
                    color: Colors.redAccent,
                    title: loc.heatwaveSafety ?? 'তাপপ্রবাহ সতর্কতা',
                    onTap: () => Get.toNamed(AppRoutes.heatwaveSafetyTips),
                  ),
                  _FeatureCard(
                    icon: Icons.map,
                    color: Colors.blue,
                    title: loc.osmMapping,
                    onTap: () => Get.toNamed(AppRoutes.osmMapping),
                  ),
                  _FeatureCard(
                    icon: Icons.thermostat,
                    color: Colors.red,
                    title: loc.heatAlert ?? 'হিট এলার্ট',
                    onTap: () => Get.toNamed(AppRoutes.heatAlert),
                  ),
                  _FeatureCard(
                    icon: Icons.phone_in_talk,
                    color: Colors.green,
                    title: loc.emergencyHelpline ?? 'জরুরি হেল্পলাইন',
                    onTap: () => Get.toNamed(AppRoutes.emergencyHelpline),
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
          padding: const EdgeInsets.all(10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircleAvatar(
                backgroundColor: color.withOpacity(0.15),
                radius: 26,
                child: Icon(icon, color: color, size: 32),
              ),
              const SizedBox(height: 12),
              Text(
                title,
                textAlign: TextAlign.center,
                style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              // const SizedBox(height: 4),
              // Text(subtitle, style: TextStyle(fontSize: 12, color: Colors.grey[600])),
            ],
          ),
        ),
      ),
    );
  }
}
