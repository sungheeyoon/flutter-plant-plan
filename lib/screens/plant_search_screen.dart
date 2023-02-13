import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:korea_regexp/korea_regexp.dart';
import 'package:plant_plan/utils/colors.dart';
import 'package:plant_plan/widgets/custom_appbar.dart';

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
    return Scaffold(
      appBar: const CustomAppBar(title: "식물검색", home: false),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          children: [
            Container(
              margin: const EdgeInsets.symmetric(vertical: 20),
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: gray4Color,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Row(children: [
                const Icon(
                  FontAwesomeIcons.magnifyingGlass,
                  size: 20,
                  color: gray2Color,
                ),
                const SizedBox(
                  width: 8,
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.7,
                  child: TextField(
                    onChanged: (value) {
                      setState(() {
                        enteredKeyword = value;
                      });
                    },
                    style: Theme.of(context)
                        .textTheme
                        .bodySmall!
                        .copyWith(color: grayBlack),
                    decoration: const InputDecoration(
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: gray4Color),
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: gray4Color),
                      ),
                      isCollapsed: true,
                    ),
                  ),
                ),
              ]),
            ),
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
                                style: const TextStyle(
                                    color: Colors.black54,
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold),
                              ),
                              subtitle: Text(
                                document['id'].toString(),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(
                                    color: Colors.black54,
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold),
                              ),
                              leading: const CircleAvatar(
                                  backgroundColor: Colors.black),
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
                                  style: const TextStyle(
                                      color: Colors.black54,
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold),
                                ),
                                subtitle: Text(
                                  document['id'].toString(),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: const TextStyle(
                                      color: Colors.black54,
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold),
                                ),
                                leading: const CircleAvatar(
                                    backgroundColor: Colors.black),
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
      ),
    );
  }
}
