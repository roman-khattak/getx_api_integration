import 'dart:convert';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../models/GetAPI1model.dart';

class DataController extends GetxController {
  // the instance of modelClass is optional because if the api call is unsuccessful then the instance will be null
  User_Model_List? user_list; // creating the object/instance for Model class
  // in dart language , Object is a map()
 // late User_Model_List user_list;

  var isDataLoading = false.obs;

  getUserInformationFromApi () async{    //api response is returned in future and we have to wait for the response as well so async-await is compulsory
    try {
      // the bool value true is not assigned here it is passed
      isDataLoading(true);  //before requesting api for response show the CircularProgressIndicator()

      http.Response response = await http.get(Uri.tryParse("https://dummyapi.io/data/v1/user")!, headers: {
        'app-id': '63c79fbfa5174712ec28e7af'
      });
      if(response.statusCode == 200) {

        var result = jsonDecode(response.body); // the response we get is in json format thus we decode it to Map<String,Dynamic> format so that dart compiler can understand it
        // Now we have to convert the Decoded Json response into the data of type Model Class
        user_list = User_Model_List.fromJson(result); // converts the result from Decoded Json to ProductModelClass datatype bc ModelClass is the datatype of api
print("${user_list!.data.toString()}");
      }else{
        //data loading error
      }

    } on Exception catch (e) {
      //exceptions can be handled here
      print("Exception while getting Data is $e");

    } finally {
      isDataLoading(false);   //when response is loaded/completed from api close the CircularProgressIndicator()
    }

  }

// @override
//   void onInit() {
//   user_list = User_Model_List();
//     super.onInit();
//   }

}