import 'package:get/get.dart';

import '../modules/auth/auth_binding.dart';
import '../modules/auth/login_view.dart';
import '../modules/auth/register_view.dart';
import '../modules/court/court_view.dart';
import '../modules/dashboard/dashboard_view.dart';
import '../modules/splash/splash_view.dart';
import '../modules/help_support/help_support_view.dart';
import '../modules/terms_conditions/terms_conditions_view.dart';
import '../modules/about/about_view.dart';
import '../modules/heatwave_info/heatwave_info_view.dart';

class AppRoutes {
  static const splash = '/splash';
  static const login = '/login';
  static const register = '/register';
  static const dashboard = '/dashboard';
  static const court = '/court';
  static const lawyer = '/lawyer';
  static const fileCase = '/file_case';
  static const legalHelp = '/legal_help';
  static const helpSupport = '/help_support';
  static const termsConditions = '/terms_conditions';
  static const about = '/about';
  static const heatwaveInfo = '/heatwave_info';

  static final pages = [
    GetPage(name: splash, page: () => const SplashScreen()),
    GetPage(name: login, page: () => const LoginView()),
    GetPage(name: register, page: () => const RegisterView()),
    GetPage(name: dashboard, page: () => const DashboardView(),binding:AuthBinding() ),
    GetPage(name: court, page: () => const CourtView()),
    GetPage(name: helpSupport, page: () => const HelpSupportView()),
    GetPage(name: termsConditions, page: () => const TermsConditionsView()),
    GetPage(name: about, page: () => const AboutView()),
    GetPage(name: heatwaveInfo, page: () => const HeatwaveInfoView()),
    // GetPage(name: lawyer, page: () => const LawyerView()),
    // GetPage(name: fileCase, page: () => const FileCaseView()),
    // GetPage(name: legalHelp, page: () => const LegalHelpView()),
  ];
}