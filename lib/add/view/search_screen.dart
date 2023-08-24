import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:korea_regexp/korea_regexp.dart';
import 'package:plant_plan/add/model/information_model.dart';
import 'package:plant_plan/add/provider/add_plant_provider.dart';
import 'package:plant_plan/add/view/add_first_screen.dart';
import 'package:plant_plan/common/layout/default_layout.dart';
import 'package:plant_plan/common/widget/profile_image_widget.dart';
import 'package:plant_plan/utils/colors.dart';
import 'package:plant_plan/widgets/search_widget.dart';

class SearchScreen extends ConsumerStatefulWidget {
  static String get routeName => 'addSearch';
  const SearchScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends ConsumerState<SearchScreen> {
  late Stream<QuerySnapshot> _streamInformationList;
  String enteredKeyword = "";

  final CollectionReference _referenceInformationList =
      FirebaseFirestore.instance.collection('plant_list');

  @override
  initState() {
    super.initState();
    _streamInformationList = _referenceInformationList.snapshots();
  }

  List<InformationModel> _informationListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.docs.map((doc) {
      return InformationModel.fromJson(doc.data()! as Map<String, dynamic>);
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    Widget buildSearch() => SearchWidget(
          text: enteredKeyword,
          hintText: '식물 이름을 입력해주세요',
          onChanged: (value) {
            setState(() {
              enteredKeyword = value;
            });
          },
        );
    return DefaultLayout(
      title: '식물 추가',
      titleBackgroundColor: keyColor100,
      child: SafeArea(
        child: Column(
          children: <Widget>[
            SizedBox(
              height: 20.h,
            ),
            buildSearch(),
            SizedBox(
              height: 20.h,
            ),
            Expanded(
              child: StreamBuilder<QuerySnapshot>(
                stream: _streamInformationList,
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  if (snapshot.hasError) {
                    return Center(child: Text(snapshot.error.toString()));
                  }
                  if (snapshot.connectionState == ConnectionState.active) {
                    List<InformationModel> informationList =
                        _informationListFromSnapshot(snapshot.data);
                    return ListView.builder(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                      ),
                      itemCount: informationList.length,
                      itemBuilder: (context, index) {
                        InformationModel document = informationList[index];
                        if (enteredKeyword.isEmpty) {
                          return ListTile(
                            title: Text(
                              document.name,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: Theme.of(context)
                                  .textTheme
                                  .titleMedium!
                                  .copyWith(color: grayBlack),
                            ),
                            leading: CachedNetworkImage(
                              imageUrl: document.imageUrl,
                              imageBuilder: (context, imageProvider) =>
                                  ProfileImageWidget(
                                imageProvider: imageProvider,
                                size: 40.h,
                                radius: 16.h,
                              ),
                              placeholder: (context, url) => SizedBox(
                                width: 40.h,
                                height: 40.h,
                                child: const CircleAvatar(
                                  backgroundColor: grayColor200,
                                ),
                              ),
                              errorWidget: (context, url, error) =>
                                  const Icon(Icons.error),
                            ),
                            onTap: () async {
                              ref
                                  .read(addPlantProvider.notifier)
                                  .updateInformation(document);

                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (BuildContext context) =>
                                          const AddFirstScreen()));
                            },
                          ).paddingOnly(bottom: 6.h);
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
                                    .copyWith(color: grayBlack),
                              ),
                              leading: CachedNetworkImage(
                                imageUrl: document.imageUrl,
                                imageBuilder: (context, imageProvider) =>
                                    ProfileImageWidget(
                                  imageProvider: imageProvider,
                                  size: 40.h,
                                  radius: 16.h,
                                ),
                                placeholder: (context, url) => SizedBox(
                                  width: 40.h,
                                  height: 40.h,
                                  child: const CircleAvatar(
                                    backgroundColor: grayColor200,
                                  ),
                                ),
                                errorWidget: (context, url, error) =>
                                    const Icon(Icons.error),
                              ),
                              onTap: () {
                                ref
                                    .read(addPlantProvider.notifier)
                                    .updateInformation(document);
                                Navigator.pushAndRemoveUntil(
                                    context,
                                    MaterialPageRoute(
                                        builder: (BuildContext context) =>
                                            const AddFirstScreen()),
                                    (route) => false);
                              },
                            ).paddingOnly(bottom: 6.h);
                          }
                        }

                        return Container();
                      },
                    );
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
