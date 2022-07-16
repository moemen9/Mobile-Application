import 'dart:ui';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:jiffy/jiffy.dart';
import 'package:offre/link.dart';
import 'package:offre/messanger.dart';

import 'fade_animation.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'login.dart';
import 'notification.dart';


class home extends StatefulWidget{
  @override

  State<StatefulWidget> createState() {
    return testhome();
  }

}

class testhome extends State<home> {
  bool showPassword = false;
  bool enable = false;
  TextEditingController name = TextEditingController();
  TextEditingController pass = TextEditingController();
  CollectionReference users = FirebaseFirestore.instance.collection('users');
  List cou=[];
  List numr=[0];

  CollectionReference variable=FirebaseFirestore.instance.collection('variable');


  @override
  void dispose() {
    // Clean up the controller when the Widget is disposed
    name.dispose();
    pass.dispose();
    super.dispose();
  }

  getnum()async{
    var responce=await variable.get();
    responce.docs.forEach((element) {
      setState(() {
        numr.add((element.data() as dynamic)['var']);
      });
    });

  }
  count_notif()async{
    await getnum();
    var responce=await FirebaseFirestore.instance.collection('users').doc('${numr.last}').collection('notification').get();
    responce.docs.forEach((element) {
      setState(() {
        cou.add(element.data()['name']);
      });
    });
    print(cou);
  }



  @override
  void initState() {
    super.initState();
    getnum();
    count_notif();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading:Image.asset("images/TT.png",width:100),
        actions: [
          NamedIcon(

            iconData: Icons.notifications,
            notificationCount: cou.length,
            onTap: () {
              setState(() {
                Navigator.of(context).push(MaterialPageRoute(builder: (context)=>notif()));
              });
            },
          ),
          IconButton(
            icon:Icon(Icons.messenger),
            onPressed: () {
              setState(() {
                Navigator.of(context).push(MaterialPageRoute(builder: (context)=>ChatScreen()));
              });
            },)
        ],

      ),
      resizeToAvoidBottomInset: true,

      body:



