//@dart=2.9

import 'package:flutter/material.dart';
import 'imagess.dart';


class BannerView extends StatelessWidget {
  final String image;
  final Function onClick;

  const BannerView({Key key,this.image,this.onClick}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(height: MediaQuery.of(context).size.width*0.2,
      width: MediaQuery.of(context).size.width*0.2,
      child:  Stack(
        children: [
          Container( height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                  topRight: Radius.circular(8),
                  topLeft: Radius.circular(8)),
            ),
            child: MyImage(imageUrl: image,),
          ),
          Align(alignment: Alignment.bottomRight,
          child: IconButton(icon: Icon(Icons.delete_outline), onPressed: onClick),
          )
        ],
      ),
    );
  }
}
