import 'package:bloc/bloc.dart';
import 'package:drug_home/business_logic/cubit/drugs_state.dart';
import 'package:drug_home/data/model/drugs_model.dart';

import '../../data/db_provider/db_provider.dart';
import '../../data/repository/drug_repository.dart';

class DrugsCubit extends Cubit<DrugsState> {
  DrugRepository drugRepository;
  List<DrugList> drugs = [];

  //---------
  DrugsCubit({required this.drugRepository}) : super(DrugsInitial());
  List<DrugList> getAllDrugs() {
    drugRepository.fetchAllDrugs().then((drugs) {
      emit(DrugsLoaded(drugs));
      this.drugs = drugs;
    });
    return drugs;
  }
}
