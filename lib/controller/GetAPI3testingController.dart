import 'dart:convert';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import '../models/GetAPI3testingModel.dart';

class TestingController extends GetxController {
  RxBool isLoading = false.obs;
  var hasError = false;
   late TestingModel testingModel;

   // The List named "data" inside the ModelClass {TestingModel} has a dataType of List<Datum> therefore we created a "list"
  ///... variable of type List<Datum> so that we can store the "data" List on it.
  List<Datum> list = [];
 // List<Datum> list = List.empty(growable: true);

   FetchTestingData() async{
    try{
      isLoading(true);
     var url = Uri.parse("https://reqres.in/api/users?page=2");
      var response = await http.get(url);
      if(response.statusCode == 200) {
        var result = jsonDecode(response.body);
        testingModel = TestingModel.fromJson(result);
        //..............................................................
        print("<<<<<<<<<<<<<<<<Method 1 for printing data from object>>>>>>>>>>>>>>>>>\n");
        for (var datum in testingModel.data!) {
          print("id: ${datum.id}");
          print("first_name: ${datum.firstName}");
          print("last_name: ${datum.lastName}");
          // and so on, depending on the properties of the Datum class
        }
        print("<<<<<<<<<<<<<<<<<<<<Method 2 for printing data from object>>>>>>>>>>>>>>>>>>\n");
        testingModel.data!.forEach((datum) {
          print("id: ${datum.id}");
          print("first_name: ${datum.firstName}");
          print("last_name: ${datum.lastName}");
          // and so on, depending on the properties of the Datum class
        });
        //...............................................................

        list.addAll(testingModel.data!.toList());
     //  list = testingModel.data!.toList();

       print("number of items: ${list.length}");
//....................................................................................................
        print("<<<<<<<<<<<<<<Method 1 for printing data from List>>>>>>>>>>>>>>>\n");
        for (var datum in list) {
          print("id: ${datum.id}");
          print("first_name: ${datum.firstName}");
          print("last_name: ${datum.lastName}");
          // and so on, depending on the properties of the Datum class
        }
        print("<<<<<<<<<<<<<<Method 2 for printing data from List>>>>>>>>\n");
        list.forEach((datum) {
          print("id: ${datum.id}");
          print("first_name: ${datum.firstName}");
          print("last_name: ${datum.lastName}");
          // and so on, depending on the properties of the Datum class
        });

//........................................................................................
      }else{
        hasError = true;
        print("\n\nerror occured , Controller has reached the else Section ${hasError.toString()}");
      }
    }catch(e){
      print("exception: $e");
    }finally{
      isLoading(false);
      print("\n\nController in finally section....");

    }
  }

  @override
  void onInit() {
    testingModel = TestingModel();
    FetchTestingData();
    super.onInit();
  }





}