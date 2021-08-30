import 'package:Delightss/Pages/Details.dart';
import 'package:Delightss/Pages/Home.dart';
import 'package:Delightss/Pages/Login.dart';
import 'package:Delightss/Services/Login.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'Pages/SplashScreen.dart';

Future<void> main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(
      MultiProvider(
          providers: [
            ChangeNotifierProvider(
                create: (_) => LoginService()
            )
          ],
          child: MyApp()
      )
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp
    ]);
    return MaterialApp(
        title: 'Delightss',
        themeMode: ThemeMode.light,
        theme: ThemeData(
            brightness: Brightness.light,
            primarySwatch: Colors.deepOrange,
            textTheme: TextTheme(bodyText2: GoogleFonts.quicksand(fontSize: 14.0))
        ),
        darkTheme: ThemeData(
            brightness: Brightness.dark,
            primarySwatch: Colors.deepPurple,
            textTheme: TextTheme(bodyText2: GoogleFonts.bitter(fontSize: 14.0))
        ),
        debugShowCheckedModeBanner: false,
        routes: <String, WidgetBuilder>{
          '/': (BuildContext context) => SplashPage(),
          '/login' : (BuildContext context) => LoginPage(),
          '/home' : (BuildContext context) => HomePage(),
          '/detail' : (BuildContext context) => DetailPage(),
          //'/order' : (BuildContext context) => LoginPage(),
          //'/setting' : (BuildContext context) => LoginPage(),
          //'/card' : (BuildContext context) => LoginPage(),
        }
    );
  }
}