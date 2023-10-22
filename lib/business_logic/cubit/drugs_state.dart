import 'package:drug_home/data/model/drugs_model.dart';
import 'package:flutter/material.dart';

@immutable
abstract class DrugsState {}

class DrugsInitial extends DrugsState {}

class DrugsLoading extends DrugsState {}

class DrugsLoaded extends DrugsState {
  final List<DrugList> allDrugs;

  DrugsLoaded(this.allDrugs);
}

class DrugsError extends DrugsState {
  final String error;
  DrugsError(this.error);
}
