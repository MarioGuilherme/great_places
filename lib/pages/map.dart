import "package:flutter/material.dart";
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:great_places/Models/place.dart';

class Map extends StatefulWidget {
  final PlaceLocation initialLocation;
  final bool isReadOnly;

  const Map({
    this.initialLocation = const PlaceLocation(
      latitude: 23,
      longitude: 65
    ),
    this.isReadOnly = false,
    Key? key
  }) : super(key: key);

  @override
  State<Map> createState() => _MapState();
}

class _MapState extends State<Map> {
  late LatLng? _pickedPosition;

  void _selectPosition(LatLng position) {
    setState(() => this._pickedPosition = position);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Selecione..."),
        actions: [
          if (!widget.isReadOnly)
            IconButton(
              icon: const Icon(Icons.check),
              onPressed: this._pickedPosition == null
              ? null
              : () {
                Navigator.of(context).pop(this._pickedPosition);
              }
            )
        ]
      ),
      body: GoogleMap(
        initialCameraPosition: CameraPosition(
          target: LatLng(
            widget.initialLocation.latitude,
            widget.initialLocation.longitude
          ),
          zoom: 13
        ),
        onTap: widget.isReadOnly ? null : _selectPosition,
        markers: this._pickedPosition == null
          ? {}
          : <Marker>{
            Marker(
              markerId: MarkerId("p1"),
              position: this._pickedPosition!
            )
          }
      )
    );
  }
}