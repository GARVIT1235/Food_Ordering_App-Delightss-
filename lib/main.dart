import 'package:Delightss/Pages/Cart.dart';
import 'package:Delightss/Pages/Details.dart';
import 'package:Delightss/Pages/Home.dart';
import 'package:Delightss/Pages/LandingError.dart';
import 'package:Delightss/Pages/Login.dart';
import 'package:Delightss/Pages/RegError.dart';
import 'package:Delightss/Pages/Setting.dart';
import 'package:Delightss/Services/BestFood.dart';
import 'package:Delightss/Services/Login.dart';
import 'package:Delightss/Services/PopularFood.dart';
import 'package:Delightss/Services/cartService.dart';
import 'package:Delightss/Services/catcartService.dart';
import 'package:Delightss/Services/regUser.dart';
import 'package:Delightss/Services/slider.dart';
import 'package:Delightss/style/app_colors.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'Pages/MyOrder.dart';
import 'Pages/SplashScreen.dart';
import 'Pages/place_order.dart';
import 'Services/Details.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(create: (_) => LoginService()),
    ChangeNotifierProvider(create: (_) => CartService()),
    ChangeNotifierProvider(create: (_) => CategorySelectionService()),
    Provider(create: (_) => PopularService()),
    Provider(create: (_) => BestService()),
    Provider(create: (_) => SliderService()),
    Provider(create: (_) => DetailService()),
    Provider(create: (_) => RegUserService()),
  ], child: MyApp()));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    SystemChrome.setEnabledSystemUIOverlays([]);
    return MaterialApp(
        title: 'Delightss',
        themeMode: ThemeMode.light,
        theme: ThemeData(
            brightness: Brightness.light,
            primarySwatch: AppColors.main_color,
            textTheme:
                TextTheme(bodyText2: GoogleFonts.quicksand(fontSize: 14.0))),
        darkTheme: ThemeData(
            brightness: Brightness.dark,
            primarySwatch: Colors.deepPurple,
            textTheme:
                TextTheme(bodyText2: GoogleFonts.bitter(fontSize: 14.0))),
        debugShowCheckedModeBanner: false,
        routes: <String, WidgetBuilder>{
          '/': (BuildContext context) => SplashPage(),
          '/login': (BuildContext context) => LoginPage(),
          '/home': (BuildContext context) => HomePage(),
          '/detail': (BuildContext context) => DetailPage(),
          '/order': (BuildContext context) => OrderPage(),
          '/setting': (BuildContext context) => SettingPage(),
          '/cart': (BuildContext context) => CartPage(),
          '/lerror': (BuildContext context) => LandingErrorPage(),
          '/place': (BuildContext context) => placeOrder(),
          '/rerror': (BuildContext context) => RegErrorPage()
        });
  }
}
