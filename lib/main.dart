import 'package:alphabet_list_scroll_view/alphabet_list_scroll_view.dart';
import 'package:demo_screen/country_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(new CupertinoApp(
    debugShowCheckedModeBanner: false,
    home: CustomListView(),
  ));
}

class CustomListView extends StatefulWidget {
  @override
  _CustomListViewState createState() => _CustomListViewState();
}

class _CustomListViewState extends State<CustomListView> {
  List<CountryModel> userList = [];
  List<String> strList = [];
  List<Widget> normalList = [];
  TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    userList.addAll(CountryModel.getCountries());
    userList
        .sort((a, b) => a.name.toLowerCase().compareTo(b.name.toLowerCase()));
    filterList();
    searchController.addListener(() {
      filterList();
    });
    super.initState();
  }

  filterList() {
    List<CountryModel> users = [];
    users.addAll(userList);
    normalList = [];
    strList = [];
    if (searchController.text.isNotEmpty) {
      users.retainWhere((user) => user.name
          .toLowerCase()
          .contains(searchController.text.toLowerCase()));
    }
    users.forEach((user) {
      normalList.add(
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Padding(
            padding: const EdgeInsets.only(right: 50.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Container(
                  width: 250.0,
                  child: Text(
                    user.name,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 20.0,
                      color: CupertinoColors.black,
                    ),
                  ),
                ),
                Text(
                  user.dialCode,
                  style: TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                    color: CupertinoColors.black,
                  ),
                ),
              ],
            ),
          ),
        ),
      );
      strList.add(user.name);
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        border: Border.all(
          style: BorderStyle.none,
        ),
        backgroundColor: CupertinoColors.white,
        actionsForegroundColor: CupertinoColors.black,
        leading: Icon(IconData(62418,
            fontFamily: CupertinoIcons.iconFont,
            fontPackage: CupertinoIcons.iconFontPackage,
            matchTextDirection: false)),
      ),
      child: Stack(
        children: <Widget>[
          Positioned(
            top: 10.0,
            left: 0.0,
            right: 0.0,
            child: Container(
              width: double.infinity,
              height: MediaQuery.of(context).size.height -
                  (MediaQuery.of(context).size.height / 1.8) -
                  120.0,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.max,
                  children: <Widget>[
                    Text(
                      "Countries",
                      style: TextStyle(
                        fontSize: 40.0,
                        color: CupertinoColors.black,
                      ),
                    ),
                    Divider(
                      thickness: 3.0,
                      color: CupertinoColors.black,
                    ),
                  ],
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 100.0),
            child: Container(
              width: double.infinity,
              child: AlphabetListScrollView(
                strList: strList,
                highlightTextStyle: TextStyle(
                  color: CupertinoColors.activeBlue,
                ),
                showPreview: true,
                itemBuilder: (context, index) {
                  return Column(
                    children: <Widget>[
                      Container(
                        child: normalList[index],
                      ),
                      SizedBox(
                        height: 20.0,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20.0),
                        child: Divider(
                          thickness: 1.0,
                        ),
                      ),
                    ],
                  );
                },
                indexedHeight: (i) {
                  return 70;
                },
                keyboardUsage: true,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
