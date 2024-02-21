import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:korea_regexp/korea_regexp.dart';
import 'package:plant_plan/add/model/information_model.dart';
import 'package:plant_plan/add/provider/add_plant_provider.dart';
import 'package:plant_plan/add/view/add_directly_screen.dart';
import 'package:plant_plan/add/view/add_first_screen.dart';
import 'package:plant_plan/add/widget/search_widget.dart';
import 'package:plant_plan/common/layout/default_layout.dart';
import 'package:plant_plan/utils/colors.dart';

class SearchScreen extends ConsumerStatefulWidget {
  static String get routeName => 'addSearch';
  const SearchScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends ConsumerState<SearchScreen> {
  late Stream<QuerySnapshot> _streamInformationList;
  String enteredKeyword = "";
  bool hasSearchWords = false;
  bool hasSearchResults = false;

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

  void _updateSearchResults(List<InformationModel> informationList) {
    RegExp regExp = getRegExp(
      enteredKeyword,
      RegExpOptions(
        initialSearch: false,
        startsWith: false,
        endsWith: false,
        fuzzy: false,
        ignoreSpace: false,
        ignoreCase: false,
      ),
    );

    hasSearchResults =
        informationList.any((document) => regExp.hasMatch(document.name));
  }

  Widget buildCommonListTile(BuildContext context, InformationModel document) {
    return ListTile(
      contentPadding: const EdgeInsets.all(0),
      title: Text(
        document.name,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        style:
            Theme.of(context).textTheme.titleMedium!.copyWith(color: grayBlack),
      ),
      leading: Image.network(
        document.imageUrl,
        width: 40.w,
        height: 40.w,
        fit: BoxFit.cover,
        loadingBuilder: (BuildContext context, Widget child,
            ImageChunkEvent? loadingProgress) {
          if (loadingProgress == null) {
            // 이미지 로딩 완료
            return ClipRRect(
              borderRadius: BorderRadius.circular(16.w),
              child: child,
            );
          } else {
            // 이미지 로딩 중
            return Container(
              width: 40.w,
              height: 40.w,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16.w),
                color: grayColor200,
              ),
              child: const CircleAvatar(
                backgroundColor: grayColor200,
              ),
            );
          }
        },
        errorBuilder:
            (BuildContext context, Object error, StackTrace? stackTrace) {
          // 이미지 로딩 중 에러 발생 시
          return const Icon(Icons.error);
        },
      ),
      onTap: () {
        ref.read(addPlantProvider.notifier).updateInformation(document);
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
            builder: (BuildContext context) => const AddFirstScreen(),
          ),
          (route) => false,
        );
      },
    ).paddingOnly(bottom: 6.h);
  }

  Widget buildSearch() => SearchWidget(
        text: enteredKeyword,
        hintText: '식물 이름을 입력해주세요',
        onChanged: (value) {
          setState(() {
            enteredKeyword = value;
            hasSearchWords = enteredKeyword.isNotEmpty;
            hasSearchResults = false;
          });
        },
      );

  @override
  Widget build(BuildContext context) {
    return DefaultLayout(
      leading: IconButton(
        icon: Icon(
          Icons.arrow_back,
          size: 24.w, // 원하는 크기로 조절
        ),
        onPressed: () {
          // 뒤로가기 동작
          Navigator.of(context).pop();
        },
      ),
      title: '식물 추가',
      titleBackgroundColor: keyColor100,
      floatingActionButton: hasSearchWords && !hasSearchResults
          ? null
          : const AddDirectlyButton(isShadow: true),
      child: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.w),
          child: Column(
            children: <Widget>[
              SizedBox(height: 20.h),
              buildSearch(),
              SizedBox(height: 20.h),
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

                      if (hasSearchWords) {
                        _updateSearchResults(informationList);
                      }
                      if (hasSearchWords && !hasSearchResults) {
                        //검색어가있으나 결과가없는경우
                        return Center(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                '검색 결과가 없습니다',
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyMedium!
                                    .copyWith(color: grayColor600),
                              ),
                              SizedBox(height: 8.h),
                              const AddDirectlyButton(isShadow: true),
                            ],
                          ),
                        );
                      }

                      return ListView.builder(
                        itemCount: informationList.length,
                        itemBuilder: (context, index) {
                          InformationModel document = informationList[index];
                          if (hasSearchWords) {
                            //검색어가 있는경우 검색결과(hasSearchResults)여부 반환
                            RegExp regExp = getRegExp(
                              enteredKeyword,
                              RegExpOptions(
                                initialSearch: false,
                                startsWith: false,
                                endsWith: false,
                                fuzzy: false,
                                ignoreSpace: false,
                                ignoreCase: false,
                              ),
                            );
                            if (regExp.hasMatch(document.name)) {
                              hasSearchResults = true;
                            } else {
                              hasSearchResults = false;
                            }
                          }
                          if (!hasSearchWords) {
                            // 검색어가 없다면 전부 반환
                            return buildCommonListTile(
                                context, informationList[index]);
                          } else if (hasSearchResults) {
                            //검색결과가 있는 경우
                            return buildCommonListTile(
                                context, informationList[index]);
                          }

                          return const SizedBox.shrink();
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
      ),
    );
  }
}

class AddDirectlyButton extends StatelessWidget {
  final bool isShadow;

  const AddDirectlyButton({
    super.key,
    required this.isShadow,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: (() {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) {
              return const AddDirectlyScreen();
            },
          ),
        );
      }),
      style: ElevatedButton.styleFrom(
        minimumSize: Size.zero, // Set this
        padding: EdgeInsets.zero,
        elevation: isShadow ? 3 : 0,
        backgroundColor: pointColor2,
        shadowColor: isShadow ? grayBlack : null,
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: 16.0.w,
          vertical: 12.0.w,
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.add,
              color: Colors.white,
              size: 16.w,
            ),
            SizedBox(width: 4.w),
            Text(
              '직접 추가하기',
              style: Theme.of(context)
                  .textTheme
                  .titleMedium!
                  .copyWith(color: Colors.white),
            ),
          ],
        ),
      ),
    );
  }
}
