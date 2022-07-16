import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:jiffy/jiffy.dart';
import 'package:offre/notification.dart';
import 'home.dart';
import 'offres.dart';
import 'services.dart';


class link extends StatefulWidget{

  @override
  State<StatefulWidget> createState() {
    return links();
  }

}
class links extends State<link>{
  var index_selected=1;
  List<Widget> pages=[
    offres(),
    home(),
    services(),
  ];
  List cos=[];
  CollectionReference reference=FirebaseFirestore.instance.collection('cost');
   getData()async{
  var responce=await reference.get();
  responce.docs.forEach((element) {
    setState(() {
      cos.add(element.data());
    });
  });
print(cos.length);
}


  @override
  void initState() {
    getData();
    setState(() {
      cos;
    });
    super.initState();
  }

  Widget build(BuildContext context) {


    return Scaffold(




        bottomNavigationBar: ConvexAppBar(
          initialActiveIndex: 1,

          backgroundColor: Colors.blue,
          onTap: (index){
            setState(() {
              index_selected=index;

            });
          },
          items: [
            TabItem(icon: Icon(Icons.add_shopping_cart) ,title: "OFFRES"),
            TabItem(icon: Icon(Icons.home_rounded) ,title: "HOME"),
            TabItem(icon: Icon(Icons.home_repair_service) ,title: "SERVICES"),
          ],),
        body:

        pages.elementAt(index_selected),



      );
  }

}
class NamedIcon extends StatelessWidget {
  final IconData iconData;
  final VoidCallback? onTap;
  final int notificationCount;

  const NamedIcon({
    Key? key,
    this.onTap,
    required this.iconData,
    required this.notificationCount ,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: 72,
        padding: const EdgeInsets.symmetric(horizontal: 8),
        child: Stack(
          alignment: Alignment.center,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Icon(iconData,size: 35,),
              ],
            ),
            Positioned(
              top: 8,
              right: 6,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 5, vertical: 3),
                decoration: BoxDecoration(shape: BoxShape.circle, color: Colors.red),
                alignment: Alignment.center,
                child: Text("${notificationCount}"),
              ),
            )
          ],
        ),
      ),
    );
  }
}
