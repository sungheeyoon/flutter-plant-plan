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
  final List<Map<String, dynamic>> _allUsers = [
    {"id": 1, "name": "Andy", "age": 29},
    {"id": 2, "name": "Aragon", "age": 40},
    {"id": 3, "name": "Bob", "age": 5},
    {"id": 4, "name": "Barbara", "age": 35},
    {"id": 5, "name": "Candy", "age": 21},
    {"id": 6, "name": "Colin", "age": 55},
    {"id": 7, "name": "Audra", "age": 30},
    {"id": 8, "name": "가나다라", "age": 14},
    {"id": 9, "name": "하늘", "age": 100},
    {"id": 10, "name": "한글", "age": 32},
  ];

  List<Map<String, dynamic>> _foundUsers = [];
  @override
  initState() {
    _foundUsers = _allUsers;
    super.initState();
  }

  void _runFilter(String enteredKeyword) {
    List<Map<String, dynamic>> results = [];

    if (enteredKeyword.isEmpty) {
      // if the search field is empty or only contains white-space, we'll display all users
      results = _allUsers;
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
      results = _allUsers
          .where((user) => regExp.hasMatch(user["name"] as String))
          .toList();
      //     user["name"].toLowerCase().contains(enteredKeyword.toLowerCase()))
      // .toList();
      // we use the toLowerCase() method to make it case-insensitive
    }
    setState(() {
      _foundUsers = results;
    });
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
                    onChanged: (value) => _runFilter(value),
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
              child: _foundUsers.isNotEmpty
                  ? ListView.builder(
                      itemCount: _foundUsers.length,
                      itemBuilder: (context, index) => Card(
                        key: ValueKey(_foundUsers[index]["id"]),
                        color: Colors.blue,
                        elevation: 4,
                        margin: const EdgeInsets.symmetric(vertical: 10),
                        child: ListTile(
                          leading: Text(
                            _foundUsers[index]["id"].toString(),
                            style: const TextStyle(
                                fontSize: 24, color: Colors.white),
                          ),
                          title: Text(_foundUsers[index]['name'],
                              style: const TextStyle(color: Colors.white)),
                          subtitle: Text(
                              '${_foundUsers[index]["age"].toString()} years old',
                              style: const TextStyle(color: Colors.white)),
                        ),
                      ),
                    )
                  : const Text(
                      'No results found',
                      style: TextStyle(fontSize: 24),
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
