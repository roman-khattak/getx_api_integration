import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../models/GetAPI2model.dart';

class MakeupController extends GetxController {
  var isViewProdsLoading = false.obs;
  var hasViewProdsError = false;

  //var myList = List.empty(growable: true).obs;     //dynamic List
  List<Makeup> myList =  [];
 // late Makeup makeup;             // no need for this object of model class here because we are saving the response on "myList"
  Future viewProds() async {
    isViewProdsLoading.value = true;
    try{
      var url = Uri.parse("http://makeup-api.herokuapp.com/api/v1/products.json?brand=maybelline");
      var response = await http.get(url);

      if(response.statusCode == 200) {

        ///This code takes the JSON object returned by the API call and extracts the "categoryList" key from it.
        // It then maps the list of objects that it finds into a new list of 'CategoryList' objects using the 'fromJson()' method of the 'CategoryList' class.
        //
        // Now let's break it down step by step:
        //
        // (decodedJson['categoryList'] as List) :
        // ..........................................
        // This line accesses the "categoryList" key from the JSON object, and casts it to a 'List' type.
        // The 'as List' part is added to ensure that the value of the key is actually a list, and not some other type of object.
        //
        // .map((data) => CategoryList.fromJson(data)) :
        // ................................................
        // This line maps each element in the list to a new 'CategoryList' object using the 'fromJson()' method.
        //  The 'data' parameter is each individual element in the list, and is passed to 'fromJson()' to convert it to a 'CategoryList' object.
        //
        // .toList() :
        // ...............
        // This line takes the resulting Iterable object that was returned by the map() method, and converts it back into a list.
        // Finally, all of these steps are combined into a single line, which creates a new list of CategoryList objects from the "categoryList" key in the decoded JSON object.


        myList = (json.decode(response.body) as List ).map((i) => Makeup.fromJson(i)).toList();

      }else{
        hasViewProdsError = true;
      }
    }catch(e) {
      print("Exception generated: $e");

    }finally{
      isViewProdsLoading(false);
    }
  }

// @override
//   void onInit() {           //as soon as MakeupController class will be called this function will be called and initialize the object so that there is no garbage value.
//    makeup = Makeup();        //initializing the object of model class
//     super.onInit();
//   }
}