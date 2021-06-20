import 'package:flutter/material.dart';
import 'package:flutter_widgets/grocerry_kit/home_page.dart';
import 'package:mysql1/mysql1.dart';

import 'db_conn.dart';

class makeRoomPage extends StatefulWidget {
  final int id;

  makeRoomPage({Key key, @required this.id}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _makeRoomPage();
  }
}

// ignore: camel_case_types
class _makeRoomPage extends State<makeRoomPage> {
  @override
  Widget build(BuildContext context) {
    final titleController = TextEditingController();
    final contentController = TextEditingController();
    final dateController = TextEditingController();
    final numController = TextEditingController();

    int _category;
    DateTime _selectedTime;

    int uid;
    uid = widget.id;

    void changeCategory(int n) {
      _category = n;
    }

    Future check(int uid, int cate, TextEditingController title, TextEditingController content, dynamic date, TextEditingController num) async{
      final conn = await MySqlConnection.connect(Database.getConnection());

      print('dddddddd');
      print(title.text);
      print(content.text);
      print(date);
      print(num.text);
      print(cate);
      print(uid);

      var result = await conn.query(
            'insert into rooms values (?, ?, ?, ?, ?, ?, ?)',
            [uid, 0, cate, title.text, num.text, content.text, date]
      );

      for(var col in result){
        print(col);
      }

      conn.close();
    }

    return Scaffold(
      appBar: AppBar(
          backgroundColor: Colors.green,
          leading: IconButton(
            icon: Icon(Icons.arrow_back, color: Colors.black),
            onPressed: () {
              Navigator.pushNamed(context, '/grocerry/home');
            },
          ),
          centerTitle: true,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Icon(Icons.house, color: Colors.white),
              Padding(
                  padding: EdgeInsets.only(left: 10),
              ),
              Text(
                'Make a Room',
                style: TextStyle(color: Colors.white),
              ),
            ]
          )
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(top:20),
            ),
            Text(
              "Category",
              style: TextStyle(
                fontFamily: 'Raleway',
                package: 'awesome_package',
                color: Colors.green,
                fontSize: 25,
                fontWeight: FontWeight.bold,
              ),
            ),
            Container(
              height: 200,
              margin: EdgeInsets.all(20),
              padding: EdgeInsets.only(left: 20, right:20, top: 5, bottom:5),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.green),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.only(left: 25, right: 25, top:5, bottom:5),
                  ),
                  Row(
                      children: <Widget> [
                        Padding(
                            padding: EdgeInsets.only(left: 17, right: 5)
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget> [
                            IconButton(
                              icon: Icon(Icons.sports_soccer_rounded),
                              onPressed: (){
                                changeCategory(0);
                              },
                            ),
                            Text("스포츠"),
                          ],
                        ),
                        SizedBox(width: 25),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget> [
                            IconButton(
                              icon: Icon(Icons.videogame_asset),
                              onPressed: (){
                                changeCategory(1);
                              },
                            ),
                            Text("게임"),
                          ],
                        ),
                        SizedBox(width: 25),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget> [
                            IconButton(
                              icon: Icon(Icons.my_library_music),
                              onPressed: (){
                                changeCategory(2);
                              },
                            ),
                            Text("음악"),
                          ],
                        ),
                        SizedBox(width: 25),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget> [
                            IconButton(
                              icon: Icon(Icons.edit_rounded),
                              onPressed: (){
                                changeCategory(3);
                              },
                            ),
                            Text("스터디"),
                          ],
                        ),
                      ]
                  ),        Padding(
                    padding: EdgeInsets.only(top:10, bottom:10),
                  ),
                  Row(
                      children: <Widget> [
                        Padding(
                            padding: EdgeInsets.only(left: 17, right: 5)
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget> [
                            IconButton(
                              icon: Icon(Icons.food_bank_rounded),
                              onPressed: (){
                                changeCategory(4);
                              },
                            ),
                            Text("음식"),
                          ],
                        ),
                        SizedBox(width: 25),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget> [
                            IconButton(
                              icon: Icon(Icons.people_alt),
                              onPressed: (){
                                changeCategory(5);
                              },
                            ),
                            Text("친구"),
                          ],
                        ),
                        SizedBox(width: 25),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget> [
                            IconButton(
                              icon: Icon(Icons.menu_book_rounded),
                              onPressed: (){
                                changeCategory(6);
                              },
                            ),
                            Text("독서"),
                          ],
                        ),
                        SizedBox(width: 25),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget> [
                            IconButton(
                              icon: Icon(Icons.add_circle),
                              onPressed: (){
                                changeCategory(7);
                              },
                            ),
                            Text("기타"),
                          ],
                        ),
                      ]
                  ),
                ],
              ),
            ),
            Padding(
              padding:
              EdgeInsets.only(left: 16, right: 16, top: 8, bottom: 8),
              child: TextField(
                controller: titleController,
                keyboardType: TextInputType.text,
                style: TextStyle(fontSize: 17),
                decoration: InputDecoration(
                  hintText: '제 목',
                  isDense: true,
                  enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: BorderSide(color: Colors.green)),
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: BorderSide(color: Colors.green)),
                ),
              ),
            ),
            Padding(
              padding:
              EdgeInsets.only(left: 16, right: 16, top: 8, bottom: 8),
              child: TextField(
                controller: contentController,
                keyboardType: TextInputType.text,
                style: TextStyle(fontSize: 17),
                decoration: InputDecoration(
                  hintText: '내 용',
                  enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: BorderSide(color: Colors.green)),
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: BorderSide(color: Colors.green)),
                  contentPadding: EdgeInsets.symmetric(vertical: 60.0, horizontal: 10),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top:5),
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget> [
                Container(
                  margin: EdgeInsets.only(left: 20, right: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget> [
                      Text(
                          "모집 기간 ",
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                          )
                      ),
                      SizedBox(width: 15),
                      // ignore: deprecated_member_use
                      RaisedButton(
                        color: Colors.green,
                        child: Text(
                            'Pick a Date',
                            style: TextStyle(fontSize: 14, color: Colors.white),
                        ),
                        onPressed: () async {
                          Future<DateTime> selectedDate = showDatePicker(
                            context: context,
                            initialDate: DateTime.now(),
                            firstDate: DateTime(2021),
                            lastDate: DateTime(2022),
                            builder: (BuildContext context, Widget child) {
                              return Theme(
                                data: ThemeData.dark(), // 다크테마
                                child: child,
                              );
                            },
                          );
                          _selectedTime = await selectedDate;
                          print(_selectedTime);
                        }
                      ),
                    ],
                  ),
                )
              ],
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget> [
                Container(
                  margin: EdgeInsets.only(left: 20, right: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget> [
                      Text(
                          "모집 인원 ",
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                          )
                      ),
                      SizedBox(
                          width: 270,
                          child: TextField(
                            controller: numController,
                            decoration: InputDecoration(
                              border: UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.green),
                              ),
                              focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.green),
                              ),
                              contentPadding: EdgeInsets.only(left: 10),
                            ),
                          )
                      )
                    ],
                  ),
                )
              ],
            ),
            Padding(
              padding: EdgeInsets.only(top:10),
            ),
            // ignore: deprecated_member_use
            RaisedButton(
              padding: EdgeInsets.only(left: 150, right:150),
              child: Text(
                "방 생성",
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.white,
                ),
              ),
              color: Colors.green,
              onPressed: () async{
                var result = await check(uid ,_category, titleController, contentController, _selectedTime.toUtc(), numController);
                Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => HomePage(id: uid))
                );
              }, // 버튼 클릭 시 이벤트
            )
          ],
        )
      )
    );
  }

}
