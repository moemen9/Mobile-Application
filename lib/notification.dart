import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:jiffy/jiffy.dart';

class notif extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return notification();
  }

}
class notification extends State<notif> {

  List numr=[0];
  getnum()async{
    var responce=await FirebaseFirestore.instance.collection('variable').get();
    responce.docs.forEach((element) {
      setState(() {
        numr.add((element.data() as dynamic)['var']);
      });
    });

  }




  @override
  void initState() {
    super.initState();
    getnum();
  }
  @override
  ScrollController controller = ScrollController();
  bool closeTopContainer = false;
  double topContainer = 0;
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final double categoryHeight = size.height*0.30;
    return  Scaffold(
      appBar: AppBar(
        title: Text("Notification"),
      ),
      backgroundColor: Colors.white,
      body: Container(
        height: size.height,
        child: Column(
          children: <Widget>[



            Expanded(
              child: StreamBuilder<QuerySnapshot>(
                  stream: FirebaseFirestore.instance.collection('users').doc('${numr.last}').collection('notification').snapshots(),
                  builder:
                      ( context,  snapshot) {
                    if (snapshot.hasError) {
                      return Text('Something went wrong');
                    }

                    if (snapshot.connectionState ==
                        ConnectionState.waiting) {
                      return Text("Loading");
                    }

                    return ListView.builder(

                        itemCount: snapshot.data!.docs.length,

                        itemBuilder: (context, index) {
                          DocumentSnapshot hist = snapshot.data!.docs[index];


                          return Padding(
                            padding: EdgeInsets.all(5),
                            child: Column(
                              children: [
                                SizedBox(
                                  height: 10,
                                ),
                                Container(
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.all(Radius.circular(20)),
                                      border: Border.all(color: Colors.grey)),
                                  child: ListTile(
                                    title:Text('${hist['name']}'),
                                    subtitle: Column(
                                      children: [
                                        SizedBox(height: 5),
                                        Container(alignment: Alignment.topLeft,child: Text("Statue : ${hist['statue']}",style: TextStyle(color: Colors.black,fontSize: 15,),)),
                                      ],
                                    ),

                                    trailing:IconButton(
                                      icon: Icon(Icons.delete),
                                      onPressed: (){
                                        FirebaseFirestore.instance.collection('users').doc('${numr.last}').collection('notification').doc(hist.id).delete();

                                      },
                                    ),


                                  ),
                                ),
                              ],
                            ),
                          );
                        });
                  }
              ),
            ),
          ],
        ),
      ),
    );
  }
}