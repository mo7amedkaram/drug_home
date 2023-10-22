part of 'lack_drugs_cubit.dart';

@immutable
abstract class LackDrugsState {}

class LackDrugsInitial extends LackDrugsState {}

class LackDrugsLoaded extends LackDrugsState {
  final List<dynamic> data;

  LackDrugsLoaded({required this.data});
}
