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

  /// No description provided for @causeLabel.
  ///
  /// In en, this message translates to:
  /// **'Cause: '**
  String get causeLabel;

  /// No description provided for @symptomLabel.
  ///
  /// In en, this message translates to:
  /// **'Symptom: '**
  String get symptomLabel;

  /// No description provided for @emergencyHelpline.
  ///
  /// In en, this message translates to:
  /// **'Emergency Helpline'**
  String get emergencyHelpline;

  /// No description provided for @emergencyHelplineTitle.
  ///
  /// In en, this message translates to:
  /// **'Emergency Helpline'**
  String get emergencyHelplineTitle;

  /// No description provided for @emergencyHelplineQuestion.
  ///
  /// In en, this message translates to:
  /// **'What is the Emergency Helpline Number?'**
  String get emergencyHelplineQuestion;

  /// No description provided for @emergencyHelplineQuestionSubtitle.
  ///
  /// In en, this message translates to:
  /// **'(What is the Emergency Helpline Number?)'**
  String get emergencyHelplineQuestionSubtitle;

  /// No description provided for @emergencyHelplineQuestionContent.
  ///
  /// In en, this message translates to:
  /// **'Collect local health department and ambulance service numbers for heatwave-related illnesses.'**
  String get emergencyHelplineQuestionContent;

  /// No description provided for @emergencyHelplineServicesTitle.
  ///
  /// In en, this message translates to:
  /// **'Emergency Services'**
  String get emergencyHelplineServicesTitle;

  /// No description provided for @emergencyHelplineService1Title.
  ///
  /// In en, this message translates to:
  /// **'Emergency assistance for heatwave-related illnesses'**
  String get emergencyHelplineService1Title;

  /// No description provided for @emergencyHelplineService1Subtitle.
  ///
  /// In en, this message translates to:
  /// **'(Emergency assistance for heatwave-related illnesses)'**
  String get emergencyHelplineService1Subtitle;

  /// No description provided for @emergencyHelplineService2Title.
  ///
  /// In en, this message translates to:
  /// **'Local organizations for emergency health assistance'**
  String get emergencyHelplineService2Title;

  /// No description provided for @emergencyHelplineService2Subtitle.
  ///
  /// In en, this message translates to:
  /// **'(Local organizations for emergency health assistance)'**
  String get emergencyHelplineService2Subtitle;

  /// No description provided for @emergencyHelplineService3Title.
  ///
  /// In en, this message translates to:
  /// **'Ambulance and emergency medical services'**
  String get emergencyHelplineService3Title;

  /// No description provided for @emergencyHelplineService3Subtitle.
  ///
  /// In en, this message translates to:
  /// **'(Ambulance and emergency medical services)'**
  String get emergencyHelplineService3Subtitle;

  /// No description provided for @heatwaveInfoTitle.
  ///
  /// In en, this message translates to:
  /// **'Understanding Heatwaves'**
  String get heatwaveInfoTitle;

  /// No description provided for @whatIsHeatwaveQ.
  ///
  /// In en, this message translates to:
  /// **'What is a Heatwave?'**
  String get whatIsHeatwaveQ;

  /// No description provided for @whatIsHeatwaveA.
  ///
  /// In en, this message translates to:
  /// **'A heatwave is a period when the temperature becomes significantly higher than normal and lasts for at least 3 days. Usually, the temperature is 36°C or higher.'**
  String get whatIsHeatwaveA;

  /// No description provided for @typesOfHeatwaveQ.
  ///
  /// In en, this message translates to:
  /// **'Types of Heatwaves in Bangladesh'**
  String get typesOfHeatwaveQ;

  /// No description provided for @mildHeatwave.
  ///
  /// In en, this message translates to:
  /// **'Mild: 36°C–38°C'**
  String get mildHeatwave;

  /// No description provided for @moderateHeatwave.
  ///
  /// In en, this message translates to:
  /// **'Moderate: 38°C–40°C'**
  String get moderateHeatwave;

  /// No description provided for @severeHeatwave.
  ///
  /// In en, this message translates to:
  /// **'Severe: 40°C or above'**
  String get severeHeatwave;

  /// No description provided for @causesOfHeatwaveQ.
  ///
  /// In en, this message translates to:
  /// **'What are the Causes of Heatwaves?'**
  String get causesOfHeatwaveQ;

  /// No description provided for @causeHighPressure.
  ///
  /// In en, this message translates to:
  /// **'High-pressure atmospheric conditions causing hot air to accumulate'**
  String get causeHighPressure;

  /// No description provided for @causeDryWind.
  ///
  /// In en, this message translates to:
  /// **'Dry seasonal wind flow'**
  String get causeDryWind;

  /// No description provided for @causeUrbanHeatIsland.
  ///
  /// In en, this message translates to:
  /// **'Urban Heat Island Effect'**
  String get causeUrbanHeatIsland;

  /// No description provided for @causeClimateChange.
  ///
  /// In en, this message translates to:
  /// **'Rising temperatures due to climate change'**
  String get causeClimateChange;

  /// No description provided for @preMonsoonSpecial.
  ///
  /// In en, this message translates to:
  /// **'Pre-monsoon: Sunlight is very intense, soil moisture is low, and hot dry weather creates heatwaves.'**
  String get preMonsoonSpecial;

  /// No description provided for @preMonsoonLabel.
  ///
  /// In en, this message translates to:
  /// **'Pre-monsoon:'**
  String get preMonsoonLabel;

  /// No description provided for @healthSymptomsQ.
  ///
  /// In en, this message translates to:
  /// **'What are the Symptoms of Heat-Related Health Issues?'**
  String get healthSymptomsQ;

  /// No description provided for @heatExhaustion.
  ///
  /// In en, this message translates to:
  /// **'Heat Exhaustion'**
  String get heatExhaustion;

  /// No description provided for @heatExhaustionCause.
  ///
  /// In en, this message translates to:
  /// **'Prolonged exposure to heat and not drinking enough water'**
  String get heatExhaustionCause;

  /// No description provided for @heatExhaustionSymptom.
  ///
  /// In en, this message translates to:
  /// **'Weakness, dizziness, nausea, cold clammy skin, rapid and weak pulse'**
  String get heatExhaustionSymptom;

  /// No description provided for @heatStroke.
  ///
  /// In en, this message translates to:
  /// **'Heat Stroke'**
  String get heatStroke;

  /// No description provided for @heatStrokeCause.
  ///
  /// In en, this message translates to:
  /// **'Rapid rise in body temperature and lack of sweating'**
  String get heatStrokeCause;

  /// No description provided for @heatStrokeSymptom.
  ///
  /// In en, this message translates to:
  /// **'Hot and dry skin, unconsciousness, rapid heartbeat, high temperature (40°C or above)'**
  String get heatStrokeSymptom;

  /// No description provided for @heatCramp.
  ///
  /// In en, this message translates to:
  /// **'Heat Cramp'**
  String get heatCramp;

  /// No description provided for @heatCrampCause.
  ///
  /// In en, this message translates to:
  /// **'Excessive sweating and salt-water deficiency'**
  String get heatCrampCause;

  /// No description provided for @heatCrampSymptom.
  ///
  /// In en, this message translates to:
  /// **'Sudden muscle pain or spasm, sweating'**
  String get heatCrampSymptom;

  /// No description provided for @dehydration.
  ///
  /// In en, this message translates to:
  /// **'Dehydration'**
  String get dehydration;

  /// No description provided for @dehydrationCause.
  ///
  /// In en, this message translates to:
  /// **'Excessive loss of water from the body'**
  String get dehydrationCause;

  /// No description provided for @dehydrationSymptom.
  ///
  /// In en, this message translates to:
  /// **'Thirst, dry mouth, less urination, weakness, sunken and dry eyes'**
  String get dehydrationSymptom;

  /// No description provided for @skinProblem.
  ///
  /// In en, this message translates to:
  /// **'Skin Problem'**
  String get skinProblem;

  /// No description provided for @skinProblemCause.
  ///
  /// In en, this message translates to:
  /// **'Sweat accumulation causing skin issues'**
  String get skinProblemCause;

  /// No description provided for @skinProblemSymptom.
  ///
  /// In en, this message translates to:
  /// **'Red rash or blisters, burning or itching skin'**
  String get skinProblemSymptom;

  /// No description provided for @answerLabel.
  ///
  /// In en, this message translates to:
  /// **'Answer: '**
  String get answerLabel;

  /// No description provided for @heatAlertTitle.
  ///
  /// In en, this message translates to:
  /// **'Heat Alert'**
  String get heatAlertTitle;

  /// No description provided for @heatAlertImportanceTitle.
  ///
  /// In en, this message translates to:
  /// **'Importance of Heatwave Forecast'**
  String get heatAlertImportanceTitle;

  /// No description provided for @heatAlertImportancePoint1.
  ///
  /// In en, this message translates to:
  /// **'Helps protect health and conserve water with early warning'**
  String get heatAlertImportancePoint1;

  /// No description provided for @heatAlertImportancePoint2.
  ///
  /// In en, this message translates to:
  /// **'Reduces damage in agriculture and industry'**
  String get heatAlertImportancePoint2;

  /// No description provided for @heatAlertImportancePoint3.
  ///
  /// In en, this message translates to:
  /// **'Facilitates emergency services and hospital preparedness'**
  String get heatAlertImportancePoint3;

  /// No description provided for @heatAlert7DayForecastTitle.
  ///
  /// In en, this message translates to:
  /// **'7-Day Forecast'**
  String get heatAlert7DayForecastTitle;

  /// No description provided for @heatAlertTemperatureChart.
  ///
  /// In en, this message translates to:
  /// **'Temperature Chart'**
  String get heatAlertTemperatureChart;

  /// No description provided for @heatAlertLevelWarning.
  ///
  /// In en, this message translates to:
  /// **'Warning'**
  String get heatAlertLevelWarning;

  /// No description provided for @heatAlertLevelWarningRange.
  ///
  /// In en, this message translates to:
  /// **'35°C - 38°C'**
  String get heatAlertLevelWarningRange;

  /// No description provided for @heatAlertLevelWarningDesc.
  ///
  /// In en, this message translates to:
  /// **'Children, elderly, and sick people are advised not to go outside due to hot weather.'**
  String get heatAlertLevelWarningDesc;

  /// No description provided for @heatAlertLevelRisk.
  ///
  /// In en, this message translates to:
  /// **'Risk'**
  String get heatAlertLevelRisk;

  /// No description provided for @heatAlertLevelRiskRange.
  ///
  /// In en, this message translates to:
  /// **'39°C - 42°C'**
  String get heatAlertLevelRiskRange;

  /// No description provided for @heatAlertLevelRiskDesc.
  ///
  /// In en, this message translates to:
  /// **'Water crisis and heat-related problems will increase. Emphasis should be given to patient care and emergency medical preparedness.'**
  String get heatAlertLevelRiskDesc;

  /// No description provided for @heatAlertLevelAlert.
  ///
  /// In en, this message translates to:
  /// **'Alert'**
  String get heatAlertLevelAlert;

  /// No description provided for @heatAlertLevelAlertRange.
  ///
  /// In en, this message translates to:
  /// **'40°C or above'**
  String get heatAlertLevelAlertRange;

  /// No description provided for @heatAlertLevelAlertDesc.
  ///
  /// In en, this message translates to:
  /// **'Severe heatwave, agriculture and water resources may be affected. Everyone is advised to stay in safe shelters.'**
  String get heatAlertLevelAlertDesc;

  /// No description provided for @heatAlertWarningLevelsTitle.
  ///
  /// In en, this message translates to:
  /// **'Warning Levels'**
  String get heatAlertWarningLevelsTitle;

  /// No description provided for @heatAlertWarningLevelRed.
  ///
  /// In en, this message translates to:
  /// **'Red Alert: Severe heatwave, prolonged hot weather.'**
  String get heatAlertWarningLevelRed;

  /// No description provided for @heatAlertWarningLevelYellow.
  ///
  /// In en, this message translates to:
  /// **'Yellow Alert: Moderate temperature rise, some caution needed.'**
  String get heatAlertWarningLevelYellow;

  /// No description provided for @heatAlertWarningLevelGreen.
  ///
  /// In en, this message translates to:
  /// **'Green Alert: Normal heat, no special caution needed.'**
  String get heatAlertWarningLevelGreen;

  /// No description provided for @weatherForecast.
  ///
  /// In en, this message translates to:
  /// **'Weather Forecast'**
  String get weatherForecast;
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
