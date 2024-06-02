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
  late ScrollController _scrollController;
  final Set<InformationModel> _informationSet = {};
  DocumentSnapshot? _lastDocument;
  String enteredKeyword = "";
  bool hasSearchWords = false;
  bool hasSearchResults = false;
  final int _pageSize = 14;
  bool _loading = false;
  bool _hasMoreData = true;
  bool hasSearchedBefore = false;

  @override
  initState() {
    super.initState();
    _scrollController = ScrollController();
    _scrollController.addListener(_scrollListener);
    _loadNextPage();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _scrollListener() {
    if (_scrollController.position.pixels >=
            _scrollController.position.maxScrollExtent - 200 &&
        !_loading &&
        _hasMoreData) {
      _loadNextPage();
    }
  }

  Future<void> _loadNextPage() async {
    if (_loading) {
      return;
    }

    _loading = true;

    try {
      Query query = FirebaseFirestore.instance
          .collection('plant_list')
          .orderBy(FieldPath.documentId)
          .limit(_pageSize);

      if (_lastDocument != null) {
        query = query.startAfterDocument(_lastDocument!);
      }

      QuerySnapshot querySnapshot = await query.get();

      List<InformationModel> nextPage = querySnapshot.docs.map((doc) {
        return InformationModel.fromJson(doc.data() as Map<String, dynamic>);
      }).toList();

      if (nextPage.isEmpty || nextPage.length < _pageSize) {
        setState(() {
          _hasMoreData = false;
        });
      }

      setState(() {
        _informationSet.addAll(nextPage);
        _lastDocument =
            querySnapshot.docs.isNotEmpty ? querySnapshot.docs.last : null;
      });
    } catch (e) {
      setState(() {
        _hasMoreData =
            false; // 데이터를 가져오는 도중 오류가 발생했을 때 _hasMoreData를 false로 설정하여 더 이상 데이터를 불러오지 않음
      });
    } finally {
      _loading = false;
    }
  }

  Future<void> _loadAll() async {
    QuerySnapshot querySnapshot =
        await FirebaseFirestore.instance.collection('plant_list').get();

    List<InformationModel> allInformation = querySnapshot.docs
        .map((doc) =>
            InformationModel.fromJson(doc.data() as Map<String, dynamic>))
        .where((info) => info.name.contains(enteredKeyword))
        .toList();

    setState(() {
      _informationSet.addAll(allInformation);
      _hasMoreData = false;
    });
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
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (BuildContext context) => const AddFirstScreen(),
          ),
        );
      },
    ).paddingOnly(bottom: 6.h);
  }

  Widget buildSearch() => SearchWidget(
        text: enteredKeyword,
        hintText: '식물 이름을 입력해주세요',
        onChanged: (value) async {
          // 검색한 여부가 있다면 전부 로드한다.
          if (!hasSearchedBefore) {
            await _loadAll();
            setState(() {
              hasSearchedBefore = true;
            });
          }
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
          size: 24.w,
        ),
        onPressed: () {
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
                child: ListView.builder(
                  controller: _scrollController,
                  itemCount: _informationSet.length +
                      (_loading && _hasMoreData ? 1 : 0),
                  itemBuilder: (context, index) {
                    if (index < _informationSet.length) {
                      InformationModel document =
                          _informationSet.elementAt(index);
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
                            context, _informationSet.elementAt(index));
                      } else if (hasSearchResults) {
                        //검색결과가 있는 경우
                        return buildCommonListTile(
                            context, _informationSet.elementAt(index));
                      }

                      return const SizedBox.shrink();
                    } else {
                      if (_loading && _hasMoreData) {
                        return Padding(
                          padding: EdgeInsets.symmetric(vertical: 6.h),
                          child: const Center(
                            child: CircularProgressIndicator(),
                          ),
                        );
                      } else {
                        // 데이터를 가져오는 데 문제가 발생했음을 사용자에게 알림
                        return Padding(
                          padding: EdgeInsets.symmetric(vertical: 6.h),
                          child: const Center(
                            child: Text(
                              '데이터를 가져오는 데 문제가 발생했습니다.',
                              style: TextStyle(color: Colors.red),
                            ),
                          ),
                        );
                      }
                    }
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
