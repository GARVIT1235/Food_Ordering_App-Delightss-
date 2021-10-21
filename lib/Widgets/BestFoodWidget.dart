import 'package:Delightss/Models/best.dart';
import 'package:Delightss/Services/BestFood.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BestFoodWidget extends StatefulWidget {
  @override
  _BestFoodWidgetState createState() => _BestFoodWidgetState();
}

class _BestFoodWidgetState extends State<BestFoodWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 400,
      width: double.infinity,
      child: Column(
        children: <Widget>[
          BestFoodTitle(),
          Expanded(
            child: BestFoodList(),
          )
        ],
      ),
    );
  }
}

class BestFoodTitle extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 10, right: 10, top: 5, bottom: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text(
            "Best Foods",
            style: TextStyle(
                fontSize: 20,
                color: Color(0xFF3a3a3b),
                fontWeight: FontWeight.w300),
          ),
        ],
      ),
    );
  }
}

class BestFoodTiles extends StatelessWidget {
  String name;
  String imageUrl;
  String rating;
  String numberOfRating;
  String price;
  String IsVeg;

  BestFoodTiles(
      {Key key,
      @required this.name,
      @required this.imageUrl,
      @required this.rating,
      @required this.numberOfRating,
      @required this.price,
      @required this.IsVeg})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.only(left: 10, right: 5, top: 5, bottom: 5),
        decoration: BoxDecoration(boxShadow: [
          BoxShadow(
            color: Color(0xFFfae3e2),
            blurRadius: 15.0,
            offset: Offset(0, 0.75),
          ),
        ]),
        child: Stack(
          children: [
            Positioned.fill(
              child: Container(
                margin: EdgeInsets.all(5),
                decoration: BoxDecoration(
                  shape: BoxShape.rectangle,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Image.asset(
                  imageUrl,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Positioned(
                bottom: 0,
                child: Container(
                  color: Colors.transparent,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(name),
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
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text("Add Item :   "),
                          IconButton(onPressed: () {}, icon: Icon(Icons.add))
                        ],
                      ),
                    ],
                  ),
                ))
          ],
        ));
    // return InkWell(
    //   onTap: () {},
    //   child: Column(
    //     children: <Widget>[
    //       Container(
    //         padding: EdgeInsets.only(left: 10, right: 5, top: 5, bottom: 5),
    //         decoration: BoxDecoration(boxShadow: [
    //           /* BoxShadow(
    //             color: Color(0xFFfae3e2),
    //             blurRadius: 15.0,
    //             offset: Offset(0, 0.75),
    //           ),*/
    //         ]),
    //         child: Card(
    //           semanticContainer: true,
    //           clipBehavior: Clip.antiAliasWithSaveLayer,
    //           child: Image.asset(
    //             'assets/images/' + imageUrl + ".jpeg",
    //           ),
    //           shape: RoundedRectangleBorder(
    //             borderRadius: BorderRadius.circular(10.0),
    //           ),
    //           elevation: 1,
    //           margin: EdgeInsets.all(5),
    //         ),
    //       ),
    //     ],
    //   ),
    // );
  }
}

class BestFoodList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    BestService cats = Provider.of<BestService>(context, listen: false);
    List<BestCategory> bestfood = cats.getCategories();
    return ListView.builder(
      itemCount: bestfood.length,
      itemBuilder: (context, index) {
        return BestFoodTiles(
            name: bestfood[index].name,
            imageUrl: bestfood[index].imgPath,
            numberOfRating: bestfood[index].rating,
            price: bestfood[index].price,
            IsVeg: bestfood[index].isVeg);
      },
    );
  }
}