import 'dart:convert';
import 'package:bloc/bloc.dart';
import 'package:drug_home/business_logic/cubit/update_data_from_server_state.dart';
import 'package:http/http.dart' as http;
import '../../data/db_provider/db_provider.dart';

class UpdateDataFromServerCubit extends Cubit<UpdateDataFromServerState> {
  final DBProvider dbProvider = DBProvider(); // Initiate your DB provider

  UpdateDataFromServerCubit() : super(UpdateDataFromServerInitial());

  Future<void> fetchData() async {
    emit(UpdateDataFromServerWaiting());

    try {
      // Set headers and body as needed
      Map<String, String> headers = {
        "Content-type": "application/x-www-form-urlencoded",
      };
      Map<String, String> body = {
        'updatesqliteios': '1',
      };

      // Send POST request
      final response = await http.post(
        Uri.parse('https://dwaprices.com/ios/index.php'),
        headers: headers,
        body: body,
      );

      if (response.statusCode == 200) {
        List<dynamic> dataFromApi = jsonDecode(response.body);
        await dbProvider.updateDatabase(dataFromApi.map((data) {
          return data as Map<String, dynamic>;
        }).toList());
        emit(UpdateDataFromServerLoaded(data: dataFromApi));
      } else {
        emit(UpdateDataFromServerError(error: "Failed to load data from API"));
      }
    } catch (e) {
      emit(UpdateDataFromServerError(error: e.toString()));
    }
  }
}

// State classes...
