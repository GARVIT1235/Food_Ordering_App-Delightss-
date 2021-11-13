import 'package:Delightss/Models/Popular.dart';
import 'package:Delightss/Services/Login.dart';
import 'package:Delightss/Services/cartService.dart';
import 'package:Delightss/style/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

class placeOrder extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final X = MediaQuery.of(context).size.width;
    final Y = MediaQuery.of(context).size.height;
    CartService cartService = Provider.of<CartService>(context, listen: false);
    LoginService loginService =
        Provider.of<LoginService>(context, listen: false);
    cartService.loadCartItemsFromFirebase(context);
    List<PopularCategory> list = cartService.its;
    Future.delayed(Duration(seconds: 2), () async {
      Navigator.of(context).pop();
      Fluttertoast.showToast(msg: 'Order Placed.');
    });

    return Scaffold(
      backgroundColor: AppColors.main_color,
      body: Container(
        padding: EdgeInsets.only(top: Y / 3 + 30),
        height: Y,
        width: X,
        alignment: Alignment.center,
        child: Column(
          children: [
            Container(
                height: Y * 0.2,
                child: Image.asset("assets/images/delivery.gif")),
            Center(child: CircularProgressIndicator())
          ],
        ),
      ),
    );
  }
}
