import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

class ImageCarousel extends StatefulWidget {
  final height;
  const ImageCarousel({Key key, this.height}) : super(key: key);

  @override
  _ImageCarouselState createState() => _ImageCarouselState();
}

class _ImageCarouselState extends State<ImageCarousel> {
  List l = [
    "https://firebasestorage.googleapis.com/v0/b/delightss-31cdd.appspot.com/o/ic_best_food_8.jpeg?alt=media&token=ab09ceba-9ec4-45dd-9d16-7b3baa6a3c95",
    "https://firebasestorage.googleapis.com/v0/b/delightss-31cdd.appspot.com/o/ic_best_food_8.jpeg?alt=media&token=ab09ceba-9ec4-45dd-9d16-7b3baa6a3c95",
    "https://firebasestorage.googleapis.com/v0/b/delightss-31cdd.appspot.com/o/ic_best_food_8.jpeg?alt=media&token=ab09ceba-9ec4-45dd-9d16-7b3baa6a3c95",
    "https://firebasestorage.googleapis.com/v0/b/delightss-31cdd.appspot.com/o/ic_best_food_8.jpeg?alt=media&token=ab09ceba-9ec4-45dd-9d16-7b3baa6a3c95",
  ];
  @override
  Widget build(BuildContext context) {
    return CarouselSlider(
      items: l
          .map(
            (imgPath) => Container(
              decoration: BoxDecoration(
                color: Colors.white,
                image: DecorationImage(
                  fit: BoxFit.contain,
                  image: NetworkImage(imgPath),
                ),
              ),
            ),
          )
          .toList(),
      options: CarouselOptions(
        initialPage: 0,
        autoPlay: true,
        pauseAutoPlayOnTouch: true,
        autoPlayCurve: Curves.fastOutSlowIn,
        viewportFraction: 1.2,
        enableInfiniteScroll: true,
        height: widget.height,
      ),
    );
  }
}
