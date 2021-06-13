import 'package:flutter/material.dart';
import 'package:flutter_widgets/grocerry_kit/home_page.dart';
import 'package:flutter_widgets/grocerry_kit/make_room.dart';
import 'package:mysql1/mysql1.dart';
import 'package:flutter/widgets.dart';
import '../category_detail.dart';
import '../model/product_model.dart';
import 'package:flutter_widgets/utils/cart_icons_icons.dart';

//https://medium.com/flutter-community/building-a-chat-app-with-flutter-and-firebase-from-scratch-9eaa7f41782e
// 여기 참고해서 DB랑 연결 시 코드 변경경

class HomeList extends StatelessWidget {
  final int id;
  HomeList({Key key, @required this.id}) : super(key:key);

  @override
  Widget build(BuildContext context) {
//    room_list();
    return Scaffold(
      body: Container(
        color: const Color(0xffF4F7FA),
        child: ListView(
          children: <Widget>[
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(left: 16, top: 4),
                  child: Text(
                    'All Categories',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
            _buildCategoryList(), // 리얼 카테고리 나열한 친구
            SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(left: 16, top: 4),
                  child: Text(
                    'All Boards',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Padding(
                  padding:EdgeInsets.only(right: 20),
                  child: FloatingActionButton(
                    backgroundColor: Colors.green,
                      child: Icon(
                        Icons.add,
                        color: Colors.white,
                        size: 33,
                    ),
                    onPressed: () {
                      print(id);
                      Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => makeRoomPage(id: id,))
                      );
                    }
                ),
                )
              ],
            ),
            _buildChatList(), // 리얼 아이템 나열한 친구
          ],
        ),
      ),
    );
  }

  Widget _buildCategoryList() {
    var items = CategoryList();
    return Container(
      height: 140,
      alignment: Alignment.centerLeft,
      child: ListView.builder(
        shrinkWrap: true,
        physics: ClampingScrollPhysics(),
        scrollDirection: Axis.horizontal,
        itemCount: items.length,
        itemBuilder: (context, index) {
          var data = items[index];
          return Column(children: <Widget>[
            Container(
              margin: EdgeInsets.all(10),
              width: 95,
              height: 95,
              alignment: Alignment.center,
              child: IconButton(
                icon: Icon(data.image),
                iconSize: 45,
                color: Colors.black38,
                onPressed: (){
                  print(index);
//                  Navigator.pushNamed(context, '/grocerry/category_detail', arguments: data);
                  Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => CategoryDetailPage(category_id: index))
                  );
                },
              ),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black12,
                    offset: Offset(0, 5),
                    blurRadius: 15,
                  )
                ],
              ),
            ),
            Text(data.name),
          ]);
        },
      ),
    );
  }

  final List<String> title_set = new List<String>();
  final List<int> count_set = new List<int>();
  final List<int> category_set = new List<int>();
  final List<int> roomId_set = new List<int>();
  int real_room_cnt = 0;

  Future room_list() async{
    final conn = await MySqlConnection.connect(ConnectionSettings(
        host: 'placeofmeeting.cjdnzbhmdp0z.us-east-1.rds.amazonaws.com',
        port: 3306,
        user: 'rootuser',
        db: 'placeofmeeting'  ,
        password: 'databaseproject'
    ));

    var room_info = await conn.query(
        'select category, title, count, room_id from rooms');
    title_set.clear();
    category_set.clear();
    count_set.clear();
    roomId_set.clear();
    real_room_cnt = room_info.length;
    for(var row in room_info){
      //print(row[0].toString() +" "+row[1]+" "+row[2].toString() + " "+ row[3].toString());
      category_set.add(row[0].toInt());
      title_set.add(row[1]);
      count_set.add(row[2].toInt());
      roomId_set.add(row[3]);
      //real_room_cnt++;
    }
    conn.close();
  }

  Widget _buildChatList() {
    //var items = ChatUsers();

    //room_list();
    print('real_count: ${real_room_cnt}');
    return Container(
      height: 290,
      alignment: Alignment.centerLeft,
      child: ListView.builder(
        shrinkWrap: true,
        physics: ClampingScrollPhysics(),
        scrollDirection: Axis.vertical,
        itemCount: real_room_cnt,//title_set.length, // 채팅방 수
        itemBuilder: (context, index) {
          //var data = items[index];
          // print("Hello builder");
          // print('room count:' + title_set.length.toString());
          return  ChatRoomList(
            title: title_set[index],
            category: category_set[index].toString(),// 일시적 조치 category
            count: count_set[index].toString(), // 카운트
            roomID: roomId_set[index],
          );
        },
      ),
    );
  }

  List<Product> CategoryList() {
    var list = List<Product>();

    list.add(new Product('Sports', Icons.sports_basketball_outlined));
    list.add(new Product('Game', Icons.videogame_asset_outlined));
    list.add(new Product('Music', Icons.music_video));
    list.add(new Product('Study', Icons.menu_book_outlined));
    list.add(new Product('Food', Icons.fastfood));
    list.add(new Product('Friends', Icons.wc));
    list.add(new Product('Etc', Icons.video_collection_outlined));
    // 이름, 이미지를 넣을 수 있다.

    return list;
  }

}

class ChatRoomList extends StatefulWidget{
  String title; // 방제목
  String category; // 방 설명
  String count; //Icon icon_name; // 아이콘이나 이미지
  int roomID;
  // String time;
  // bool isMessageRead;
  ChatRoomList({@required this.title,@required this.category,@required this.count, @required this.roomID/*,@required this.time,@required this.isMessageRead*/});
  @override
  _ChatRoomListState createState() => _ChatRoomListState();
}

class _ChatRoomListState extends State<ChatRoomList> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
      },
      child: Container(
        padding: EdgeInsets.only(left: 16,right: 16,top: 10,bottom: 10),
        child: Row(
          children: <Widget>[
            Expanded(
              child: Row(
                children: <Widget>[
                  CircleAvatar(
                    child: Text(widget.count),
                    maxRadius: 30,
                  ),
                  SizedBox(width: 16,),
                  Expanded(
                    child: Container(
                      color: Colors.transparent,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(widget.category, style: TextStyle(fontSize: 16),),
                          SizedBox(height: 6,),
                          Text(widget.title,style: TextStyle(fontSize: 13,color: Colors.grey.shade600, fontWeight: FontWeight.normal),),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/*
* version info = favorite button icon added (not DB)
*
* */