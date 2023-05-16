import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_api_integration_by_flutter_force/views/GetAPI2simpleDataList.dart';
import 'package:getx_api_integration_by_flutter_force/views/GetAPI2staggeredGridViewScreen.dart';
import 'package:getx_api_integration_by_flutter_force/views/GetAPI3testingView.dart';
import 'package:getx_api_integration_by_flutter_force/views/GetAPI1_user_list_screen.dart';

import 'controller/GetAPI2controllerStaggeredGridView.dart';
import 'controller/GetAPI3testingController.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        //The splashColor property is the color that spreads from the tap position.
        // The highlightColor is the color that fills in the ListTile. Change these to your desired colors.
        //These Two properties will work out for any OnTap() in entire App or you can wrap Widgets individually inside ThemeData() to place different onClick effects on different buttons,listTiles etc
        splashColor: Colors.red,
        highlightColor: Colors.black.withOpacity(.3),
      ),
      debugShowCheckedModeBanner: false,
      home: HomeScreen(),
    );
  }
}

class HomeScreen extends StatelessWidget {
   HomeScreen({Key? key}) : super(key: key);

   final MakeupController makeupController = Get.put(MakeupController());
   TestingController testingController = Get.put(TestingController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
        title: const Text("API-Fetching using GetX"),
      ),

      body: SizedBox(
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,

          children: [
            MaterialButton(
              shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(18))),
                color: Colors.red,
                elevation:  18,

                onPressed: () {
                  Get.to(()=> const UserDetailListScreen(), transition: Transition.downToUp);
                },

                child: const Text("Fetch-Data for list (API-1)", style: TextStyle(fontSize: 22,fontWeight: FontWeight.w800),)

            ),

              const SizedBox(height: 35,),
             //Spacer(flex: 1,),

            MaterialButton(
                shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(18))),
                color: Colors.green,
                elevation:  18,

                onPressed: () {
                  makeupController.viewProds(); // on Click the data will be loaded from api
                  Get.to( ()=> StaggeredGridViewScreen() ,transition: Transition.circularReveal);
                },

                child: const Text("Fetch-Data for GridView (API-2)", style: TextStyle(fontSize: 22,fontWeight: FontWeight.w800),)

            ),

            const SizedBox(height: 35,),
            //Spacer(flex: 1,),

            MaterialButton(
                shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(18))),
                color: Colors.amber,
                elevation:  18,

                onPressed: () {

                  Get.to( ()=> SimpleDataList() ,transition: Transition.fadeIn);
                },

                child: const Text("Fetch-Data for SimpleList (API-2)", style: TextStyle(fontSize: 22,fontWeight: FontWeight.w800),)

            ),

            const SizedBox(height: 35,),
            //Spacer(flex: 1,),

            MaterialButton(
                shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(18))),
                color: Colors.deepPurple,
                elevation:  18,

                onPressed: () {
                  Get.to( ()=> TestingView() ,transition: Transition.upToDown, curve: Curves.slowMiddle);
                },

                child: const Text("Fetch-Data from testingAPI (API-3)", style: TextStyle(fontSize: 20,fontWeight: FontWeight.w800,color: Colors.white))

            ),
          ],

        ),
      ),
    );
  }
}
