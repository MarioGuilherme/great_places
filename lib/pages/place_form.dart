import "dart:io";

import "package:flutter/material.dart";
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:great_places/Providers/great_places.dart';
import 'package:great_places/Widgets/location_input.dart';
import "package:great_places/widgets/image_input.dart";
import 'package:provider/provider.dart';

class PlaceForm extends StatefulWidget {
  const PlaceForm({Key? key}) : super(key: key);

  @override
  State<PlaceForm> createState() => _PlaceFormState();
}

class _PlaceFormState extends State<PlaceForm> {
  final TextEditingController _titleController = TextEditingController();
  File? _pickedImage;
  LatLng? _pickedPosition;

  void _selectImage(File pickedImage) => this._pickedImage = pickedImage;

  void _selectPosition(LatLng position) {
    this._pickedPosition = position;
  }

  void _submitForm() {
    if (this._titleController.text.isEmpty || this._pickedImage == null)
      return;

    Provider.of<GreatPlaces>(context, listen: false).addPlace(this._titleController.text, this._pickedImage!, _pickedPosition!);

    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Novo Lugar!")
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Column(
                  children: <Widget>[
                    TextField(
                      controller: this._titleController,
                      decoration: const InputDecoration(
                        labelText: "Título"
                      )
                    ),
                    const SizedBox(height: 10),
                    ImageInput(this._selectImage),
                    const SizedBox(height: 10),
                    LocationInput(_selectPosition)
                  ]
                )
              )
            )
          ),
          RaisedButton.icon(
            onPressed: this._submitForm,
            color: Theme.of(context).colorScheme.secondary,
            icon: const Icon(Icons.add),
            elevation: 0,
            materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
            label: const Text("Adicionar")
          )
        ]
      )
    );
  }
}