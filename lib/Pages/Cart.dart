import 'package:Delightss/Models/Popular.dart';
import 'package:Delightss/Models/cartmodel.dart';
import 'package:Delightss/Services/Login.dart';
import 'package:Delightss/Services/cartService.dart';
import 'package:Delightss/Widgets/Drawer.dart';
import 'package:Delightss/style/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CartPage extends StatefulWidget {
  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  @override
  Widget build(BuildContext context) {
    CartService cartService = Provider.of<CartService>(context, listen: false);
    LoginService loginService =
        Provider.of<LoginService>(context, listen: false);
    String imgPath = loginService.loggedInUserModel != null
        ? loginService.loggedInUserModel.photoUrl
        : '';
    return Scaffold(
      drawer: Drawer(child: SideBar()),
      appBar: AppBar(
        title: Text(
          'Cart',
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
        actions: [
          loginService.isUserLoggedIn()
              ? Container(
                  margin: EdgeInsets.only(right: 10),
                  padding: EdgeInsets.all(10),
                  child: ClipOval(child: Image.network(imgPath)))
              : Container()
        ],
      ),
      body: Container(
          padding: EdgeInsets.all(20),
          child: Column(children: [
            Row(
              children: [
                Icon(
                  Icons.shopping_cart,
                  color: AppColors.main_color,
                ),
                SizedBox(width: 10),
                Expanded(
                  child: Text('Ordering List',
                      style: TextStyle(
                          color: Colors.grey,
                          fontSize: 25,
                          fontWeight: FontWeight.bold)),
                ),
                Consumer<CartService>(builder: (context, cart, child) {
                  if (cart.items.length > 0) {
                    return ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: Material(
                        child: InkWell(
                          onTap: () {
                            cartService.removeAll(context);
                          },
                          child: Container(
                              padding: EdgeInsets.only(
                                  top: 3, bottom: 3, left: 15, right: 15),
                              child: Row(
                                children: [
                                  Icon(Icons.delete,
                                      size: 20,
                                      color: AppColors.secondary_color),
                                  SizedBox(width: 5),
                                  Text('Delete All',
                                      style: TextStyle(
                                          color: AppColors.white,
                                          fontSize: 12)),
                                ],
                              ),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  color: AppColors.secondary_color
                                      .withOpacity(0.2))),
                        ),
                      ),
                    );
                  }

                  // return empty container
                  return Container();
                })
              ],
            ),
            Expanded(child: Consumer<CartService>(
              builder: (context, cart, child) {
                List<Widget> cartItems = [];
                int mainTotal = 0;

                if (cart.items.length > 0) {
                  mainTotal = cart.getShoppingCartTotalPrice();

                  cart.items.forEach((PopularCategory item) {
                    PopularCategory itemSubCategory = item;
                    int total = itemSubCategory.price;

                    cartItems.add(Container(
                        margin: EdgeInsets.all(10),
                        padding: EdgeInsets.all(15),
                        decoration: BoxDecoration(
                            color: AppColors.white,
                            borderRadius: BorderRadius.circular(50),
                            boxShadow: [
                              BoxShadow(
                                  color: Colors.black.withOpacity(0.1),
                                  blurRadius: 10,
                                  offset: Offset.zero)
                            ]),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            ClipOval(
                              child: Image.network(itemSubCategory.imgPath,
                                  width: 50, height: 50, fit: BoxFit.cover),
                            ),
                            SizedBox(width: 20),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(itemSubCategory.name,
                                      style: TextStyle(
                                          color: AppColors.main_color)),
                                  Text('X ${itemSubCategory.amount.toString()}',
                                      style: TextStyle(color: Colors.grey)),
                                  Text('Rs ${total.toStringAsFixed(2)}',
                                      style: TextStyle(
                                          color: AppColors.secondary_color,
                                          fontWeight: FontWeight.bold))
                                ],
                              ),
                            ),
                            IconButton(
                                onPressed: () {
                                  cart.remove(context, item);
                                },
                                icon: Icon(Icons.highlight_off,
                                    size: 30, color: AppColors.main_color))
                          ],
                        )));
                  });

                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      SizedBox(height: 20),
                      Expanded(
                        child: Container(
                          padding: EdgeInsets.all(10),
                          child: SingleChildScrollView(
                            child: Column(children: cartItems),
                          ),
                        ),
                      ),
                      Container(
                          padding: EdgeInsets.all(10),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(50)),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text.rich(TextSpan(children: [
                                TextSpan(
                                    text:
                                        'Total: RS ${mainTotal.toStringAsFixed(2)}',
                                    style: TextStyle(
                                        color: AppColors.main_color,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 25))
                              ]))
                            ],
                          ))
                    ],
                  );
                } else {
                  return Container(
                    alignment: Alignment.center,
                    child: Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            margin: EdgeInsets.only(left: 20, right: 20),
                            width: 2,
                            height: 50,
                            color: Colors.grey[400],
                          ),
                          Text('Add Item in Ordering List',
                              style: TextStyle(color: Colors.grey[400]))
                        ],
                      ),
                    ),
                  );
                }
              },
            )),
            Container(
              alignment: Alignment.bottomRight,
              child: FloatingActionButton(
                shape: RoundedRectangleBorder(
                  borderRadius: const BorderRadius.all(
                    Radius.circular(10.0),
                  ),
                ),
                onPressed: () {
                  cartService.removeAll(context);
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Icon(Icons.offline_pin_rounded),
                  ],
                ),
              ),
            ),
          ])),
    );
  }
}
