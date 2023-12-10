import 'package:flutter/material.dart';
import 'package:plant_plan/common/layout/default_layout.dart';
import 'package:plant_plan/my_page/model/announcement_model.dart';
import 'package:plant_plan/services/firebase_service.dart';
import 'package:plant_plan/utils/colors.dart';
import 'package:plant_plan/utils/date_formatter.dart';

class AnnouncementScreen extends StatefulWidget {
  const AnnouncementScreen({super.key});

  @override
  State<AnnouncementScreen> createState() => _AnnouncementScreenState();
}

class _AnnouncementScreenState extends State<AnnouncementScreen> {
  List<AnnouncementModel> announcements = [];
  @override
  void initState() {
    super.initState();
    fetchAnnouncements();
  }

  void addAnnouncement() async {
    FirebaseService firebaseService = FirebaseService();

    String originalBody = '''
    안녕하세요:)  
    식물관리앱 ‘식플'이 드디어 베타서비스를 오픈했습니다!

    이제 식플에서 내 식물을 등록하고, 상태에 맞는 알림을 설정하여  
    빼먹지 않고 내 식물을 관리하는 올바른 식집사 생활을 시작해보세요!

    많은 관심과 사랑 부탁드립니다🤓1
  ''';

    //마지막 줄바꿈 삭제
    String trimmedBody = originalBody.trimRight();

    AnnouncementModel announcement = AnnouncementModel(
      title: '식물관리앱 `식플` Beta Open!',
      date: DateTime.now(),
      isNew: true,
      body: trimmedBody,
    );

    try {
      // 공지사항 추가
      await firebaseService.addAnnouncement(announcement);
      print('공지사항 추가 성공');
    } catch (e) {
      print('공지사항 추가 실패: $e');
    }
  }

  void fetchAnnouncements() async {
    try {
      FirebaseService firebaseService = FirebaseService();
      List<AnnouncementModel> fetchedAnnouncements =
          await firebaseService.getAnnouncements();

      setState(() {
        announcements = fetchedAnnouncements;
      });
    } catch (e) {
      print('공지사항 패치 실패: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return DefaultLayout(
      title: '공지사항',
      child: SingleChildScrollView(
        child: ExpansionPanelList(
          elevation: 1,
          materialGapSize: 1,
          dividerColor: grayColor300,
          expansionCallback: (int index, bool isExpanded) {
            setState(() {
              announcements[index] =
                  announcements[index].copyWith(isExpanded: isExpanded);
            });
          },
          expandedHeaderPadding: EdgeInsets.zero,
          children: announcements
              .map<ExpansionPanel>((AnnouncementModel announcement) {
            return ExpansionPanel(
              headerBuilder: (BuildContext context, bool isExpanded) {
                return Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                  color: Colors.white,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(right: 8),
                                child: Text(
                                  announcement.isNew ? '[NEW]' : '',
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyMedium!
                                      .copyWith(
                                        color: pointColor2,
                                      ),
                                ),
                              ),
                              Text(
                                announcement.title,
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyMedium!
                                    .copyWith(
                                      color: grayBlack,
                                    ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 6,
                      ),
                      Text(
                        dateFormatter(announcement.date),
                        style: Theme.of(context).textTheme.bodySmall!.copyWith(
                              color: grayColor500,
                            ),
                      ),
                    ],
                  ),
                );
              },
              body: Container(
                decoration: const BoxDecoration(color: grayColor100),
                padding:
                    const EdgeInsets.symmetric(horizontal: 24, vertical: 30),
                child: Row(
                  children: [
                    Text(
                      announcement.body,
                      style: Theme.of(context).textTheme.bodySmall!.copyWith(
                            color: grayColor600,
                          ),
                    ),
                  ],
                ),
              ),
              isExpanded: announcement.isExpanded,
            );
          }).toList(),
        ),
      ),
    );
  }
}
