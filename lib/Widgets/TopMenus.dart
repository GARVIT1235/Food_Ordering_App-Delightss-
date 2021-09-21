import 'package:flutter/material.dart';

class TopMenus extends StatefulWidget {
  @override
  _TopMenusState createState() => _TopMenusState();
}

class _TopMenusState extends State<TopMenus> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: <Widget>[
          TopMenuTiles(name: "Burger", imageUrl: "ic_burger", slug: ""),
          TopMenuTiles(name: "Sushi", imageUrl: "ic_burger", slug: ""),
          TopMenuTiles(name: "Pizza", imageUrl: "ic_burger", slug: ""),
          TopMenuTiles(name: "Cake", imageUrl: "ic_burger", slug: ""),
          TopMenuTiles(name: "Ice Cream", imageUrl: "ic_burger", slug: ""),
          TopMenuTiles(name: "Soft Drink", imageUrl: "ic_burger", slug: ""),
          TopMenuTiles(name: "Burger", imageUrl: "ic_burger", slug: ""),
          TopMenuTiles(name: "Sushi", imageUrl: "ic_burger", slug: ""),
        ],
      ),
    );
  }
}

class TopMenuTiles extends StatelessWidget {
  String name;
  String imageUrl;
  String slug;

  TopMenuTiles(
      {Key key,
      @required this.name,
      @required this.imageUrl,
      @required this.slug})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {},
      child: Column(
        children: <Widget>[
          Container(
            padding: EdgeInsets.only(left: 10, right: 5, top: 5, bottom: 5),
            child: Card(
                color: Colors.white,
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: const BorderRadius.all(
                    Radius.circular(3.0),
                  ),
                ),
                child: Container(
                  width: 50,
                  height: 50,
                  child: Center(
                      child: Image.asset(
                    'assets/images/' + imageUrl + ".png",
                    width: 24,
                    height: 24,
                  )),
                )),
          ),
          Text(name,
              style: TextStyle(
                  color: Color(0xFF6e6e71),
                  fontSize: 14,
                  fontWeight: FontWeight.w400)),
        ],
      ),
    );
  }
}
