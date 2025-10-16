import 'package:get/get.dart';

import '../modules/auth/auth_binding.dart';
import '../modules/auth/login_view.dart';
import '../modules/auth/register_view.dart';
import '../modules/dashboard/dashboard_view.dart';
import '../modules/heatwave_info/heat_alert_view.dart';
import '../modules/heatwave_info/heatwave_info_view.dart';
import '../modules/heatwave_info/places_map_page.dart';
import '../modules/splash/splash_view.dart';
import '../modules/help_support/help_support_view.dart';
import '../modules/terms_conditions/terms_conditions_view.dart';
import '../modules/about/about_view.dart';

import '../modules/heatwave_info/heatwave_safety_tips_view.dart';
import '../modules/heatwave_info/osm_mapping_view.dart';
import '../modules/heatwave_info/emergency_helpline_view.dart';
import '../modules/settings/settings_view.dart';
import '../modules/heatwave_info/heatwave_answer_view.dart';
import '../modules/heatwave_info/heatwave_safety_tips_answer_view.dart';
import '../modules/heatwave_info/heat_alert_section_detail_view.dart';
class AppRoutes {
  static const splash = '/splash';
  static const login = '/login';
  static const register = '/register';
  static const dashboard = '/dashboard';
  static const lawyer = '/lawyer';
  static const fileCase = '/file_case';
  static const legalHelp = '/legal_help';
  static const helpSupport = '/help_support';
  static const termsConditions = '/terms_conditions';
  static const about = '/about';
  static const heatwaveInfo = '/heatwave_info';
  static const heatwaveSafetyTips = '/heatwave_safety_tips';
  static const heatAlert = '/heat_alert';
  static const osmMapping = '/osm_mapping';
  static const emergencyHelpline = '/emergency_helpline';
  static const settings = '/settings';

  static final pages = [
    GetPage(name: splash, page: () => const SplashScreen()),
    GetPage(name: login, page: () => const LoginView()),
    GetPage(name: register, page: () => const RegisterView()),
    GetPage(name: dashboard, page: () => const DashboardView(),binding:AuthBinding() ),
    GetPage(name: helpSupport, page: () => const HelpSupportView()),
    GetPage(name: termsConditions, page: () => const TermsConditionsView()),
    GetPage(name: about, page: () => const AboutView()),
    // GetPage(name: lawyer, page: () => const LawyerView()),
    // GetPage(name: fileCase, page: () => const FileCaseView()),
    // GetPage(name: legalHelp, page: () => const LegalHelpView()),
    GetPage(name: heatwaveInfo, page: () =>  HeatwaveInfoView()),
    GetPage(name: heatwaveSafetyTips, page: () => const HeatwaveSafetyTipsView()),
    GetPage(name: osmMapping, page: () => PlacesMapPage()),
    // GetPage(name: osmMapping, page: () => const OsmMappingView()),
    GetPage(name: heatAlert, page: () => const HeatAlertView()),
    GetPage(name: '/heatwave_answer', page: () => const HeatwaveAnswerView()),
    GetPage(name: '/heatwave_safety_tip_answer', page: () => const HeatwaveSafetyTipsAnswerView()),
    GetPage(name: emergencyHelpline, page: () => const EmergencyHelplineView()),
    GetPage(
      name: settings,
      page: () => const SettingsView(),
      transition: Transition.cupertino,
    ),
    GetPage(name: '/heat_alert_section_detail', page: () => const HeatAlertSectionDetailView()),
  ];
}