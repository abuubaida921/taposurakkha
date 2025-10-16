# Taposurakkha

Taposurakkha is a Flutter application designed to provide heatwave safety information, emergency helplines, and nearby pharmacy locations using interactive maps. The app supports both Bangla and English languages to cater to a wider audience.

## Features

- **Heatwave Safety Tips**: Comprehensive guides on precautions and what to do during heatwaves, categorized by different groups (children, elderly, pregnant women, etc.).
- **Emergency Helpline**: Direct access to emergency contact numbers for health services, ambulances, and support centers. Numbers are tappable to call directly and can be copied to clipboard.
- **OSM Mapping**: Interactive map showing nearby pharmacies and healthcare facilities. Includes zoom controls, current location marker, and distance calculations.
- **Localization**: Full support for Bangla and English languages, with easy language switching.
- **User-Friendly UI**: Modern, accessible design with professional color schemes and intuitive navigation.

## Screenshots

*(Add screenshots here if available)*

## Getting Started

### Prerequisites

- Flutter SDK: 3.35.5 (stable channel)
- Dart: 3.9.2
- Android Studio or VS Code with Flutter extensions
- Android/iOS device or emulator

### Installation

1. Clone the repository:
   ```bash
   git clone https://github.com/abuubaida921/taposurakkha.git
   cd taposurakkha
   ```

2. Install dependencies:
   ```bash
   flutter pub get
   ```

3. Generate localization files:
   ```bash
   flutter gen-l10n
   ```

4. Run the app:
   ```bash
   flutter run
   ```

### Build for Production

- **Android APK**:
  ```bash
  flutter build apk --release
  ```

- **iOS**:
  ```bash
  flutter build ios --release
  ```

## Project Structure

```
lib/
├── main.dart                    # App entry point
├── app/                         # Main app structure
├── modules/
│   ├── heatwave_info/
│   │   ├── emergency_helpline_view.dart  # Emergency contacts page
│   │   └── places_map_page.dart          # Map with pharmacies
│   └── ... (other modules)
└── l10n/                        # Localization files
    ├── app_en.arb               # English translations
    ├── app_bn.arb               # Bangla translations
    └── app_localizations.dart   # Generated localization classes

assets/
├── images/                      # App images
├── fonts/                       # Custom fonts
└── healthcare_pharmacy.geojson  # Pharmacy location data
```

## Dependencies

- `flutter_map: ^8.2.2` - Interactive maps
- `geolocator: ^14.0.2` - Location services
- `latlong2: ^0.9.1` - Geographic coordinates
- `url_launcher: ^6.1.7` - Launch URLs and phone calls
- `flutter_localizations` - Internationalization support
- `shared_preferences: ^2.2.2` - Local storage
- `http: ^1.2.1` - HTTP requests
- `fluttertoast: ^8.2.12` - Toast notifications

## Flutter Version

This project is built with:

- **Flutter**: 3.35.5 • channel stable • https://github.com/flutter/flutter.git
- **Framework**: revision ac4e799d23 (3 weeks ago) • 2025-09-26 12:05:09 -0700
- **Engine**: hash 0274ead41f6265309f36e9d74bc8c559becd5345 (revision d3d45dcf25) (20 days ago) • 2025-09-26 16:45:18.000Z
- **Tools**: Dart 3.9.2 • DevTools 2.48.0

## Usage

1. **Language Selection**: Switch between Bangla and English from the settings.
2. **Heatwave Info**: Browse safety tips and precautions.
3. **Emergency Helpline**: View and contact emergency services directly.
4. **Nearby Pharmacies**: Use the map to find pharmacies, zoom in/out, and center on your location.

## Contributing

1. Fork the repository
2. Create a feature branch (`git checkout -b feature/amazing-feature`)
3. Commit your changes (`git commit -m 'Add some amazing feature'`)
4. Push to the branch (`git push origin feature/amazing-feature`)
5. Open a Pull Request

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## Acknowledgments

- OpenStreetMap for map data
- Flutter community for excellent documentation and packages
- Contributors and testers

## Support

For support, email support@taposurakkha.com or create an issue in the repository.

---

Built with ❤️ using Flutter
