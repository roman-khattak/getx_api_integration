import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controller/GetAPI2controllerStaggeredGridView.dart';
import '../controller/GetAPI2simpleDataListController.dart';

class SimpleDataList extends StatelessWidget {
   SimpleDataList({Key? key}) : super(key: key);

  MakeupController makeupController = Get.put(MakeupController());

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          body: Center(
            child: Obx(
                  () => SingleChildScrollView(
                    child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                    makeupController.isViewProdsLoading.isTrue
                        ? const CircularProgressIndicator()
                        : ElevatedButton(
                        onPressed: () {
                          makeupController.viewProds();
                        },
                        child: const Text("Fetch")),

                    makeupController.myList.isEmpty
                        ? Container()
                        : makeupController.hasViewProdsError
                        ? const Text("No data found")
                        : SizedBox(
                      height: 500,
                      child: ListView.builder(
                          shrinkWrap: true,
                          itemCount: makeupController.myList.length,
                          itemBuilder: (context, index) {
                            return ListTile(
                              leading: CircleAvatar(
                                backgroundImage: NetworkImage(makeupController.myList[index].imageLink.toString()),
                              ),
                              title: Text(
                                makeupController.myList[index].name.toString(),
                              ),
                              subtitle: Text(
                                makeupController.myList[index].brand.toString(),
                              ),
                              trailing: Text(
                                makeupController.myList[index].price.toString(),
                              ),
                            );
                          }),
                    ),
                ],
              ),
                  ),
            ),
          )),
    );
  }
}
