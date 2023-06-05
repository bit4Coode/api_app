import 'dart:convert';
import 'package:flutter/cupertino.dart';
import '../models/model.dart';
import 'package:http/http.dart' as http;

class AppProvider extends ChangeNotifier {
  AppProvider() {
    getData("https://api.disneyapi.dev/character", true);
  }
  // model list for data store
  FetchDataModel fetchDataModel = FetchDataModel(data: []);
  // function for get data from api
  getData(String url, bool isFirst) async {
    debugPrint(url);
    // http package for help get method for fetch data from api
    var response = await http.get(Uri.parse(url), headers: {}).timeout(
        const Duration(seconds: 5), onTimeout: () {
      throw Exception("Request Time Out");
    });
    var jsonResponse = jsonDecode(response.body);
    if (isFirst == true) {
      fetchDataModel = FetchDataModel.fromJson(jsonResponse);
    } else {
      FetchDataModel data = FetchDataModel.fromJson(jsonResponse);
      fetchDataModel.info = data.info;
      fetchDataModel.data!.addAll(data.data!);
    }

    notifyListeners();
  }

  update() {
    notifyListeners();
  }
}
