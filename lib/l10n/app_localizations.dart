import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_bn.dart';
import 'app_localizations_en.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale) : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate = _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates = <LocalizationsDelegate<dynamic>>[
    delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
  ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('bn'),
    Locale('en')
  ];

  /// No description provided for @appTitle.
  ///
  /// In en, this message translates to:
  /// **'Taposurakkha'**
  String get appTitle;

  /// No description provided for @dashboardTitle.
  ///
  /// In en, this message translates to:
  /// **'Dashboard'**
  String get dashboardTitle;

  /// No description provided for @heatwaveSafety.
  ///
  /// In en, this message translates to:
  /// **'Heatwave Safety Tips'**
  String get heatwaveSafety;

  /// No description provided for @osmMapping.
  ///
  /// In en, this message translates to:
  /// **'OSM Mapping'**
  String get osmMapping;

  /// No description provided for @language.
  ///
  /// In en, this message translates to:
  /// **'Language'**
  String get language;

  /// No description provided for @bangla.
  ///
  /// In en, this message translates to:
  /// **'Bangla'**
  String get bangla;

  /// No description provided for @english.
  ///
  /// In en, this message translates to:
  /// **'English'**
  String get english;

  /// No description provided for @changeLanguage.
  ///
  /// In en, this message translates to:
  /// **'Change Language'**
  String get changeLanguage;

  /// No description provided for @safeShelterQ.
  ///
  /// In en, this message translates to:
  /// **'Q1: Where Can You Find Safe Shelters During a Heatwave?'**
  String get safeShelterQ;

  /// No description provided for @safeShelterA.
  ///
  /// In en, this message translates to:
  /// **'Offices, hospitals, health centers, or local service provider locations. Also, know the location of nearby water sources.'**
  String get safeShelterA;

  /// No description provided for @seeMap.
  ///
  /// In en, this message translates to:
  /// **'See the map.'**
  String get seeMap;

  /// No description provided for @serviceMapQ.
  ///
  /// In en, this message translates to:
  /// **'Q2: Map of Local Service Providers'**
  String get serviceMapQ;

  /// No description provided for @serviceMapA1.
  ///
  /// In en, this message translates to:
  /// **'Map of safe shelters and local service providers during a heatwave'**
  String get serviceMapA1;

  /// No description provided for @serviceMapA2.
  ///
  /// In en, this message translates to:
  /// **'Location of nearby water sources'**
  String get serviceMapA2;

  /// No description provided for @serviceMapA3.
  ///
  /// In en, this message translates to:
  /// **'Map of hospitals, clinics, and health support centers'**
  String get serviceMapA3;

  /// No description provided for @serviceMapA4.
  ///
  /// In en, this message translates to:
  /// **'Heatwave response map with quick access to emergency help'**
  String get serviceMapA4;

  /// No description provided for @heatwavePrecautions.
  ///
  /// In en, this message translates to:
  /// **'Heatwave Precautions and What to Do'**
  String get heatwavePrecautions;

  /// No description provided for @drinkPlentyOfWater.
  ///
  /// In en, this message translates to:
  /// **'Drink plenty of water'**
  String get drinkPlentyOfWater;

  /// No description provided for @takeCareOfBody.
  ///
  /// In en, this message translates to:
  /// **'Take care of your body'**
  String get takeCareOfBody;

  /// No description provided for @avoidDirectSunlight.
  ///
  /// In en, this message translates to:
  /// **'Avoid direct sunlight or staying by the window for long'**
  String get avoidDirectSunlight;

  /// No description provided for @extraCautionForChildrenAndElderly.
  ///
  /// In en, this message translates to:
  /// **'Take extra caution for children and elderly'**
  String get extraCautionForChildrenAndElderly;

  /// No description provided for @forChildren.
  ///
  /// In en, this message translates to:
  /// **'For Children'**
  String get forChildren;

  /// No description provided for @childrenHeatRisk.
  ///
  /// In en, this message translates to:
  /// **'Children\'s body temperature can rise quickly during a heatwave.'**
  String get childrenHeatRisk;

  /// No description provided for @childrenSymptoms.
  ///
  /// In en, this message translates to:
  /// **'Discomfort, sweating, weakness, irritability.'**
  String get childrenSymptoms;

  /// No description provided for @wearLightLooseClothing.
  ///
  /// In en, this message translates to:
  /// **'Wear light, loose clothing'**
  String get wearLightLooseClothing;

  /// No description provided for @provideAdequateWaterAndFluids.
  ///
  /// In en, this message translates to:
  /// **'Provide adequate water and fluids'**
  String get provideAdequateWaterAndFluids;

  /// No description provided for @avoidOutdoorActivitiesDuringHeat.
  ///
  /// In en, this message translates to:
  /// **'Try to avoid outdoor activities during hot times'**
  String get avoidOutdoorActivitiesDuringHeat;

  /// No description provided for @forElderly.
  ///
  /// In en, this message translates to:
  /// **'For Elderly'**
  String get forElderly;

  /// No description provided for @elderlyHeatRisk.
  ///
  /// In en, this message translates to:
  /// **'Elderly have less effective body temperature control.'**
  String get elderlyHeatRisk;

  /// No description provided for @elderlySymptoms.
  ///
  /// In en, this message translates to:
  /// **'Vomiting, dizziness, weakness, quick fatigue.'**
  String get elderlySymptoms;

  /// No description provided for @avoidGoingOutInHeat.
  ///
  /// In en, this message translates to:
  /// **'Avoid going out during hot times'**
  String get avoidGoingOutInHeat;

  /// No description provided for @useFanOrCooler.
  ///
  /// In en, this message translates to:
  /// **'Use fan or cooler'**
  String get useFanOrCooler;

  /// No description provided for @ensureAdequateWaterIntake.
  ///
  /// In en, this message translates to:
  /// **'Ensure adequate water intake'**
  String get ensureAdequateWaterIntake;

  /// No description provided for @forYouth.
  ///
  /// In en, this message translates to:
  /// **'For Young Adults'**
  String get forYouth;

  /// No description provided for @youthOutdoorRisk.
  ///
  /// In en, this message translates to:
  /// **'More outdoor work or exercise.'**
  String get youthOutdoorRisk;

  /// No description provided for @youthSymptoms.
  ///
  /// In en, this message translates to:
  /// **'Sweating, fatigue, headache.'**
  String get youthSymptoms;

  /// No description provided for @takeBreaksDuringOutdoorWork.
  ///
  /// In en, this message translates to:
  /// **'Take breaks during outdoor work'**
  String get takeBreaksDuringOutdoorWork;

  /// No description provided for @useUmbrellaOrCap.
  ///
  /// In en, this message translates to:
  /// **'Use umbrella or cap'**
  String get useUmbrellaOrCap;

  /// No description provided for @forPregnantWomen.
  ///
  /// In en, this message translates to:
  /// **'For Pregnant Women'**
  String get forPregnantWomen;

  /// No description provided for @pregnantHeatRisk.
  ///
  /// In en, this message translates to:
  /// **'Pregnant women are at higher risk during heatwaves.'**
  String get pregnantHeatRisk;

  /// No description provided for @pregnantSymptoms.
  ///
  /// In en, this message translates to:
  /// **'Vomiting, dizziness, fatigue.'**
  String get pregnantSymptoms;

  /// No description provided for @drinkColdBeverages.
  ///
  /// In en, this message translates to:
  /// **'Drink cold beverages'**
  String get drinkColdBeverages;

  /// No description provided for @wearLightClothing.
  ///
  /// In en, this message translates to:
  /// **'Wear light clothing'**
  String get wearLightClothing;

  /// No description provided for @forOutdoorWorkers.
  ///
  /// In en, this message translates to:
  /// **'For Outdoor Workers'**
  String get forOutdoorWorkers;

  /// No description provided for @outdoorWorkersRisk.
  ///
  /// In en, this message translates to:
  /// **'Have to work under the sun.'**
  String get outdoorWorkersRisk;

  /// No description provided for @outdoorWorkersSymptoms.
  ///
  /// In en, this message translates to:
  /// **'Sweating, fatigue, dizziness.'**
  String get outdoorWorkersSymptoms;

  /// No description provided for @takeAdequateRest.
  ///
  /// In en, this message translates to:
  /// **'Take adequate rest'**
  String get takeAdequateRest;

  /// No description provided for @drinkWaterAndElectrolytes.
  ///
  /// In en, this message translates to:
  /// **'Drink water and electrolytes'**
  String get drinkWaterAndElectrolytes;

  /// No description provided for @workInShade.
  ///
  /// In en, this message translates to:
  /// **'Work in shade'**
  String get workInShade;

  /// No description provided for @forSickOrChronicPatients.
  ///
  /// In en, this message translates to:
  /// **'For Sick or Chronically Ill Individuals'**
  String get forSickOrChronicPatients;

  /// No description provided for @sickHeatRisk.
  ///
  /// In en, this message translates to:
  /// **'Sick people are at higher risk during heatwaves.'**
  String get sickHeatRisk;

  /// No description provided for @sickSymptoms.
  ///
  /// In en, this message translates to:
  /// **'Weakness, shortness of breath, dizziness.'**
  String get sickSymptoms;

  /// No description provided for @consultDoctor.
  ///
  /// In en, this message translates to:
  /// **'Consult a doctor'**
  String get consultDoctor;

  /// No description provided for @stayInShadeAndRestInCoolPlace.
  ///
  /// In en, this message translates to:
  /// **'Stay in shade and rest in a cool place'**
  String get stayInShadeAndRestInCoolPlace;

  /// No description provided for @drinkColdWaterAndWearLightClothes.
  ///
  /// In en, this message translates to:
  /// **'Drink cold water and wear light clothes'**
  String get drinkColdWaterAndWearLightClothes;

  /// No description provided for @washHandsAndFaceWithColdWater.
  ///
  /// In en, this message translates to:
  /// **'Wash hands and face with cold water'**
  String get washHandsAndFaceWithColdWater;

  /// No description provided for @keepWindowsAndDoorsClosed.
  ///
  /// In en, this message translates to:
  /// **'Keep windows and doors closed'**
  String get keepWindowsAndDoorsClosed;

  /// No description provided for @useLightCurtains.
  ///
  /// In en, this message translates to:
  /// **'Use light curtains'**
  String get useLightCurtains;

  /// No description provided for @useFan.
  ///
  /// In en, this message translates to:
  /// **'Use fan'**
  String get useFan;

  /// No description provided for @eatLiquidAndEasilyDigestibleFoods.
  ///
  /// In en, this message translates to:
  /// **'Eat liquid and easily digestible foods'**
  String get eatLiquidAndEasilyDigestibleFoods;

  /// No description provided for @avoidFriedAndHeavyFoods.
  ///
  /// In en, this message translates to:
  /// **'Avoid fried and heavy foods'**
  String get avoidFriedAndHeavyFoods;

  /// No description provided for @eatMoreFruitsAndVegetables.
  ///
  /// In en, this message translates to:
  /// **'Eat more fruits and vegetables'**
  String get eatMoreFruitsAndVegetables;

  /// No description provided for @consumeAdequateProteinAndMinerals.
  ///
  /// In en, this message translates to:
  /// **'Consume adequate protein and minerals'**
  String get consumeAdequateProteinAndMinerals;

  /// No description provided for @helpSupport.
  ///
  /// In en, this message translates to:
  /// **'Help & Support'**
  String get helpSupport;

  /// No description provided for @termsConditions.
  ///
  /// In en, this message translates to:
  /// **'Terms & Conditions'**
  String get termsConditions;

  /// No description provided for @about.
  ///
  /// In en, this message translates to:
  /// **'About'**
  String get about;

  /// No description provided for @heatwaveInfo.
  ///
  /// In en, this message translates to:
  /// **'Heatwave Info'**
  String get heatwaveInfo;

  /// No description provided for @heatAlert.
  ///
  /// In en, this message translates to:
  /// **'Heat Alert'**
  String get heatAlert;

  /// No description provided for @emergencyHelpline.
  ///
  /// In en, this message translates to:
  /// **'Emergency Helpline'**
  String get emergencyHelpline;
}

class _AppLocalizationsDelegate extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) => <String>['bn', 'en'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {


  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'bn': return AppLocalizationsBn();
    case 'en': return AppLocalizationsEn();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.'
  );
}
