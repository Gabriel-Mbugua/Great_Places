import 'dart:io';

import 'package:flutter/material.dart';
import 'package:great_places/screens/place_detail_screen.dart';
import '../providers/great_places.dart';
import 'package:provider/provider.dart';

import 'add_place_screen.dart';
import '../providers/great_places.dart';

class PlacesListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Your places"),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              Navigator.of(context).pushNamed(AddPlaceScreen.routeName);
            },
          )
        ],
      ),
      body: FutureBuilder(
        future: Provider.of<GreatPlaces>(context, listen: false)
            .fetchAndSetPlaces(),
        builder: (ctx, snapshot) => snapshot.connectionState ==
                ConnectionState.waiting
            ? Center(
                child: CircularProgressIndicator(),
              )
            : Consumer<GreatPlaces>(
                child: Center(
                  child: const Text("Got no places yet! Start adding some!"),
                ),
                builder: (ctx, greatPlaces, ch) => greatPlaces.items.length <= 0
                    ? ch
                    : ListView.builder(
                        itemBuilder: (ctx, i) => Container(
                          // width: MediaQuery.of(context).size.width * 0.2,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(
                              Radius.circular(5),
                            ),
                            // border: Border.all(width: 1, ),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              children: <Widget>[
                                // ListTile(
                                //   trailing: CircleAvatar(
                                //     radius: 30,
                                //     backgroundImage: FileImage(
                                //       greatPlaces.items[i].image,
                                //     ),
                                //   ),
                                //   title: Text(
                                //     greatPlaces.items[i].title,
                                //   ),
                                //   subtitle: Text(
                                //     greatPlaces.items[i].location.address,
                                //   ),
                                //   onTap: () {
                                //     Navigator.of(context).pushNamed(
                                //       PlaceDetailScreen.routeName,
                                //       arguments: greatPlaces.items[i].id,
                                //     );
                                //   },
                                // ),
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(15.0),
                                  child: GestureDetector(
                                    onTap: () {
                                      Navigator.of(context).pushNamed(
                                        PlaceDetailScreen.routeName,
                                        arguments: greatPlaces.items[i].id,
                                      );
                                    },
                                    child: Card(
                                      elevation: 2,
                                      child: Column(
                                        children: <Widget>[
                                          Hero(
                                            tag: greatPlaces.items[i].id,
                                            child: Image.file(
                                              greatPlaces.items[i].image,
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: ListTile(
                                              title: Text(
                                                greatPlaces.items[i].title,
                                              ),
                                              subtitle: Text(greatPlaces
                                                  .items[i].location.address),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                Divider(),
                              ],
                            ),
                          ),
                        ),
                        itemCount: greatPlaces.items.length,
                      ),
              ),
      ),
    );
  }
}
