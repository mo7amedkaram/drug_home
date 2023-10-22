import 'package:drug_home/Presentations/screens/alters_drug_screen.dart';
import 'package:drug_home/Presentations/screens/drug_details_screen.dart';
import 'package:drug_home/Presentations/screens/similar_drugs_screen.dart';
import 'package:drug_home/Presentations/screens/update_db_screen.dart';
import 'package:drug_home/business_logic/cubit/drugs_cubit.dart';
import 'package:drug_home/business_logic/cubit/lack_drugs_cubit.dart';
import 'package:drug_home/data/db_provider/db_provider.dart';
import 'package:drug_home/data/repository/drug_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'Presentations/screens/home_page.dart';
import 'Presentations/screens/lack_drugs_screen.dart';
import 'business_logic/cubit/update_data_from_server_cubit.dart';

class AppRouterNavigation {
  DrugRepository? drugRepository;
  DBProvider? dbProvider;

  AppRouterNavigation() {
    drugRepository = DrugRepository(dbProvider: DBProvider());
  }
  Route? routerNavigation(RouteSettings settings) {
    switch (settings.name) {
      case "/":
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (context) => DrugsCubit(
                drugRepository: DrugRepository(dbProvider: DBProvider())),
            child: HomePageScreen(),
          ),
        );

      case "/drugDetailsScreen":
        Map<String, dynamic> drugDetails =
            settings.arguments as Map<String, dynamic>;
        return MaterialPageRoute(
            builder: (_) => DrugDetailsScreen(drugDetails: drugDetails));
      //-----
      case "/similarDrugScreen":
        Map<String, dynamic> similarDrugs =
            settings.arguments as Map<String, dynamic>;
        return MaterialPageRoute(
          builder: (_) => SimilarDrugs(
            similarDrugs: similarDrugs,
          ),
        );
      //----------
      case "/alternativeDrugScreen":
        Map<String, dynamic> alterDrugs =
            settings.arguments as Map<String, dynamic>;
        return MaterialPageRoute(
          builder: (_) => AlternativeDrugsScreen(
            altersDrug: alterDrugs,
          ),
        );
      //--------
      case "/lackDrugScreen":
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (context) => LackDrugsCubit(),
            child: LackDrugsScreen(),
          ),
        );

      //------
      case "/updateDbScreen":
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (context) => UpdateDataFromServerCubit(),
            child: UpdateDbScreen(),
          ),
        );
    }
  }
}
