import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:geolocator/geolocator.dart';

import '../../l10n/app_localizations.dart';

class PlacesMapPage extends StatefulWidget {
  const PlacesMapPage({super.key});

  @override
  State<PlacesMapPage> createState() => _PlacesMapPageState();
}

class _PlacesMapPageState extends State<PlacesMapPage> {
  List<Map<String, dynamic>> places = [];
  LatLng? userLocation;
  String searchQuery = "";

  // Map controller and zoom state for zoom + location controls
  final MapController _mapController = MapController();
  double _zoom = 13.0;

  @override
  void initState() {
    super.initState();
    loadGeoJSON();
    getUserLocation();
  }

  Future<void> loadGeoJSON() async {
    try {
      final data =
      await rootBundle.loadString('assets/healthcare_pharmacy.geojson');
      final jsonResult = json.decode(data);

      log("✅ GeoJSON loaded with ${jsonResult['features'].length} features");

      final List<Map<String, dynamic>> loadedPlaces = [];
      for (var feature in jsonResult['features']) {
        final coords = feature['geometry']?['coordinates'];
        final props = feature['properties'] ?? {};

        if (coords != null && coords.length >= 2) {
          loadedPlaces.add({
            'name': props['name'] ?? 'Unknown',
            'type': props['type'] ?? 'N/A',
            'lat': coords[1],
            'lng': coords[0],
          });
        }
      }

      setState(() => places = loadedPlaces);
    } catch (e) {
      log("❌ Error loading GeoJSON: $e");
    }
  }

  Future<void> getUserLocation() async {
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(AppLocalizations.of(context)!.enableLocationServices)));
      return;
    }

    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied ||
        permission == LocationPermission.deniedForever) {
      permission = await Geolocator.requestPermission();
      if (permission != LocationPermission.whileInUse &&
          permission != LocationPermission.always) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text(AppLocalizations.of(context)!.locationPermissionDenied)));
        return;
      }
    }

    final pos = await Geolocator.getCurrentPosition();
    setState(() => userLocation = LatLng(pos.latitude, pos.longitude));
  }

  double calculateDistance(LatLng from, LatLng to) {
    return Geolocator.distanceBetween(
        from.latitude, from.longitude, to.latitude, to.longitude) /
        1000; // km
  }

  @override
  Widget build(BuildContext context) {
    final filteredPlaces = places.where((place) {
      return place['name']
          .toString()
          .toLowerCase()
          .contains(searchQuery.toLowerCase());
    }).toList();

    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.nearbyPharmacies),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8),
            child: TextField(
              decoration: InputDecoration(
                hintText: AppLocalizations.of(context)!.searchPlaceHint,
                prefixIcon: const Icon(Icons.search),
                border: const OutlineInputBorder(),
              ),
              onChanged: (value) => setState(() => searchQuery = value),
            ),
          ),
          Expanded(
            child: Stack(
              children: [
                FlutterMap(
                  mapController: _mapController,
                  options: MapOptions(
                    initialCenter: userLocation ?? const LatLng(23.8103, 90.4125), // Dhaka fallback
                    initialZoom: _zoom,
                  ),
                  children: [
                    TileLayer(
                      urlTemplate:
                      'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
                      subdomains: const ['a', 'b', 'c'],
                    ),
                    if (userLocation != null)
                      MarkerLayer(
                        markers: [
                          Marker(
                            point: userLocation!,
                            width: 40,
                            height: 40,
                            child: const Icon(Icons.my_location,
                                color: Colors.blue, size: 30),
                          )
                        ],
                      ),
                    MarkerLayer(
                      markers: filteredPlaces.map((place) {
                        final LatLng point = LatLng(place['lat'], place['lng']);
                        double? distance;
                        if (userLocation != null) {
                          distance = calculateDistance(userLocation!, point);
                        }

                        return Marker(
                          point: point,
                          width: 160,
                          height: 60,
                          child: GestureDetector(
                            onTap: () {
                              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                content: Text(
                                  AppLocalizations.of(context)!.placeDistance(
                                    (distance ?? 0).toStringAsFixed(2),
                                    place['name'],
                                  ),
                                ),
                                duration: const Duration(seconds: 2),
                              ));
                            },
                            child: Column(
                              children: [
                                const Icon(Icons.location_on,
                                    color: Colors.red, size: 32),
                                Container(
                                  width: 150,
                                  padding:
                                  const EdgeInsets.symmetric(horizontal: 4),
                                  child: Text(
                                    place['name'],
                                    textAlign: TextAlign.center,
                                    style: const TextStyle(
                                        fontSize: 11,
                                        fontWeight: FontWeight.w600,
                                        color: Colors.black),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                  ],
                ),

                // Zoom and My Location buttons
                Positioned(
                  bottom: 16,
                  right: 12,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      // My location
                      FloatingActionButton(
                        heroTag: 'locate',
                        mini: true,
                        onPressed: () {
                          if (userLocation != null) {
                            setState(() {
                              _zoom = 15.0;
                            });
                            // Some flutter_map versions don't expose MapController.center.
                            // Use userLocation as center fallback to avoid undefined getter errors.
                            final center = userLocation ?? const LatLng(23.8103, 90.4125);
                            _mapController.move(center, _zoom);
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              content: Text(AppLocalizations.of(context)!.enableLocationServices),
                            ));
                          }
                        },
                        child: const Icon(Icons.my_location,color: Colors.white),
                      ),
                      const SizedBox(height: 8),

                      // Zoom in
                      FloatingActionButton(
                        heroTag: 'zoomIn',
                        mini: true,
                        onPressed: () {
                          setState(() {
                            if (_zoom < 18) _zoom += 1;
                          });
                          final center = userLocation ?? const LatLng(23.8103, 90.4125);
                          _mapController.move(center, _zoom);
                        },
                        child: const Icon(Icons.zoom_in,color: Colors.white),
                      ),
                      const SizedBox(height: 8),

                      // Zoom out
                      FloatingActionButton(
                        heroTag: 'zoomOut',
                        mini: true,
                        onPressed: () {
                          setState(() {
                            if (_zoom > 3) _zoom -= 1;
                          });
                          final center = userLocation ?? const LatLng(23.8103, 90.4125);
                          _mapController.move(center, _zoom);
                        },
                        child: const Icon(Icons.zoom_out,color: Colors.white,),
                      ),
                    ],
                  ),
                ),

              ],
            ),
          ),
        ],
      ),
    );
  }
}
