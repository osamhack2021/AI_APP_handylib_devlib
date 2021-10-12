import 'package:app/constants/colors.dart';
import 'package:app/hooks/use_api.dart';
import 'package:app/models/book_models.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:app/components/homeScreen/content_scroll.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SearchModalBottomSheet extends StatefulWidget {
  SearchModalBottomSheet({Key? key}) : super(key: key);

  @override
  _SearchModalBottomSheetState createState() => _SearchModalBottomSheetState();
}

class _SearchModalBottomSheetState extends State<SearchModalBottomSheet> {
  final FocusNode _focusNode = FocusNode();
  TextEditingController inputController = TextEditingController();
  bool isSubmitted = false;
  Future<List<Book>>? data;
  List<String> _searchHistory = [];

  Future<List<Book>> fetchQuery(String query) async {
    List<Book> books = [];
    List<dynamic> res;
    res = (await searchAladinApiGet(query, 1))["item"];
    for (var item in res) {
      item["description"] = item["description"]
          .replaceAllMapped(RegExp('(&lt;)|(&gt;)|(<.+?\/>)'), (Match m) => "");
      books.add(Book.fromJson(item));
    }
    return books;
  }

  void fetchSearchHistory() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _searchHistory = (prefs.getStringList("searchHistory") ?? []);
    });
  }

  @override
  void initState() {
    super.initState();
    fetchSearchHistory();
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  void _handleSubmit(String text) async {
    setState(() {
      isSubmitted = true;
    });
    data = fetchQuery(text);
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (_searchHistory.length == 10) {
      _searchHistory = _searchHistory.sublist(0, 9);
    }
    _searchHistory.insert(0, text);
    // searchLog.add(text);
    prefs.setStringList('searchHistory', _searchHistory);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
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
              sep(20),
              const Divider(
                height: 10,
                endIndent: 10,
                indent: 10,
                color: Colors.black12,
                thickness: 3,
              ),
              Stack(
                children: [
                  Visibility(
                    child: searchLogWidget(),
                    visible: !isSubmitted,
                  ),
                  SingleChildScrollView(
                    controller: ModalScrollController.of(context),
                    child: Visibility(
                      child: Container(
                          width: double.infinity,
                          height: 420,
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          child: FutureBuilder<List<Book>>(
                            future: data,
                            builder: (context, snapshot) {
                              if (snapshot.hasData) {
                                return ContentScroll(
                                  snapshot.data!,
                                  '\"${inputController.text}\" 의 검색결과',
                                  350.0,
                                  200.0,
                                );
                              } else if (snapshot.hasError) {
                                throw snapshot.error!;
                              }
                              // 기본적으로 로딩 Spinner를 보여줍니다.
                              return const Center(
                                  child: CircularProgressIndicator());
                            },
                          )),
                      visible: isSubmitted,
                    ),
                  ),
                ],
              ),
              const Divider(
                height: 10,
                endIndent: 10,
                indent: 10,
                color: Colors.black12,
                thickness: 3,
              ),
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
          _searchHistory.isEmpty
              ? const Center(
                  child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 30),
                  child: Text("최근 검색기록이 없습니다.",
                      style:
                          const TextStyle(fontSize: 14, color: Colors.black54)),
                ))
              : Wrap(
                  spacing: 5,
                  runSpacing: -10.0,
                  alignment: WrapAlignment.start,
                  children: _searchHistory
                      .map((node) => Container(
                          margin: const EdgeInsets.all(5),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(100.0),
                            child: ElevatedButton(
                              style: ButtonStyle(
                                  elevation: MaterialStateProperty.all(0),
                                  backgroundColor: MaterialStateProperty.all(
                                      Colors.black12)),
                              onPressed: () {
                                inputController.text = node;
                                FocusScope.of(context).unfocus();
                                _handleSubmit(inputController.text);
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
            onSubmitted: (text) => _handleSubmit(text),
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
