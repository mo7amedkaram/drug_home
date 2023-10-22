import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:meta/meta.dart';
import '../../data/repository/drugs_lack_repo.dart';

part 'lack_drugs_state.dart';

class LackDrugsCubit extends Cubit<LackDrugsState> {
  LackDrugsCubit() : super(LackDrugsInitial());

  void deleteAllDrugs() async {
    await DrugsLackRepository
        .deleteAllDrugs(); // assuming this is your deletion method
    emit(LackDrugsLoaded(data: [])); // Emitting a new state with an empty list.
  }

  // You might also need a method to load the drugs initially or after other operations.
  void loadDrugs() async {
    final data = await DrugsLackRepository.getItems();
    emit(LackDrugsLoaded(data: data));
  }

  //--------------
  void deleteSpecificDrug({required int id}) async {
    try {
      await DrugsLackRepository.deletSpecificDrug(id: id);
      // After deletion, load the updated list of drugs.
      final updatedData = await DrugsLackRepository.getItems();
      // Emit a new state with the updated list of drugs.
      emit(LackDrugsLoaded(data: updatedData));
    } catch (e) {
      // Handle deletion error here, maybe emit a failure state.
      print(e);
    }
  }
}
