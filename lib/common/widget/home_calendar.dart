import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class MyCalendar extends StatefulWidget {
  const MyCalendar({Key? key}) : super(key: key);

  @override
  _MyCalendarState createState() => _MyCalendarState();
}

class _MyCalendarState extends State<MyCalendar> {
  late DateTime _selectedDate;
  late PageController _pageController;
  late int _currentPage;

  @override
  void initState() {
    super.initState();
    _selectedDate = DateTime.now();
    _currentPage = 500;
    _pageController =
        PageController(initialPage: _currentPage, viewportFraction: 0.165)
          ..addListener(() {
            setState(() {
              _currentPage = _pageController.page?.round() ?? 0;
              _selectedDate =
                  DateTime.now().add(Duration(days: _currentPage - 500));
            });
          });
  }

  Widget _buildDateContainer(DateTime date, bool isSelected) {
    final dayName = DateFormat.E().format(date);
    final dayNumber = DateFormat.d().format(date);
    const alarmCount = 3; // TODO: replace this with actual alarm count
    final dots = List<Widget>.generate(
      alarmCount,
      (_) => Container(
        margin: const EdgeInsets.only(left: 2),
        width: 4,
        height: 4,
        decoration: BoxDecoration(
          color: Colors.grey,
          borderRadius: BorderRadius.circular(2),
        ),
      ),
    );
    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      margin: const EdgeInsets.symmetric(horizontal: 4),
      width: isSelected ? 90 : 80,
      height: isSelected ? 100 : 80,
      decoration: BoxDecoration(
        color: isSelected ? Colors.grey.shade200 : null,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            dayName,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: isSelected ? Colors.grey.shade600 : null,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            dayNumber,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: isSelected ? Colors.black : null,
            ),
          ),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: dots,
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const SizedBox(height: 16),
        Text(
          DateFormat.yMMM().format(_selectedDate),
          textAlign: TextAlign.center,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 16),
        Expanded(
          child: PageView.builder(
            controller: _pageController,
            itemCount: 1000,
            itemBuilder: (BuildContext context, int index) {
              final now = DateTime.now().add(Duration(days: index - 500));
              final isFocused = index == 500;
              return _buildDateContainer(now, isFocused);
            },
          ),
        ),
      ],
    );
  }
}
