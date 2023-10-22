// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:drug_home/data/db_provider/db_provider.dart';

import '../model/drugs_model.dart';

class DrugRepository {
  DBProvider dbProvider;
  DrugRepository({
    required this.dbProvider,
  });

  Future<List<DrugList>> fetchAllDrugs() async {
    final drugs = await dbProvider.getDatabase();
    return drugs.map((e) => DrugList.fromJson(e)).toList();
  }
}
