import 'package:flutter/material.dart';
import 'package:plant_plan/common/layout/default_layout.dart';
import 'package:plant_plan/my_page/model/notice_model.dart';
import 'package:plant_plan/utils/colors.dart';
import 'package:plant_plan/utils/date_formatter.dart';

class NoticeScreen extends StatefulWidget {
  const NoticeScreen({super.key});

  @override
  State<NoticeScreen> createState() => _NoticeScreenState();
}

class _NoticeScreenState extends State<NoticeScreen> {
  List<NoticeModel> data = generateNotice(5);
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
              data[index].isExpanded = isExpanded;
            });
          },
          expandedHeaderPadding: EdgeInsets.zero,
          children: data.map<ExpansionPanel>((NoticeModel notice) {
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
                                  notice.isNew ? '[NEW]' : '',
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyMedium!
                                      .copyWith(
                                        color: pointColor2,
                                      ),
                                ),
                              ),
                              Text(
                                notice.title,
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
                        dateFormatter(notice.date),
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
                      notice.body,
                      style: Theme.of(context).textTheme.bodySmall!.copyWith(
                            color: grayColor600,
                          ),
                    ),
                  ],
                ),
              ),
              isExpanded: notice.isExpanded,
            );
          }).toList(),
        ),
      ),
    );
  }
}

List<NoticeModel> generateNotice(int numberOfItems) {
  return List<NoticeModel>.generate(numberOfItems, (int index) {
    return NoticeModel(
      title: 'Panel $index',
      date: DateTime.now(),
      isNew: true,
      body: 'This is item number $index',
    );
  });
}
