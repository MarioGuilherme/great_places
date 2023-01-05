import "package:flutter/material.dart";

import "package:great_places/Providers/great_places.dart";
import "package:great_places/Utils/AppRoutes.dart";

import "package:provider/provider.dart";

class PlacesList extends StatelessWidget {
  const PlacesList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Meus lugares"),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () => Navigator.of(context).pushNamed(AppRoutes.PLACE_FORM)
          )
        ]
      ),
      body: FutureBuilder(
        future: Provider.of<GreatPlaces>(context, listen: false).loadPlaces(),
        builder: (context, snapshot) => snapshot.connectionState == ConnectionState.waiting
          ? const Center(child: CircularProgressIndicator())
          : Consumer<GreatPlaces>(
            child: const Center(
              child: Text("Nenhum local cadastrado!")
            ),
            builder: (context, greatPlaces, child) => greatPlaces.itemsCount == 0
              ? child!
              : ListView.builder(
                itemCount: greatPlaces.itemsCount,
                itemBuilder: (context, index) => ListTile(
                  leading: CircleAvatar(
                    backgroundImage: FileImage(
                      greatPlaces.itemByIndex(index).image
                    )
                  ),
                  title: Text(greatPlaces.itemByIndex(index).title),
                  onTap: () {}
                )
              )
          )
      )
    );
  }
}