import 'package:drug_home/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

import 'Router_Navigation.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await MobileAds.instance.initialize();
  runApp(MyApp(
    appRouter: AppRouterNavigation(),
  ));
}

class MyApp extends StatefulWidget {
  MyApp({super.key, required this.appRouter});
  AppRouterNavigation appRouter;

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primaryColor: AppColor.secondaryColor,
        fontFamily: "Cairo",
        appBarTheme: AppBarTheme(
            iconTheme: const IconThemeData(color: Colors.white),
            titleTextStyle: TextStyle(color: Colors.white, fontSize: 20)),
      ),
      debugShowCheckedModeBanner: false,
      onGenerateRoute: widget.appRouter.routerNavigation,
    );
  }
}
