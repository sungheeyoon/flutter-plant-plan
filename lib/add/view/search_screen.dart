import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:korea_regexp/korea_regexp.dart';
import 'package:plant_plan/add/model/plant_model.dart';
import 'package:plant_plan/add/repository/plant_repository.dart';

import 'package:plant_plan/models/preserve_model.dart';
import 'package:plant_plan/add/view/add_tab.dart';
import 'package:plant_plan/utils/colors.dart';
import 'package:plant_plan/widgets/search_widget.dart';

class SearchScreen extends StatefulWidget {
  final PreserveModel? prev;
  const SearchScreen({Key? key, this.prev}) : super(key: key);

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  late Stream<QuerySnapshot> _streamPlantList;
  late PlantRepository getPlantList;
  String enteredKeyword = "";

  final CollectionReference _referencePlantList =
      FirebaseFirestore.instance.collection('plant_list');

  @override
  initState() {
    _streamPlantList = _referencePlantList.snapshots();
    getPlantList = PlantRepository();

    super.initState();
  }

  List<PlantModel> _plantListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.docs.map((doc) {
      return PlantModel.fromJson(doc.data() as Map<String, dynamic>);
    }).toList();
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
      body: SafeArea(
        child: Column(
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
                    List<PlantModel> plantList =
                        _plantListFromSnapshot(snapshot.data);
                    return ListView.builder(
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                        itemCount: plantList.length,
                        itemBuilder: (context, index) {
                          PlantModel document = plantList[index];
                          if (enteredKeyword.isEmpty) {
                            return ListTile(
                              title: Text(
                                document.name,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: Theme.of(context)
                                    .textTheme
                                    .titleMedium!
                                    .copyWith(color: primaryColor),
                              ),
                              leading: CachedNetworkImage(
                                imageUrl: document.image,
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
                              onTap: () =>
                                  Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => AddTab(
                                  prev: widget.prev,
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
                            if (regExp.hasMatch(document.name)) {
                              return ListTile(
                                title: Text(
                                  document.name,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: Theme.of(context)
                                      .textTheme
                                      .titleMedium!
                                      .copyWith(color: primaryColor),
                                ),
                                leading: CachedNetworkImage(
                                  imageUrl: document.image,
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
                                onTap: () => Navigator.pop(
                                    context, {'prev': widget.prev}),
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
            OutlinedButton(
                onPressed: () {
                  print(getPlantList.getPlants(10));
                },
                child: const Text("test getplant list pagination"))
          ],
        ),
      ),
    );
  }
}
