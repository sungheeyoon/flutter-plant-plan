import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:korea_regexp/korea_regexp.dart';
import 'package:plant_plan/models/plant_model.dart';
import 'package:plant_plan/screens/add_screen.dart';
import 'package:plant_plan/utils/colors.dart';
import 'package:plant_plan/widgets/custom_appbar.dart';
import 'package:plant_plan/widgets/search_widget.dart';

class PlantSearchScreen extends StatefulWidget {
  const PlantSearchScreen({super.key});

  @override
  State<PlantSearchScreen> createState() => _PlantSearchScreenState();
}

class _PlantSearchScreenState extends State<PlantSearchScreen> {
  late Stream<QuerySnapshot> _streamPlantList;
  String enteredKeyword = "";

  final CollectionReference _referencePlantList =
      FirebaseFirestore.instance.collection('plant_list');

  @override
  initState() {
    _streamPlantList = _referencePlantList.snapshots();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Widget buildSearch() => SearchWidget(
          text: enteredKeyword,
          hintText: '식물 이름을 검색하세요',
          onChanged: (value) {
            setState(() {
              enteredKeyword = value;
            });
          },
        );
    return Scaffold(
      appBar: const CustomAppBar(title: "식물검색", home: false),
      body: Column(
        children: <Widget>[
          buildSearch(),
          Expanded(
            child: StreamBuilder<QuerySnapshot>(
              stream: _streamPlantList,
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                if (snapshot.hasError) {
                  return Center(child: Text(snapshot.error.toString()));
                }
                if (snapshot.connectionState == ConnectionState.active) {
                  QuerySnapshot querySnapshot = snapshot.data;
                  List<QueryDocumentSnapshot> listQueryDocumentSnapshot =
                      querySnapshot.docs;
                  return ListView.builder(
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      itemCount: listQueryDocumentSnapshot.length,
                      itemBuilder: (context, index) {
                        QueryDocumentSnapshot document =
                            listQueryDocumentSnapshot[index];
                        if (enteredKeyword.isEmpty) {
                          return ListTile(
                            title: Text(
                              document['name'],
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: Theme.of(context)
                                  .textTheme
                                  .titleMedium!
                                  .copyWith(color: primary3Color),
                            ),
                            leading: CachedNetworkImage(
                              imageUrl: document['image'],
                              imageBuilder: (context, imageProvider) =>
                                  Container(
                                width: 44.0,
                                height: 44.0,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  image: DecorationImage(
                                      image: imageProvider, fit: BoxFit.cover),
                                ),
                              ),
                              placeholder: (context, url) => const SizedBox(
                                width: 44.0,
                                height: 44.0,
                                child: CircleAvatar(
                                  backgroundColor: gray1Color,
                                ),
                              ),
                              errorWidget: (context, url, error) =>
                                  const Icon(Icons.error),
                            ),
                            onTap: () =>
                                Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => AddScreen(
                                document: PlantModel.fromFirestore(document),
                              ),
                            )),
                          );
                        } else {
                          RegExp regExp = getRegExp(
                              enteredKeyword,
                              RegExpOptions(
                                initialSearch: false,
                                startsWith: false,
                                endsWith: false,
                                fuzzy: false,
                                ignoreSpace: false,
                                ignoreCase: false,
                              ));
                          if (regExp.hasMatch(document["name"] as String)) {
                            return ListTile(
                              title: Text(
                                document['name'],
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: Theme.of(context)
                                    .textTheme
                                    .titleMedium!
                                    .copyWith(color: primary3Color),
                              ),
                              leading: CachedNetworkImage(
                                imageUrl: document['image'],
                                imageBuilder: (context, imageProvider) =>
                                    Container(
                                  width: 44.0,
                                  height: 44.0,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    image: DecorationImage(
                                        image: imageProvider,
                                        fit: BoxFit.cover),
                                  ),
                                ),
                                placeholder: (context, url) => const SizedBox(
                                  width: 44.0,
                                  height: 44.0,
                                  child: CircleAvatar(
                                    backgroundColor: gray1Color,
                                  ),
                                ),
                                errorWidget: (context, url, error) =>
                                    const Icon(Icons.error),
                              ),
                            );
                          }
                        }

                        return Container();
                      });
                }
                return const Center(child: CircularProgressIndicator());
              },
            ),
          ),
        ],
      ),
    );
  }
}
