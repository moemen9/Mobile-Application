import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:jiffy/jiffy.dart';


class ChatScreen extends StatefulWidget {
  static const String screenRoute = 'chat_screen';

  const ChatScreen({Key? key}) : super(key: key);

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final msg = TextEditingController();
  List numr=[0];
  CollectionReference variable=FirebaseFirestore.instance.collection('variable');
  getnum()async{
    var responce=await variable.get();
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
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.yellow[900],
        title: Row(
          children: [
            Image.asset('images/logo.png', height: 25),
            SizedBox(width: 10),
            Text('Assistant')
          ],
        ),

      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
        Expanded(
          child: StreamBuilder<QuerySnapshot>(
          stream:   FirebaseFirestore.instance.collection("users").doc("${numr.last}").collection("message").orderBy("date").snapshots(),
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
                  padding:EdgeInsets.symmetric(horizontal: 10,vertical: 20),
                  itemCount: snapshot.data!.docs.length,

                  itemBuilder: (context, index) {
                    DocumentSnapshot hist = snapshot.data!.docs[index];

                    return Container(
                      child: hist['numero']==0? Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: 10,
                          ),

                          Material(

                            borderRadius: BorderRadius.only(topLeft:Radius.circular(30),bottomLeft: Radius.circular(30),bottomRight: Radius.circular(30)),
                            color: Colors.black12,
                              child:
                              Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 10),
                                 child: Text(" ${hist['msg']} ",style: TextStyle(color: Colors.black,fontSize: 15,),),
                              )
                          ),
                          SizedBox(height: 5,),
                          Container(child: Text("${Jiffy(DateTime.parse (hist['date'].toDate().toString())).format("HH:mm")}")),
                        ],
                      ):Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          SizedBox(
                            height: 10,
                          ),

                          Material(
                              elevation: 6,
                              borderRadius: BorderRadius.only(topLeft:Radius.circular(30),bottomLeft: Radius.circular(30),bottomRight: Radius.circular(30)),
                              color: Colors.blue[700],
                              child:
                              Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 10),
                                child: Text(" ${hist['msg']} ",style: TextStyle(color: Colors.white,fontSize: 15,),),
                              )
                          ),
                          SizedBox(height: 5,),
                          Container(child: Text("${Jiffy(DateTime.parse (hist['date'].toDate().toString())).format("HH:mm")}")),
                        ],
                      )
                    );
                  });
            }
      ),
        ),

            Container(
              decoration: BoxDecoration(
                border: Border(
                  top: BorderSide(
                    color: Colors.orange,
                    width: 2,
                  ),
                ),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    child: TextField(
                      controller: msg,
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.symmetric(
                          vertical: 10,
                          horizontal: 20,
                        ),
                        hintText: 'ecrire votre message ...',
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                  IconButton(
                      onPressed: () {
                        FirebaseFirestore.instance.collection("users").doc("${numr.last}").collection("message").add(
                            {
                              "numero":numr.last,
                              "msg":"${msg.text}",
                              "date":DateTime.now()
                            }
                        );
                        msg.text="";
                      },
                      icon: Icon(Icons.send_sharp,size: 30,color:Colors.blue[800],)
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
