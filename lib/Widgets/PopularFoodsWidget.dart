import 'package:Delightss/Models/Popular.dart';
import 'package:Delightss/Services/PopularFood.dart';
import 'package:Delightss/Services/catcartService.dart';
import 'package:Delightss/Widgets/unititem.dart';
import 'package:Delightss/style/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PopularFoodsWidget extends StatefulWidget {
  @override
  _PopularFoodsWidgetState createState() => _PopularFoodsWidgetState();
}

class _PopularFoodsWidgetState extends State<PopularFoodsWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 320,
      width: double.infinity,
      child: Column(
        children: <Widget>[
          PopularFoodTitle(),
          Expanded(
            child: PopularFoodItems(),
          )
        ],
      ),
    );
  }
}

class PopularFoodTiles extends StatelessWidget {
  String name;
  String imageUrl;
  String rating;
  String numberOfRating;
  String price;
  String IsVeg;

  PopularFoodTiles({
    Key key,
    @required this.name,
    @required this.imageUrl,
    @required this.rating,
    @required this.numberOfRating,
    @required this.price,
    @required this.IsVeg,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    CategorySelectionService catSelection =
        Provider.of<CategorySelectionService>(context);
    return Column(
      children: <Widget>[
        Container(
          padding: EdgeInsets.only(left: 10, right: 5, top: 5, bottom: 5),
          decoration: BoxDecoration(boxShadow: []),
          child: Card(
              color: AppColors.white,
              elevation: 0,
              shape: RoundedRectangleBorder(
                borderRadius: const BorderRadius.all(
                  Radius.circular(5.0),
                ),
              ),
              child: Container(
                width: 170,
                height: 300,
                child: Column(
                  children: [
                    Stack(
                      children: [
                        Align(
                          alignment: Alignment.topRight,
                          child: Container(
                            alignment: Alignment.topRight,
                            width: double.infinity,
                            padding: EdgeInsets.only(right: 5, top: 5),
                            child: Container(
                              height: 28,
                              width: 28,
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Colors.white70,
                                  boxShadow: [
                                    BoxShadow(
                                      color: Color(0xFFfae3e2),
                                      blurRadius: 25.0,
                                      offset: Offset(0.0, 0.75),
                                    ),
                                  ]),
                            ),
                          ),
                        ),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Center(
                              child: Image.network(
                            imageUrl,
                            width: 130,
                            height: 140,
                          )),
                        )
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          alignment: Alignment.bottomLeft,
                          padding: EdgeInsets.only(left: 5, top: 5),
                          child: Text(name,
                              style: TextStyle(
                                  color: Color(0xFF6e6e71),
                                  fontSize: 15,
                                  fontWeight: FontWeight.w500)),
                        ),
                        Container(
                          alignment: Alignment.topRight,
                          padding: EdgeInsets.only(right: 15),
                          child: Container(
                            height: 28,
                            width: 28,
                            child: Center(
                              child: IconButton(
                                icon: Icon(
                                  Icons.add,
                                  color: Colors.black,
                                  size: 26,
                                ),
                                onPressed: () {
                                  catSelection.selectedCategory;
                                },
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    UnitPriceWidget(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            Container(
                              alignment: Alignment.topLeft,
                              padding: EdgeInsets.only(left: 5, top: 5),
                              child: Text(rating,
                                  style: TextStyle(
                                      color: Color(0xFF6e6e71),
                                      fontSize: 10,
                                      fontWeight: FontWeight.w400)),
                            ),
                            Container(
                              padding: EdgeInsets.only(top: 3, left: 5),
                              child: Row(
                                children: <Widget>[
                                  Icon(
                                    Icons.star,
                                    size: 10,
                                    color: Color(0xFFfb3132),
                                  ),
                                  Icon(
                                    Icons.star,
                                    size: 10,
                                    color: Color(0xFFfb3132),
                                  ),
                                  Icon(
                                    Icons.star,
                                    size: 10,
                                    color: Color(0xFFfb3132),
                                  ),
                                  Icon(
                                    Icons.star,
                                    size: 10,
                                    color: Color(0xFFfb3132),
                                  ),
                                  Icon(
                                    Icons.star,
                                    size: 10,
                                    color: Color(0xFF9b9b9c),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              alignment: Alignment.topLeft,
                              padding: EdgeInsets.only(left: 5, top: 5),
                              child: Text("($numberOfRating)",
                                  style: TextStyle(
                                      color: Color(0xFF6e6e71),
                                      fontSize: 10,
                                      fontWeight: FontWeight.w400)),
                            ),
                          ],
                        ),
                        Container(
                          alignment: Alignment.bottomLeft,
                          padding: EdgeInsets.only(left: 5, top: 5, right: 5),
                          child: Text('Rs ' + price,
                              style: TextStyle(
                                  color: Color(0xFF6e6e71),
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600)),
                        )
                      ],
                    ),
                  ],
                ),
              )),
        ),
      ],
    );
  }
}

class PopularFoodTitle extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 10, right: 10, top: 5, bottom: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text(
            "Popluar Foods",
            style: TextStyle(
                fontSize: 20,
                color: Color(0xFF3a3a3b),
                fontWeight: FontWeight.w300),
          ),
          Text(
            "See all",
            style: TextStyle(
                fontSize: 16, color: Colors.blue, fontWeight: FontWeight.w100),
          )
        ],
      ),
    );
  }
}

class PopularFoodItems extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    PopularService cats = Provider.of<PopularService>(context, listen: false);
    List<PopularCategory> popularfood = cats.getCategories();
    return ListView.builder(
      itemCount: popularfood.length,
      scrollDirection: Axis.horizontal,
      itemBuilder: (context, index) {
        return PopularFoodTiles(
            name: popularfood[index].name,
            imageUrl: popularfood[index].imgPath,
            numberOfRating: popularfood[index].rating,
            price: popularfood[index].price,
            IsVeg: popularfood[index].isVeg);
      },
    );
  }
}
