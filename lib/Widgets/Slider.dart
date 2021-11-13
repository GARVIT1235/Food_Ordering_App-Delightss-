import 'package:Delightss/Models/slider.dart';
import 'package:Delightss/Services/slider.dart';
import 'package:Delightss/style/app_colors.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ImageCarousel extends StatefulWidget {
  final height;
  const ImageCarousel({Key key, this.height}) : super(key: key);

  @override
  _ImageCarouselState createState() => _ImageCarouselState();
}

class _ImageCarouselState extends State<ImageCarousel> {
  @override
  Widget build(BuildContext context) {
    // SliderService cats = Provider.of<SliderService>(context, listen: false);
    // List<SliderCategory> slider = cats.getCategories();
    List l = [
      "https://firebasestorage.googleapis.com/v0/b/delightss-31cdd.appspot.com/o/photo-1562059390-a761a084768e.jpeg?alt=media&token=8ae00b78-cbb8-4dc1-b168-6cc52ce29adb",
      "https://firebasestorage.googleapis.com/v0/b/delightss-31cdd.appspot.com/o/cakes-7551925.jpg?alt=media&token=c58d0609-b226-48df-94c3-a4d05ff74ee8",
      "https://firebasestorage.googleapis.com/v0/b/delightss-31cdd.appspot.com/o/istockphoto-518760756-612x612.jpg?alt=media&token=ee738420-ec69-4709-b21c-f36cbc640751",
      "https://firebasestorage.googleapis.com/v0/b/delightss-31cdd.appspot.com/o/ice-cream-sundae-27684931.jpg?alt=media&token=6b1264a5-55e6-482b-8a9a-c45756e29008",
      "https://firebasestorage.googleapis.com/v0/b/delightss-31cdd.appspot.com/o/cheesesteak-sandwich-14790872.jpg?alt=media&token=d046f2ee-59d5-400c-a7eb-0d402a457859",
      "https://firebasestorage.googleapis.com/v0/b/delightss-31cdd.appspot.com/o/donuts-cakes-wooden-board-full-selection-high-sugar-foods-scones-39122370.jpg?alt=media&token=9a816837-e2e9-4923-ba96-f05986829ba9",
      "https://firebasestorage.googleapis.com/v0/b/delightss-31cdd.appspot.com/o/indian-tea-time-snacks-chole-chaat-made-boiled-chickpea-curry-samosa-curd-mint-chutney-tamarind-chutney-indian-snacks-chole-109155914.jpg?alt=media&token=31a6b866-991a-4be7-b654-a2d08903f46c",
      "https://firebasestorage.googleapis.com/v0/b/delightss-31cdd.appspot.com/o/photo-1562059390-a761a084768e.jpeg?alt=media&token=8ae00b78-cbb8-4dc1-b168-6cc52ce29adb",
      "https://firebasestorage.googleapis.com/v0/b/delightss-31cdd.appspot.com/o/photo-1574126154517-d1e0d89ef734.jpg?alt=media&token=81e886af-28ea-475c-899a-5e628a44ed36",
      "https://firebasestorage.googleapis.com/v0/b/delightss-31cdd.appspot.com/o/vegan-salted-caramel-cookie-dough-ice-cream-sundae-two-sundaes-topped-sauce-158014826.jpg?alt=media&token=9036d9b2-ea0b-47a5-9a07-2bd399cd8b9a"
    ];
    return CarouselSlider(
      items: l
          .map(
            (imgPath) => Container(
              decoration: BoxDecoration(
                color: AppColors.white,
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
