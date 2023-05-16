import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';
import '../controller/GetAPI2controllerStaggeredGridView.dart';



class StaggeredGridViewScreen extends StatelessWidget {
  StaggeredGridViewScreen({Key? key}) : super(key: key);

   MakeupController makeupController = Get.find();

  // dependency injection : Its purpose is to inject the instance once so that you don't have to create it again and again instead just create once and then find anywhere

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          body: Center(
            child: Obx(
                  () =>
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      makeupController.isViewProdsLoading.isTrue
                          ? const CircularProgressIndicator()
                      //     : ElevatedButton(
                      //     onPressed: () {
                      //       makeupController.viewProds();
                      //     },
                      //     child: const Text("Fetch")
                      // ),

                          :makeupController.myList.isEmpty
                          ? Container()
                          : makeupController.hasViewProdsError
                          ? const Text("No data found")
                          : Expanded(
                        child: masonryLayout(context),
                      ),
                    ],
                  ),
            ),
          )),
    );
  }

  Widget masonryLayout(BuildContext context) {
    return MasonryGridView.count(
        scrollDirection: Axis.vertical,
        crossAxisCount: 2,
        //means 2 columns in the row
        mainAxisSpacing: 7,
        crossAxisSpacing: 5,
        itemCount: makeupController.myList.length,
        // is the number of items in the grid View
        itemBuilder: (context, index) { // index is here so as to place each image index wise at each position in the grid View
          // return ClipRRect( // using ClipRRect so that i can provide some BorderRadius
          //   borderRadius: BorderRadius.circular(10),
          //   child: Image.network("http://source.unsplash.com/random?sig=$index",
          //     fit: BoxFit
          //         .cover,), //this "index" here is a required parameter for placing each image index wise
          //   // fit: BoxFit.cover => "This property will make even small images fit to the size of container"
          // );
          return Card(
            elevation: 2,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Stack(
                    children: [
                      Container(
                        height: 180,
                        width: double.infinity,
                        clipBehavior: Clip.antiAlias,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Image.network(
                            makeupController.myList[index].imageLink.toString()
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Text(
                    makeupController.myList[index].name.toString(),
                    maxLines: 2,
                    style:
                    const TextStyle(fontFamily: 'avenir', fontWeight: FontWeight.w800),
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 8),
                  if (makeupController.myList[index].rating != null)
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.green,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            makeupController.myList[index].rating.toString(),
                            style: const TextStyle(color: Colors.white),
                          ),
                          const Icon(
                            Icons.star,
                            size: 16,
                            color: Colors.white,
                          ),
                        ],
                      ),
                    ),
                  const SizedBox(height: 8),
                  Text('\$${makeupController.myList[index].price}',
                      style: const TextStyle(fontSize: 32, fontFamily: 'avenir')),
                ],
              ),
            ),
          );
        }
    );
  }

  alignedLayout (BuildContext context) {                    //A type of GridView Layout (Currently unused) but can be used instead of masonryLayout(context)
    return AlignedGridView.count(
        crossAxisCount: 2,
        itemCount: makeupController.myList.length,
        scrollDirection: Axis.vertical,
        mainAxisSpacing: 7,
        crossAxisSpacing: 5,
        physics: const BouncingScrollPhysics(),      // by default set for IOS GridViews
        // physics: const ClampingScrollPhysics(),   // by default set for android GridViews
        // physics: const NeverScrollableScrollPhysics(),  // used if you do not want to scroll the grid view eg; for
        itemBuilder: (context, index)
        {
          // return Card(
          //   elevation: 2,
          //   child: Padding(
          //     padding: const EdgeInsets.all(8.0),
          //     child: Column(
          //       crossAxisAlignment: CrossAxisAlignment.start,
          //       children: [
          //         Stack(
          //           children: [
          //             Container(
          //               height: 180,
          //               width: double.infinity,
          //               clipBehavior: Clip.antiAlias,
          //               decoration: BoxDecoration(
          //                 borderRadius: BorderRadius.circular(4),
          //               ),
          //               child: Image.network(
          //                   makeupController.myList[index].imageLink.toString()
          //               ),
          //             ),
          //           ],
          //         ),
          //         const SizedBox(height: 8),
          //         Text(
          //           makeupController.myList[index].name.toString(),
          //           maxLines: 2,
          //           style:
          //           const TextStyle(fontFamily: 'avenir', fontWeight: FontWeight.w800),
          //           overflow: TextOverflow.ellipsis,
          //         ),
          //         const SizedBox(height: 8),
          //         if (makeupController.myList[index].rating != null)
          //           Container(
          //             decoration: BoxDecoration(
          //               color: Colors.green,
          //               borderRadius: BorderRadius.circular(12),
          //             ),
          //             padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
          //             child: Row(
          //               mainAxisSize: MainAxisSize.min,
          //               children: [
          //                 Text(
          //                   makeupController.myList[index].rating.toString(),
          //                   style: const TextStyle(color: Colors.white),
          //                 ),
          //                 const Icon(
          //                   Icons.star,
          //                   size: 16,
          //                   color: Colors.white,
          //                 ),
          //               ],
          //             ),
          //           ),
          //         const SizedBox(height: 8),
          //         Text('${makeupController.myList[index].price}',
          //             style: const TextStyle(fontSize: 32, fontFamily: 'avenir')),
          //       ],
          //     ),
          //   ),
          // );

        }
    );
  }
}