import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controller/GetAPI1controller.dart';

class UserDetailListScreen extends StatefulWidget {
  const UserDetailListScreen({Key? key}) : super(key: key);

  @override
  State<UserDetailListScreen> createState() => _UserDetailListScreenState();
}

class _UserDetailListScreenState extends State<UserDetailListScreen> {

  DataController dataController = Get.put(DataController());     //created the instance of controller class

  @override
  void initState() {
    super.initState();

    dataController.getUserInformationFromApi();   // as soon as this screen is accessed The data from Api is fetched through the following function

  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          backgroundColor: context.theme.backgroundColor,

          body: Obx(() => dataController.isDataLoading.value ? const Center(    // if, isDataLoading(true) that means api is called but data is not yet fetched so circularProgressIndicatior() is running
            child: CircularProgressIndicator(),
          ) : ListView.builder(
            itemBuilder: ((context, index) {

              String image = '';    //These can be declared above the build widget as well
              String title = '';
              String subTitle = '';
              String firstName = '';
              String lastName = '';

              try{
                image = dataController.user_list!.data![index].picture!;  //in DataController class we have user_list object which has all the data array of type ModelClass, in the data array we have objects and each object has picture, title, subTitle, finalName, lastName
              } catch(e) {
                //image = ''; //passing empty String in case of error
                Text("Exception: $e");
              }

              try{
                title = dataController.user_list!.data![index].title!;  // data is a list/array[] of objects {} thus we will receive each object by index
              } catch(e) {
                title = ''; //passing empty String in case of error
              }

              try{
                firstName = dataController.user_list!.data![index].firstName!;  // data is a list/array[] of objects {} thus we will receive each object by index
              } catch(e) {
                firstName = ''; //passing empty String in case of error
                //Text("Exception: $e");
              }

              try{
                lastName = dataController.user_list!.data![index].lastName!;  // data is a list/array[] of objects {} thus we will receive each object by index
              } catch(e) {
                lastName = ''; //passing empty String in case of error
              }

              try{
                subTitle = dataController.user_list!.data![index].id!;  // "data" is a list/array[] of objects {} thus we will receive each object by index
              } catch(e) {
                subTitle = ''; //passing empty String in case of error
              }

              return ListTile(

                leading: CircleAvatar(
                  radius: 30,
                  backgroundImage: NetworkImage(image),
                ),

                title: Text("${title}"+" "+ "${firstName}"+ " " + "${lastName}", style: TextStyle(fontSize: 19, fontWeight: FontWeight.bold),),

                subtitle: Text(subTitle),
              );
            }),

            itemCount: dataController.user_list!.data!.length,
          ),
          )
      ),
    );
  }
}