      Column(
        children: [

          Expanded(
            child: Container(

              margin: EdgeInsets.only(left: 20, right: 20, bottom: 30),

              child: Stack(

                  children: [

                    Container(
                      margin: EdgeInsets.only(top: 95, left: 90),
                      child:
                      FadeAnimation(
                        2,
                        ElevatedButton(
                          onPressed: () {
                            showModalBottomSheet(context: context,
                                isScrollControlled: true,
                                shape: const RoundedRectangleBorder(
                                  borderRadius: BorderRadius.vertical(
                                    top: Radius.circular(40.0),
                                  ),
                                ), builder: (context) {
                                  return SingleChildScrollView(
                                    padding: EdgeInsets.only(
                                        bottom: MediaQuery
                                            .of(context)
                                            .viewInsets
                                            .bottom),
                                    child: Container(

                                      alignment: Alignment.center,

                                      child:
                                      GestureDetector(
                                          onTap: () {
                                            FocusScope.of(context).unfocus();
                                          },
                                          child: Column(
                                            children: [
                                              Container(
                                                height: 20,
                                                alignment: Alignment.center,
                                                child:
                                                Icon(Icons.remove),
                                              ),
                                              Container(
                                                height: 60,
                                                width: double.infinity,
                                                alignment: Alignment.center,

                                                child:
                                                Text("Consomation",
                                                  style: TextStyle(
                                                      fontSize: 30,
                                                      fontWeight: FontWeight
                                                          .w400),),
                                              ),
                                              SingleChildScrollView(
                                                scrollDirection: Axis
                                                    .horizontal,
                                                physics: BouncingScrollPhysics(),
                                                child:
                                                FutureBuilder<DocumentSnapshot>(
                                                  future: users.doc('${numr.last}').get(),
                                                  builder:
                                                      (BuildContext context, AsyncSnapshot<
                                                      DocumentSnapshot> snapshot) {
                                                    if (snapshot.connectionState ==
                                                        ConnectionState.done) {
                                                      Map<String, dynamic> data = snapshot.data!
                                                          .data() as Map<String, dynamic>;
                                                      return Row(

                                                        children:<Widget>[
                                                          Container(alignment: Alignment.center,
                                                            margin: EdgeInsets.all(10),
                                                            decoration:
                                                            BoxDecoration(border: Border.all(width: 14,color: Colors.blue),shape: BoxShape.circle ),
                                                            height: 120,
                                                            width: 120,
                                                            child:
                                                            Column(
                                                              children: [
                                                                Expanded(flex: 1,child: Container(width: 130,decoration: BoxDecoration(color: Colors.blue,borderRadius:BorderRadius.only(topLeft: Radius.circular(60),topRight:Radius.circular(60) )),child: Center(child: Text("Solde",style: TextStyle(fontSize: 20,color: Colors.white),),),)),
                                                                Expanded(flex: 2,child: Container(child:Center(child: Text(" ${data['solde'].toStringAsFixed(3)} Dt ",style: TextStyle(color: Colors.black54,fontSize: 20),)),)),
                                                                Expanded(flex: 1,child: Container(child:Icon(Icons.account_balance_wallet_outlined,size: 25,))),
                                                              ],),
                                                          ),
                                                          Container(alignment: Alignment.center,
                                                            margin: EdgeInsets.all(10),
                                                            decoration:
                                                            BoxDecoration(border: Border.all(width: 14,color: Colors.blue),shape: BoxShape.circle ),
                                                            height: 120,
                                                            width: 120,
                                                            child:
                                                            Column(
                                                              children: [
                                                                Expanded(flex: 1,child: Container(width: 130,decoration: BoxDecoration(color: Colors.blue,borderRadius:BorderRadius.only(topLeft: Radius.circular(60),topRight:Radius.circular(60) )),child: Center(child: Text("Internet",style: TextStyle(fontSize: 20,color: Colors.white),),),)),
                                                                Expanded(flex: 2,child: Container(child:Center(child: Text(" ${(data['internet']).toStringAsFixed(1)} Go",textAlign: TextAlign.center,style: TextStyle(color: Colors.black54,fontSize: 20),)),)),
                                                                Expanded(flex: 1,child: Container(child:Icon(Icons.wifi_tethering,size: 25,))),
                                                              ],),
                                                          ),
                                                          Container(alignment: Alignment.center,
                                                            margin: EdgeInsets.all(10),
                                                            decoration:
                                                            BoxDecoration(border: Border.all(width: 14,color: Colors.blue),shape: BoxShape.circle ),
                                                            height: 120,
                                                            width: 120,
                                                            child:
                                                            Column(
                                                              children: [
                                                                Expanded(flex: 1,child: Container(width: 130,decoration: BoxDecoration(color: Colors.blue,borderRadius:BorderRadius.only(topLeft: Radius.circular(60),topRight:Radius.circular(60) )),child: Center(child: Text("Appel",style: TextStyle(fontSize: 20,color: Colors.white),),),)),
                                                                Expanded(flex: 2,child: Container(child:Center(child: Text(" ${data['appel']} ",style: TextStyle(color: Colors.black54,fontSize: 20),)),)),
                                                                Expanded(flex: 1,child: Container(child:Icon(Icons.phone,size: 25,))),
                                                              ],),
                                                          ),
                                                          Container(alignment: Alignment.center,
                                                            margin: EdgeInsets.all(10),
                                                            decoration:
                                                            BoxDecoration(border: Border.all(width: 14,color: Colors.blue),shape: BoxShape.circle ),
                                                            height: 120,
                                                            width: 120,
                                                            child:
                                                            Column(
                                                              children: [
                                                                Expanded(flex: 1,child: Container(width: 130,decoration: BoxDecoration(color: Colors.blue,borderRadius:BorderRadius.only(topLeft: Radius.circular(60),topRight:Radius.circular(60) )),child: Center(child: Text("SMS",style: TextStyle(fontSize: 20,color: Colors.white),),),)),
                                                                Expanded(flex: 2,child: Container(child:Center(child: Text(" ${data['sms']} ",style: TextStyle(color: Colors.black54,fontSize: 25),)),)),
                                                                Expanded(flex: 1,child: Container(child:Icon(Icons.messenger,size: 25,))),
                                                              ],),
                                                          ),
                                                        ],
                                                      );
                                                    }

                                                    return Text("loading");
                                                  },
                                                ),
                                              ),
                                            ],
                                          )
                                      ),
                                    ),

                                  );
                                });
                          },
                          style: ElevatedButton.styleFrom(


                              padding: EdgeInsets.zero,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20))),
                          child: Ink(
                            decoration: BoxDecoration(
                                gradient: const LinearGradient(colors: [
                                  Colors.lightBlue,
                                  Colors.lightGreen,
                                ]),
                                borderRadius: BorderRadius.circular(20)),
                            child: Container(
                              width: 200,
                              height: 30,
                              alignment: Alignment.center,
                              child: const Text(
                                'Suivie soldes',
                                style: TextStyle(
                                  fontSize: 20,
                                  color: Colors.white,

                                ),
                              ),
                            ),
                          ),
                        ),
                      ),

                    ),


                    MaterialButton(

                      onPressed: () {
                        showModalBottomSheet(context: context,
                            isScrollControlled: true,
                            shape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.vertical(
                                top: Radius.circular(40.0),
                              ),
                            ), builder: (context) {
                              return SingleChildScrollView(
                                padding: EdgeInsets.only(bottom: MediaQuery
                                    .of(context)
                                    .viewInsets
                                    .bottom),
                                child: Container(

                                  alignment: Alignment.topCenter,

                                  child:
                                  GestureDetector(
                                    onTap: () {
                                      FocusScope.of(context).unfocus();
                                    },
                                    child: Column(

                                      children: [
                                        Center(
                                          child: Stack(
                                            children: [
                                              Container(
                                                width: 130,
                                                height: 130,
                                                decoration: BoxDecoration(
                                                    border: Border.all(
                                                        width: 4,
                                                        color: Theme
                                                            .of(context)
                                                            .scaffoldBackgroundColor),
                                                    boxShadow: [
                                                      BoxShadow(
                                                          spreadRadius: 2,
                                                          blurRadius: 10,
                                                          color: Colors.black
                                                              .withOpacity(
                                                              0.5),
                                                          offset: Offset(
                                                              0, 10))
                                                    ],
                                                    shape: BoxShape.circle,
                                                    image: DecorationImage(
                                                        fit: BoxFit.cover,
                                                        image: AssetImage(
                                                            "images/avatar.png"))),
                                              ),
                                              Positioned(
                                                  bottom: 0,
                                                  right: 0,
                                                  child: Container(
                                                    height: 40,
                                                    width: 40,
                                                    decoration: BoxDecoration(
                                                      shape: BoxShape.circle,
                                                      border: Border.all(
                                                        width: 4,
                                                        color: Theme
                                                            .of(context)
                                                            .scaffoldBackgroundColor,
                                                      ),
                                                      color: Colors.green,
                                                    ),
                                                    child: Icon(
                                                      Icons.edit,
                                                      color: Colors.white,
                                                    ),
                                                  )),
                                            ],
                                          ),
                                        ),
                                        SizedBox(
                                          height: 35,
                                        ),
                                        Container(
                                          margin: EdgeInsets.only(
                                              left: 20, right: 20),
                                          child: Column(
                                            children: [
                                              TextFormField(
                                                controller: name,
                                                decoration: InputDecoration(
                                                    border: OutlineInputBorder(
                                                      borderRadius: BorderRadius
                                                          .circular(20),
                                                      borderSide: BorderSide(
                                                        color: Colors.black,
                                                        width: 5.0,

                                                      ),
                                                    ),

                                                    contentPadding: EdgeInsets
                                                        .only(
                                                        left: 10, bottom: 3),
                                                    labelText: "full Name",
                                                    floatingLabelBehavior: FloatingLabelBehavior
                                                        .always,
                                                    hintStyle: TextStyle(
                                                      fontSize: 16,
                                                      fontWeight: FontWeight
                                                          .bold,
                                                      color: Colors.black,
                                                    )),
                                              ),
                                              SizedBox(
                                                height: 35,
                                              ),
                                              TextFormField(
                                                controller: pass,
                                                decoration: InputDecoration(
                                                    border: OutlineInputBorder(
                                                      borderRadius: BorderRadius
                                                          .circular(20),
                                                      borderSide: BorderSide(
                                                        color: Colors.black,
                                                        width: 5.0,

                                                      ),
                                                    ),

                                                    contentPadding: EdgeInsets
                                                        .only(
                                                        left: 10, bottom: 3),
                                                    labelText: "Password",
                                                    floatingLabelBehavior: FloatingLabelBehavior
                                                        .always,
                                                    hintStyle: TextStyle(
                                                      fontSize: 16,
                                                      fontWeight: FontWeight
                                                          .bold,
                                                      color: Colors.black,
                                                    )),
                                              ),
                                            ],
                                          ),
                                        ),


                                        MaterialButton(
                                          onPressed: () {
                                            update();
                                            setState(() {});
                                            Navigator.of(context).pop();
                                          },
                                          color: Colors.green,
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 50),
                                          elevation: 2,
                                          shape: RoundedRectangleBorder(
                                              borderRadius: BorderRadius
                                                  .circular(20)),
                                          child: Text(
                                            "SAVE",
                                            style: TextStyle(
                                                fontSize: 14,
                                                letterSpacing: 2.2,
                                                color: Colors.white),
                                          ),
                                        ),

                                        Container(
                                          margin: EdgeInsets.only(bottom: 20),
                                          child: Center(
                                            child: MaterialButton(
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: 40),
                                              shape: RoundedRectangleBorder(
                                                  borderRadius: BorderRadius
                                                      .circular(20)
                                              ),
                                              color: Colors.red,
                                              onPressed: () {
                                                Navigator.pushAndRemoveUntil(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          login()),
                                                      (Route<
                                                      dynamic> route) => false,
                                                );
                                              },
                                              child: Text("SIGN OUT",
                                                  style: TextStyle(
                                                      fontSize: 16,
                                                      letterSpacing: 2.2,
                                                      color: Colors.white)),
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ),

                              );
                            });
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(49),
                          image: DecorationImage(
                            image: AssetImage("images/bg.jpg"),
                            fit: BoxFit.cover,
                          ),
                        ),
                        child: Row(

                          children: [
                            Container(
                              child: CircleAvatar(maxRadius: 50,
                                backgroundImage: AssetImage(
                                    "images/avatar.png"),
                              ),
                            ),
                            Container(

                              padding: EdgeInsets.only(left: 10),
                              height: 40,
                              child:

                              FutureBuilder<DocumentSnapshot>(

                                future: users.doc('${numr.last}').get(),
                                builder:
                                    (BuildContext context, AsyncSnapshot<
                                    DocumentSnapshot> snapshot) {

                                  if (snapshot.connectionState ==
                                      ConnectionState.done) {
                                    Map<String, dynamic> data = snapshot.data!
                                        .data() as Map<String, dynamic>;
                                    return Column(
                                      children: [
                                        Text("${data['nom']} ",
                                          style: TextStyle(fontSize: 17,
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold),),
                                        Text(" ${data['numero']}",
                                          style: TextStyle(fontSize: 17,
                                              color: Colors.white),),
                                      ],
                                    );
                                  }

                                  return Text("loading");
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),


                    Container(

                      alignment: Alignment.center,
                      margin: EdgeInsets.only(
                          top: 160),
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.blue, width: 2),
                          borderRadius: BorderRadius.circular(20)
                      ),
                      child:
                      StreamBuilder<QuerySnapshot>(
                          stream:   FirebaseFirestore.instance.collection('users').doc('${numr.last}').collection('cost').orderBy('date',descending: true).snapshots(),
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
                                  Widget text() {
                                    late Widget t;
                                    if (hist['internet']>0&&hist['appel']>0&&hist['sms']>0) {
                                      t= Text(
                                        "${hist['internet']}Go + ${hist['appel']} Min + ${hist['sms']} Sms",
                                        style: const TextStyle(fontSize: 17),
                                      );
                                    } else if (hist['internet']>0&&hist['appel']==0&&hist['sms']==0){
                                      t= Text(
                                        "${hist['internet']}Go ",
                                        style: const TextStyle(fontSize: 17),
                                      );
                                    } else if (hist['internet']>0&&hist['appel']>0&&hist['sms']==0){
                                      t= Text(
                                        "${hist['internet']}Go + ${hist['appel']} Min ",
                                        style: const TextStyle(fontSize: 17),
                                      );
                                    }else if (hist['internet']>0&&hist['appel']==0&&hist['sms']>0){
                                      t= Text(
                                        "${hist['internet']}Go + ${hist['sms']} Sms ",
                                        style: const TextStyle(fontSize: 17),
                                      );
                                    }else if (hist['internet']==0&&hist['appel']>0&&hist['sms']>0){
                                      t= Text(
                                        "${hist['appel']}Min + ${hist['sms']} Sms ",
                                        style: const TextStyle(fontSize: 17),
                                      );
                                    }else if (hist['internet']==0&&hist['appel']>0&&hist['sms']==0){
                                      t= Text(
                                        "${hist['appel']} Min ",
                                        style: const TextStyle(fontSize: 17),
                                      );
                                    }else if (hist['internet']==0&&hist['appel']==0&&hist['sms']>0){
                                      t= Text(
                                        " ${hist['sms']} Sms ",
                                        style: const TextStyle(fontSize: 17),
                                      );
                                    }else if (hist['internet']==0&&hist['appel']==0&&hist['sms']==0){
                                      t= Text("",
                                        style: const TextStyle(fontSize: 17),
                                      );
                                    }
                                    return t;
                                  }
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
                                            title: text(),
                                            subtitle: Column(
                                              children: [
                                                SizedBox(height: 5),
                                                Container(alignment: Alignment.topLeft,child: Text("Prix : ${hist['prix'].toStringAsFixed(3)} dt",style: TextStyle(color: Colors.black,fontSize: 15,),)),
                                                Container(child: Text("${Jiffy(DateTime.parse(hist['date'].toDate().toString())).format("d/M/y   HH:mm")}")),
                                              ],
                                            ),

                                            trailing:IconButton(
                                              icon: Icon(Icons.delete),
                                              onPressed: (){
                                                FirebaseFirestore.instance.collection('users').doc('${numr.last}').collection('cost').doc(hist.id).delete();

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


                    Positioned(
                        left: 50,
                        top: 150,
                        child:
                        Container(
                            padding: EdgeInsets.only(left: 10, right: 10),
                            color: Colors.white,
                            child:
                            Text("HISTORIQUE", style: TextStyle(
                                fontSize: 15, fontWeight: FontWeight.bold),)
                        )
                    )

                  ]),
            ),
          ),

        ],
      ),


    );
  }
  update(){
    CollectionReference usersref =
    FirebaseFirestore.instance
        .collection("users");
    if(pass.text==""){
      usersref.doc('${numr.last}').update(
          {
            "nom": "${name.text}",
          }
      );
    }else  if(name.text==""){
      usersref.doc('${numr.last}').update(
          {
            "pass": "${pass.text}",
          }
      );
    }else{
      usersref.doc('${numr.last}').update(
          {
            "nom": "${name.text}",
            "pass": "${pass.text}",
          }
      );
    }
    name.text="";
    pass.text="";
  }
}