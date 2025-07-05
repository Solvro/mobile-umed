import "package:flutter/material.dart";
import "package:latlong2/latlong.dart";

import "../../../common/utils/location_service.dart";

class LocationWidget extends StatefulWidget {
  const LocationWidget({super.key});

  @override
  State<LocationWidget> createState() => _LocationWidgetState();
}

class _LocationWidgetState extends State<LocationWidget> {
  late Stream<LatLng?> _locationStream;

  @override
  void initState() {
    super.initState();
    _locationStream = LocationService.getLocationStream();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<LatLng?>(
      stream: _locationStream,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          final latLng = snapshot.data!;
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.location_on, size: 40, color: Colors.red),
              Text(
                "Lat: ${latLng.latitude.toStringAsFixed(5)}\nLng: ${latLng.longitude.toStringAsFixed(5)}",
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 18),
              ),
            ],
          );
        } else if (snapshot.hasError) {
          return const Text("Błąd podczas pobierania lokalizacji");
        } else {
          return const CircularProgressIndicator();
        }
      },
    );
  }
}
