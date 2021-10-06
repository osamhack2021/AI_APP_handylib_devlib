import 'package:app/constants/colors.dart';
import 'package:flutter/material.dart';

class SearchModalBottomSheet extends StatefulWidget {
  SearchModalBottomSheet({Key? key}) : super(key: key);

  @override
  _SearchModalBottomSheetState createState() => _SearchModalBottomSheetState();
}

class _SearchModalBottomSheetState extends State<SearchModalBottomSheet> {
  final FocusNode _focusNode = FocusNode();
  TextEditingController inputController = TextEditingController();

  List<String> searchLog = [
    "정유정",
    "베르나르 베르베르",
    "성공하는법",
    "C언어",
    "해커톤",
    "오픈소스",
    "github",
    "우승"
  ];

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: Padding(
          padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 0),
          child: Column(
            children: [
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 20),
                width: double.infinity,
                child: const Text(
                  "검색",
                  textAlign: TextAlign.left,
                  style: TextStyle(
                      fontSize: 28,
                      color: Colors.black87,
                      fontWeight: FontWeight.bold),
                ),
              ),
              sep(20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: searchBar(),
              ),
              sep(30),
              searchLogWidget(),
            ],
          ),
        ));
  }

  Container searchLogWidget() {
    return Container(
      child: Column(
        children: [
          subtitle("최근 검색 기록"),
          sep(10),
          Wrap(
              spacing: 5,
              runSpacing: -10.0,
              alignment: WrapAlignment.start,
              children: searchLog
                  .map((node) => Container(
                      margin: const EdgeInsets.all(5),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(100.0),
                        child: ElevatedButton(
                          style: ButtonStyle(
                              elevation: MaterialStateProperty.all(0),
                              backgroundColor:
                                  MaterialStateProperty.all(Colors.black12)),
                          onPressed: () {
                            inputController.text = node;
                            FocusScope.of(context).unfocus();
                          },
                          child: Text(node,
                              style: const TextStyle(
                                  fontSize: 14, color: Colors.black87)),
                        ),
                      )))
                  .toList()),
        ],
      ),
    );
  }

  Container subtitle(String text) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      width: double.infinity,
      child: Text(
        text,
        style: const TextStyle(
            fontSize: 16, color: Colors.black54, fontWeight: FontWeight.w500),
      ),
    );
  }

  SizedBox sep(double _height) {
    return SizedBox(height: _height, width: double.infinity);
  }

  ClipRRect searchBar() {
    return ClipRRect(
        borderRadius: BorderRadius.circular(15.0),
        child: Container(
          width: double.infinity,
          height: 50,
          decoration: const BoxDecoration(color: Colors.black12),
          child: TextField(
            controller: inputController,
            autofocus: true,
            keyboardType: TextInputType.text,
            onChanged: (text) {
              // _streamSearch.add(text);
            },
            decoration: const InputDecoration(
                hintText: "검색어를 입력해주세요",
                hintStyle: TextStyle(color: Colors.black38),
                border: InputBorder.none,
                icon: Padding(
                    padding: EdgeInsets.only(left: 13),
                    child: Icon(
                      Icons.search,
                      color: Color(COLOR_PRIMARY),
                    ))),
          ),
        ));
  }
}
