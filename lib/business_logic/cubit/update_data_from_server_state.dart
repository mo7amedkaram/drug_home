class UpdateDataFromServerState {}

class UpdateDataFromServerInitial extends UpdateDataFromServerState {}

class UpdateDataFromServerWaiting extends UpdateDataFromServerState {}

class UpdateDataFromServerLoaded extends UpdateDataFromServerState {
  final List<dynamic> data;

  UpdateDataFromServerLoaded({required this.data});
}

class UpdateDataFromServerError extends UpdateDataFromServerState {
  final String error;

  UpdateDataFromServerError({required this.error});
}
