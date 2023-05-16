import 'dart:convert';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../models/GetAPI2model.dart';

class SimpleDataListController extends GetxController {
  var isViewProdsLoading = false.obs;
  bool hasViewProdsError = false;       // why is it not observable?
  List<Makeup> myList = [];           // why is it not observable?
  late Makeup makeup;                //     what is its use?                // Makeup Model class is used for this Controller as well
  Future viewProds() async {
    isViewProdsLoading(true);   // start the loading process upon the call of viewProds() function
    try {
      var url = Uri.parse("http://makeup-api.herokuapp.com/api/v1/products.json?brand=maybelline");

      var response = await http.get(url);
      if (response.statusCode == 200) {

        /// "json.decode(response.body) as List" decodes jsonResponse and convert it to a List. Then the List is sent to map() as "i" and map has the ability
        /// ... to auto-Iterate the list thus it starts iterating the list and returns each item to " Makeup.fromJson(i) " as argument through 'i'.
        /// ... Then the " Makeup.fromJson(i) " will convert each iterated item into the data of Type "Model Class" because we need to store the data on the list of dataType "ModelClass".
        /// ... and finally we will convert all this data into a List because we need to store all this data on a List called "myList" of the datatype 'ModelClass', ie; List<ModelClass> myList = [ ];

        myList = (json.decode(response.body) as List).map((i) => Makeup.fromJson(i)).toList();   //[ data we have in the api is a list of objects ] so we store the response on a list []
      } else {
        hasViewProdsError = true;
      }
    } catch (e) {
      print("something went wrong");
    }
    isViewProdsLoading(false);  //end the loading process
  }

  @override
  void onInit() {
    makeup = Makeup();             //     what is its use?
    super.onInit();
  }
}
