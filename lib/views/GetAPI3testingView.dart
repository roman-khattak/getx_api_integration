import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_api_integration_by_flutter_force/models/GetAPI3testingModel.dart';

import '../controller/GetAPI3testingController.dart';

///........The controller is not deleting automatically onGoing back from this page thus we can solve it by using the following 2 methods.
/// Convert this class into a stateful Widget and call upon the dispose function, @override void dispose() { Get.delete<TestingController>(); super.dispose(); }
class TestingView extends StatefulWidget {
   TestingView({Key? key}) : super(key: key);

   @override
     State<TestingView> createState() => _TestingViewState();
   }

class _TestingViewState extends State<TestingView> {
  TestingController testingController = Get.put(TestingController());

  @override
  dispose() {
    Get.delete<TestingController>(); super.dispose();
  }


  @override
  Widget build(BuildContext context) {
     // You must place Get.put as the first line of the build method. (Getx maintainers Recommendation)
  //   TestingController testingController = Get.put(TestingController(),permanent: false);

    return SafeArea(
      child: Scaffold(
        backgroundColor: context.theme.primaryColor,
        appBar: AppBar(backgroundColor: Colors.pinkAccent,),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Obx(() => testingController.isLoading.value ? const Center(child: CircularProgressIndicator())
            :testingController.hasError
                ? const Text("No data found")
                : Expanded(
                  child: ListView.separated(
                    //  Setting the shrinkWrap value to true causes GridView/ListView to take only the required space to fill items in the scroll direction.
                    //  This defaults to false and reserves the entire screen even if the items are not in the list.
                    //When shrinkWrap is false, we need to wrap the GridView/ ListView inside the Expanded widget so that it takes all available space.
                    // Otherwise, it will throw an error.
                    shrinkWrap: true,
                    scrollDirection: Axis.vertical,
                     physics: const AlwaysScrollableScrollPhysics(),
                    separatorBuilder: (context, index) {
                      return const Divider(     // this will separate your ListTiles() from each other.
                        height: 40,               // space between each divider
                        color: Colors.limeAccent,
                        thickness: 4,
                        indent: 30,    //leading space (Padding) from left edge of screen
                        endIndent: 30, //trailing space ((Padding)) from right edge of screen
                      );
                    },

                    itemCount: testingController.list.length,

      itemBuilder: (context, index) {
                      return ListTile(
                        leading: CircleAvatar(

                          radius: 30,
                          backgroundImage: NetworkImage(testingController.list[index].avatar.toString()),
                        ),

                        title: Text(testingController.list[index].firstName.toString(), style: TextStyle(color: Colors.white, fontSize: 18)),
                        subtitle: Text(testingController.list[index].email.toString(), style: TextStyle(color: Colors.white, fontSize: 18)),
                        trailing: Text(testingController.list[index].id.toString(), style: TextStyle(color: Colors.white, fontSize: 18)),
                        dense: false,
                       //..................................................
                        ///....These three are required for on Hover Over Color Change
                        hoverColor: Colors.red,   // Works when the ListTile(Not very good incase different list Tiles) or whole ListView(Better) is Wrapped in Material() widget
                        enabled: true, // make the tile interactive eg; if it is "true", so then on hover the color will change hence the tile will be interactive
                        onTap: (){},
                        //...............................................................

                        /// selected: true,   // makes the icon and text color same

                      );
                    },
                  ),
                ),
            ),
          ],
        )
      ),
    );
  }
}
