import 'package:app/components/error_notifier.dart';
import 'package:app/components/loading_dialog.dart';
import 'package:app/components/login_page/rounded_button.dart';
import 'package:app/controller/user_controller.dart';
import 'package:app/hooks/use_api.dart';
import 'package:app/models/book_models.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

User? myUser;

class OnboardScreen extends StatefulWidget {
  OnboardScreen({Key? key}) : super(key: key);

  @override
  _OnboardScreenState createState() => _OnboardScreenState();
}

class _OnboardScreenState extends State<OnboardScreen> {
  String myUri = 'https://www.projectlib.tk/';
  List<String> likedIsbnList = [];
  Future<List<Book>>? bookData;

  void warp() async {
    myShowDialog(context, "로딩중입니다..");
    if (likedIsbnList.isNotEmpty) {
      for (int i = 0; i < likedIsbnList.length; i++) {
        like(likedIsbnList[i]);
      }
    }
    Navigator.of(context).pushNamedAndRemoveUntil(
      '/home',
      (route) => false,
      arguments: User(myUser!.username, myUser!.userId, myUser!.password,
          myUser!.email, myUser!.unit, myUser!.rank),
    );
  }

  void handleClick() {}
  void like(String isbn) async {
    await http.post(
      Uri.parse(myUri + 'like/?user_id=${myUser!.userId}&isbn=${isbn}/'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );
  }

  Future<List<Book>> fetchBooks() async {
    List<Book> tmp = [];
    for (int i = 0; i < firstIsbnList.length; i++) {
      tmp.add(
          Book.fromJson(await feedAladinApiGet(firstIsbnList[i].toString())));
    }
    ;
    return tmp;
  }

  @override
  void initState() {
    super.initState();
    bookData = fetchBooks();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    myUser = ModalRoute.of(context)!.settings.arguments as User?;
    if (myUser == null) {
      return const Scaffold(
        body: ErrorNotifier(
          errorMessage: '유저 정보를 불러오지 못했어요. 앱을 다시 실행해주세요.',
        ),
      );
    }

    return Scaffold(
        body: Column(children: [
      FutureBuilder<List<Book>>(
          future: bookData,
          builder: (BuildContext context, bookList) {
            if (bookList.hasData) {
              return CustomScrollView(
                primary: false,
                slivers: <Widget>[
                  SliverPadding(
                    padding: const EdgeInsets.all(0),
                    sliver: SliverGrid.count(
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 10,
                      crossAxisCount: 1,
                      childAspectRatio: 0.7,
                      children: <Widget>[
                        for (var _curBook in bookList.data!)
                          Center(
                            child: Card(
                                margin: const EdgeInsets.symmetric(
                                    horizontal: 5.0, vertical: 20.0),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                elevation: 5,
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 10, horizontal: 15),
                                  child: SizedBox(
                                    width: double.infinity,
                                    child: Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        mainAxisSize: MainAxisSize.max,
                                        children: [
                                          ClipRRect(
                                            borderRadius:
                                                const BorderRadius.all(
                                                    Radius.circular(10)),
                                            child: Image(
                                              image: NetworkImage(
                                                  _curBook.coverUrl),
                                              width: (size.width - 60) / 2,
                                              fit: BoxFit.fitWidth,
                                            ),
                                          ),
                                          SizedBox(
                                              width: 110,
                                              child: SingleChildScrollView(
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    Text(_curBook.title,
                                                        style: const TextStyle(
                                                            fontSize: 14.0,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            color: Colors
                                                                .black87)),
                                                    const Divider(
                                                      height: 30,
                                                      endIndent: 10,
                                                      indent: 10,
                                                      color: Colors.black12,
                                                      thickness: 3,
                                                    ),
                                                    Text("지은이: " +
                                                        _curBook.author),
                                                    const Divider(
                                                      height: 30,
                                                      endIndent: 10,
                                                      indent: 10,
                                                      color: Colors.black12,
                                                      thickness: 3,
                                                    ),
                                                    Text(_curBook.category),
                                                  ],
                                                ),
                                              ))
                                        ]),
                                  ),
                                )),
                          )
                      ],
                    ),
                  ),
                ],
              );
            } else if (bookList.hasError) {
              return ErrorNotifier(
                errorMessage: '리스트를 불러오는 데 문제가 생겼어요. 잠시 후 다시 시도해주세요.',
              );
            } else {
              return Column(children: const [
                SizedBox(
                  child: CircularProgressIndicator(),
                  width: 60,
                  height: 60,
                ),
                Padding(
                  padding: EdgeInsets.only(top: 16),
                  child: Text('로딩 중입니다...'),
                )
              ]);
            }
          }),
      RoundedButton(
        text: "완료",
        press: warp,
      ),
    ]));
  }
}
