import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:foodzoo/features/constants/url.dart';
import 'package:foodzoo/features/dashboard/model/food_model.dart';
import 'package:http/http.dart' as http;


class DashboardRepo {

  Future fetchFoodData() async {
    Dio dio = Dio();
    try {
      // Make a GET request
      Response response =
          await dio.get('$baseUrl/categories.php');
      if (kDebugMode) {
        debugPrint("BASE URL ====>${response.realUri}");
        debugPrint("RESPONSE ====>${response.data.toString()}");
      }

      return FoodModel.fromJson(response.data);
    } catch (e) {
      print('Error fetching data: $e');
      return e.toString();
    }
  }

}
