import 'package:Delightss/style/app_colors.dart';
import 'package:flutter/material.dart';

class SearchWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 50,
        ),
        Padding(
          padding: EdgeInsets.only(left: 10, top: 5, right: 10, bottom: 5),
          child: TextField(
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(5.0)),
                borderSide: BorderSide(
                  width: 0,
                  color: Color(0xFFfb3132),
                  style: BorderStyle.none,
                ),
              ),
              filled: true,
              prefixIcon: Icon(
                Icons.search,
                color: Color(0xFFfb3132),
              ),
              fillColor: Color(0xFFFAFAFA),
              hintStyle: new TextStyle(color: Color(0xFFd0cece), fontSize: 18),
              hintText: "Search............",
            ),
          ),
        ),
        SizedBox(height: 5),
        SingleChildScrollView(
          padding: EdgeInsets.only(left: 10, top: 5, right: 10, bottom: 5),
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(width: 2, color: AppColors.white)),
                  child: TextButton(
                      onPressed: () {},
                      child: Text(
                        'Veg',
                        style: TextStyle(color: Colors.black),
                      ))),
              SizedBox(
                width: 10,
              ),
              Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(width: 2, color: AppColors.white)),
                  child: TextButton(
                      onPressed: () {},
                      child: Text(
                        'Non Veg',
                        style: TextStyle(color: Colors.black),
                      ))),
              SizedBox(
                width: 10,
              ),
              Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(width: 2, color: AppColors.white)),
                  child: TextButton(
                      onPressed: () {},
                      child: Text(
                        '4 star',
                        style: TextStyle(color: Colors.black),
                      ))),
              SizedBox(
                width: 10,
              ),
              Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(width: 2, color: AppColors.white)),
                  child: TextButton(
                      onPressed: () {},
                      child: Text(
                        '5 star',
                        style: TextStyle(color: Colors.black),
                      ))),
              SizedBox(
                width: 10,
              ),
              Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(width: 2, color: AppColors.white)),
                  child: TextButton(
                      onPressed: () {},
                      child: Text(
                        'Popular Food',
                        style: TextStyle(color: Colors.black),
                      ))),
              SizedBox(
                width: 10,
              ),
            ],
          ),
        )
      ],
    );
  }
}
