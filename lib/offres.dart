import 'dart:async';
import 'descOff.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:jiffy/jiffy.dart';


class offres extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return Offres();
  }

}
class Offres extends State<offres> {



  var t1, t2, t3;
  num counter = 0;
  num prix = 0;
  num solde = 0;
  num internet = 0;
  num appel = 0;
  num sms= 0;
  num counter_sms = 0;
  num counter_app = 0;
  var date="";
  List numr=[0];
  List list_offre=[];
  bool _buttonPressed = false;
  bool _loopActive = false;
  CollectionReference usersref = FirebaseFirestore.instance.collection("users");

  ScrollController controller = ScrollController();
  bool closeTopContainer = false;
  double topContainer = 0;

  final Stream<QuerySnapshot> offr = FirebaseFirestore.instance.collection('offre').snapshots();



  void prixTotal(counter, counter_sms, counter_app) {
    setState(() {
      prix = ((counter * 450) + (counter_app * 30.4) + (counter_sms * 10));
    });
  }

  void internet_plus() {
    setState(() {
      counter = counter + 100;
      prix = ((counter * 5) + (counter_app * 30.4) + (counter_sms * 10));
      date="valable jusqu'a : ${Jiffy(DateTime.now().add(Duration(days: 30))).format("d/M/y")}";
    });

  }
  void internet_plus_long() async {
    if (_loopActive) return;

    _loopActive = true;

    while (_buttonPressed) {
      setState(() {
        counter = counter + 100;
        prix = ((counter * 5) + (counter_app * 30.4) + (counter_sms * 10));
        date="valable jusqu'a : ${Jiffy(DateTime.now().add(Duration(days: 30))).format("d/M/y")}";
      });


      await Future.delayed(Duration(milliseconds: 100));
    }

    _loopActive = false;

  }
  void internet_moin() {
    if (counter > 0) {
      setState(() {
        counter = counter - 100;
        date="valable jusqu'a : ${Jiffy(DateTime.now().add(Duration(days: 30))).format("d/M/y")}";
        prix = ((counter * 5) + (counter_app * 30.4) + (counter_sms * 10));
      });
    } if(prix==0){
      date="";
    }
  }
  void internet_moin_long() async {
    if (_loopActive) return;

    _loopActive = true;

    while (_buttonPressed) {

      if (counter > 0) {
        setState(() {
          counter = counter - 100;
          date="valable jusqu'a : ${Jiffy(DateTime.now().add(Duration(days: 30))).format("d/M/y")}";
          prix = ((counter * 5) + (counter_app * 30.4) + (counter_sms * 10));
        });
      } if(prix==0){
        date="";
      }


      await Future.delayed(Duration(milliseconds: 100));
    }

    _loopActive = false;

  }

  void app_plus() {
    setState(() {
      counter_app++;
      date="valable jusqu'a : ${Jiffy(DateTime.now().add(Duration(days: 30))).format("d/M/y")}";
      prix = ((counter * 5) + (counter_app * 30.4) + (counter_sms * 10));
    });
  }
  void app_plus_long() async {
    if (_loopActive) return;

    _loopActive = true;

    while (_buttonPressed) {

      setState(() {
        counter_app++;
        date="valable jusqu'a : ${Jiffy(DateTime.now().add(Duration(days: 30))).format("d/M/y")}";
        prix = ((counter * 5) + (counter_app * 30.4) + (counter_sms * 10));
      });
      await Future.delayed(Duration(milliseconds: 100));
    }

    _loopActive = false;

  }

  void app_moin() {
    if (counter_app > 0) {
      setState(() {
        counter_app--;
        date="valable jusqu'a : ${Jiffy(DateTime.now().add(Duration(days: 30))).format("d/M/y")}";
        prix = ((counter * 5) + (counter_app * 30.4) + (counter_sms * 10));
      });
    } if(prix==0){
      date="";
    }
  }
  void app_moin_long() async {
    if (_loopActive) return;

    _loopActive = true;

    while (_buttonPressed) {
      if (counter_app > 0) {
        setState(() {
          counter_app--;
          date="valable jusqu'a : ${Jiffy(DateTime.now().add(Duration(days: 30))).format("d/M/y")}";
          prix = ((counter * 5) + (counter_app * 30.4) + (counter_sms * 10));
        });
      } if(prix==0){
        date="";
      }

      await Future.delayed(Duration(milliseconds: 100));
    }

    _loopActive = false;

  }
  void sms_plus() {
    setState(() {
      counter_sms++;
      date="valable jusqu'a : ${Jiffy(DateTime.now().add(Duration(days: 30))).format("d/M/y")}";
      prix = ((counter * 5) + (counter_app * 30.4) + (counter_sms * 10));
    });
  }
  void sms_plus_long() async {
    if (_loopActive) return;

    _loopActive = true;

    while (_buttonPressed) {

      setState(() {
        counter_sms++;
        date="valable jusqu'a : ${Jiffy(DateTime.now().add(Duration(days: 30))).format("d/M/y")}";
        prix = ((counter * 5) + (counter_app * 30.4) + (counter_sms * 10));
      });
      await Future.delayed(Duration(milliseconds: 100));
    }

    _loopActive = false;

  }

  void sms_moin() {
    if (counter_sms > 0) {
      setState(() {
        counter_sms--;
        date="valable jusqu'a : ${Jiffy(DateTime.now().add(Duration(days: 30))).format("d/M/y")}";
        prix = ((counter * 5) + (counter_app * 30.4) + (counter_sms * 10));
      });
    } if(prix==0){
      date="";
    }
  }
  void sms_moin_long() async {
    if (_loopActive) return;

    _loopActive = true;

    while (_buttonPressed) {
      if (counter_sms > 0) {
        setState(() {
          counter_sms--;
          date="valable jusqu'a : ${Jiffy(DateTime.now().add(Duration(days: 30))).format("d/M/y")}";
          prix = ((counter * 5) + (counter_app * 30.4) + (counter_sms * 10));
        });
      } if(prix==0){
        date="";
      }
      await Future.delayed(Duration(milliseconds: 100));
    }

    _loopActive = false;

  }
void affiche(){
  Fluttertoast.showToast(
      msg: "Achat effectue Avec Succeés",
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
      backgroundColor: Colors.deepPurpleAccent,
      textColor: Colors.white,
      fontSize: 22.0
  );
}
  get_offr()async{
    var responce=await FirebaseFirestore.instance.collection('offre').get();

    responce.docs.forEach((element) {
      setState(() {
        list_offre.add((element.data() as dynamic)['name']);
      });
    });
  }
  getnum()async{
    var responce=await FirebaseFirestore.instance.collection('variable').get();

    responce.docs.forEach((element) {
      setState(() {
        numr.add((element.data() as dynamic)['var']);
      });
    });

  }
get_user_data()async{
    await getnum();
  var responce=await FirebaseFirestore.instance.collection('users').where('numero',isEqualTo: numr.last).get();

  responce.docs.forEach((element) {
    setState(() {
      solde=(element.data()as dynamic)['solde'];
      internet=(element.data()as dynamic)['internet'];
      appel=(element.data()as dynamic)['appel'];
      sms=(element.data()as dynamic)['sms'];
    });
  });
}





  @override
  void initState() {
    super.initState();
    get_offr();
    getnum();
    get_user_data();
    controller.addListener(() {

      double value = controller.offset/119;

      setState(() {
        topContainer = value;
        closeTopContainer = controller.offset > 50;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final double categoryHeight = size.height*0.30;
    return Scaffold(
      appBar: AppBar(
        leading:Image.asset("images/TT.png",width:100),
        actions: [
          IconButton(icon: Icon(Icons.search,size: 30), onPressed: () { showSearch(context: context, delegate: recherche()); },)
        ],
      ),
      backgroundColor: Colors.white,
      body:

      Container(
          alignment: Alignment.center,
          child:
          Column(children: [

            Container(

              margin: EdgeInsets.only(top: 15),
              child:
              Column(
                  children: [
                    Center(
                      child:
                      Icon(
                        Icons.add_shopping_cart, size: 60, color: Colors.blue,),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 13),
                      child:
                      Row(
                        children: [

                          Expanded(
                            flex: 1,
                            child:

                            Column(
                              children: [
                                Container(
                                  padding: EdgeInsets.only(bottom: 10),
                                  child:
                                  Text("Internet(Mo)",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 15),
                                  ),
                                ),


                                Container(
                                    margin: EdgeInsets.only(
                                        left: 10, right: 10),
                                    decoration: BoxDecoration(
                                        border: Border.all(color: Colors.blue),
                                        borderRadius: BorderRadius.circular(
                                            20)),
                                    child:
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment
                                          .spaceBetween,
                                      children: [
                                        GestureDetector(
                                          onLongPress: (){
                                            _buttonPressed = true;
                                            internet_moin_long();
                                          },
                                          onLongPressUp: (){
                                            _buttonPressed = false;
                                          },
                                          child: Container(alignment: Alignment.center,
                                              height: 35,
                                              width: 35,
                                              decoration: BoxDecoration(
                                                  color: Colors.blue,
                                                  borderRadius: BorderRadius
                                                      .circular(30)),
                                              child: IconButton(
                                                  onPressed: internet_moin,
                                                  icon: Icon(Icons.remove,
                                                    color: Colors.white,))),
                                        ),
                                        Text('$counter'),
                                        GestureDetector(
                                          onLongPress: (){
                                            _buttonPressed = true;
                                            internet_plus_long();
                                          },
                                          onLongPressUp: (){
                                            _buttonPressed = false;
                                          },
                                          child: Container(alignment: Alignment.center,
                                              height: 35,
                                              width: 35,
                                              decoration: BoxDecoration(
                                                  color: Colors.blue,
                                                  borderRadius: BorderRadius
                                                      .circular(30)),
                                              child: IconButton(
                                                  onPressed: internet_plus,
                                                  icon: Icon(Icons.add,
                                                    color: Colors.white,))),
                                        ),
                                      ],)
                                ),
                              ],
                            ),
                          ),

                          Expanded(
                            flex: 1,
                            child:
                            Column(
                              children: [
                                Container(
                                  padding: EdgeInsets.only(bottom: 10),
                                  child:
                                  Text("Appeles(min)",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 15),
                                  ),
                                ),
                                Container(
                                    margin: EdgeInsets.only(
                                        left: 10, right: 10),
                                    decoration: BoxDecoration(
                                        border: Border.all(color: Colors.blue),
                                        borderRadius: BorderRadius.circular(
                                            20)),
                                    child:
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment
                                          .spaceBetween,
                                      children: [
                                        GestureDetector(
                                          onLongPress: (){
                                            _buttonPressed = true;
                                            app_moin_long();
                                          },
                                          onLongPressUp: (){
                                            _buttonPressed = false;
                                          },
                                          child: Container(alignment: Alignment.center,
                                              height: 35,
                                              width: 35,
                                              decoration: BoxDecoration(
                                                  color: Colors.blue,
                                                  borderRadius: BorderRadius
                                                      .circular(30)),
                                              child: IconButton(
                                                  onPressed: app_moin,
                                                  icon: Icon(Icons.remove,
                                                    color: Colors.white,))),
                                        ),
                                        Text("$counter_app"),
                                        GestureDetector(
                                          onLongPress: (){
                                            _buttonPressed = true;
                                            app_plus_long();
                                          },
                                          onLongPressUp: (){
                                            _buttonPressed = false;
                                          },
                                          child: Container(alignment: Alignment.center,
                                              height: 35,
                                              width: 35,
                                              decoration: BoxDecoration(
                                                  color: Colors.blue,
                                                  borderRadius: BorderRadius
                                                      .circular(30)),
                                              child:

                                                   IconButton(
                                                     onPressed: () {
                                                       app_plus();
                                                     },
                                                     icon: Icon(Icons.add,
                                                        color: Colors.white),
                                                   )),
                                        ),
                                      ],)
                                ),
                              ],
                            ),
                          ),

                          Expanded(
                            flex: 1,
                            child:
                            Column(
                              children: [
                                Container(
                                  padding: EdgeInsets.only(bottom: 10),
                                  child:
                                  Text("SMS",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 15),
                                  ),
                                ),
                                Container(
                                    margin: EdgeInsets.only(
                                        left: 10, right: 10),
                                    decoration: BoxDecoration(
                                        border: Border.all(color: Colors.blue),
                                        borderRadius: BorderRadius.circular(
                                            20)),
                                    child:
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment
                                          .spaceBetween,
                                      children: [
                                        GestureDetector(
                                          onLongPress: (){
                                            _buttonPressed = true;
                                            sms_moin_long();
                                          },
                                          onLongPressUp: (){
                                            _buttonPressed = false;
                                          },
                                          child: Container(alignment: Alignment.center,
                                              height: 35,
                                              width: 35,
                                              decoration: BoxDecoration(
                                                  color: Colors.blue,
                                                  borderRadius: BorderRadius
                                                      .circular(30)),
                                              child: IconButton(
                                                  onPressed: sms_moin,
                                                  icon: Icon(Icons.remove,
                                                      color: Colors.white))),
                                        ),
                                        Text("$counter_sms"),
                                        GestureDetector(
                                          onLongPress: (){
                                            _buttonPressed = true;
                                            sms_plus_long();
                                          },
                                          onLongPressUp: (){
                                            _buttonPressed = false;
                                          },
                                          child: Container(alignment: Alignment.center,
                                              height: 35,
                                              width: 35,
                                              decoration: BoxDecoration(
                                                  color: Colors.blue,
                                                  borderRadius: BorderRadius
                                                      .circular(30)),
                                              child: IconButton(
                                                  onPressed: sms_plus,
                                                  icon: Icon(Icons.add,
                                                      color: Colors.white))),
                                        ),
                                      ],)
                                ),
                              ],
                            ),
                          ),

                        ],)
                      ,
                    ),
                  ]),
            ),
            Container(
                alignment: Alignment.center,
                child:
                Column(

                  children: [

                    Row(
                        children: [
                          Container(

                              margin: EdgeInsets.only(top: 15),
                              child: Text(
                                "Total", style: TextStyle(fontWeight: FontWeight
                                  .bold, fontSize: 18),)
                          ),

                          Container(
                            margin: EdgeInsets.only(top: 15, left: 10),
                            padding: EdgeInsets.all(5),
                            width: 90,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                                border: Border.all(color: Colors.blue,
                                    width: 3),
                                borderRadius: BorderRadius.circular(20)),
                            child:
                            Text("${(prix / 1000).toStringAsFixed(3)} Dt",),
                          ),

                        ]),
                    SizedBox(height: 10),
                    Text(date),

                    Container(
                        margin: EdgeInsets.only(top: 10),
                        child: MaterialButton(
                          color: Colors.blue,
                          textColor: Colors.white,

                          onPressed: () {
                            showDialog(context: context, builder: (context) {
                              return AlertDialog(

                                title: Text(
                                    "prix : ${(prix/1000) } Dt"),
                                actions: [
                                  ElevatedButton(
                                    onPressed: () {

                                      setState(()  {
                                        prix=prix/1000;
                                        counter=counter/1000;
                                        if  (solde<prix) {
                                          Fluttertoast.showToast(
                                              msg: "Solde insuffisant",
                                              toastLength: Toast.LENGTH_SHORT,
                                              gravity: ToastGravity.BOTTOM,
                                              timeInSecForIosWeb: 1,
                                              backgroundColor: Colors.deepOrange,
                                              textColor: Colors.white,
                                              fontSize: 22.0
                                          );

                                        }
                                        else if((solde>prix)&&(counter>0)&&(counter_app==0)&&(counter_sms==0)){

                                          usersref.doc('${numr.last}').update(
                                              {
                                                "solde":solde-prix,
                                                "internet": internet + counter,
                                              }
                                          );
                                          affiche();
                                        }else if((solde>prix)&&(counter==0)&&(counter_app>0)&&(counter_sms==0)){
                                          usersref.doc('${numr.last}').update(
                                              {

                                                "solde":solde-prix,
                                                "appel": appel + counter_app,
                                              }
                                          );
                                          affiche();
                                        }else if((solde>prix)&&(counter==0)&&(counter_app==0)&&(counter_sms>0)){
                                          usersref.doc('${numr.last}').update(
                                              {

                                                "solde":solde-prix,
                                                "sms": sms + counter_sms,
                                              }
                                          );
                                          affiche();
                                        }else if((solde>prix)&&(counter>0)&&(counter_app>0)&&(counter_sms==0)){
                                          usersref.doc('${numr.last}').update(
                                              {

                                                "solde":solde-prix,
                                                "internet": internet + counter,
                                                "appel": appel + counter_app,
                                              }
                                          );
                                          affiche();
                                        }else if((solde>prix)&&(counter>0)&&(counter_app==0)&&(counter_sms>0)){
                                          usersref.doc('${numr.last}').update(
                                              {

                                                "solde":solde-prix,
                                                "internet": internet + counter,
                                                "sms": sms + counter_sms,
                                              }
                                          );
                                          affiche();
                                        }else if((solde>prix)&&(counter==0)&&(counter_app>0)&&(counter_sms>0)){
                                          usersref.doc('${numr.last}').update(
                                              {

                                                "solde":solde-prix,
                                                "appel": appel + counter_app,
                                                "sms": sms + counter_sms,
                                              }
                                          );
                                          affiche();
                                        }else if((solde>prix)&&(counter>0)&&(counter_app>0)&&(counter_sms>0)){
                                          usersref.doc('${numr.last}').update(
                                              {

                                                "solde":solde-prix,
                                                "internet": internet + counter,
                                                "appel": appel + counter_app,
                                                "sms": sms + counter_sms,
                                              }
                                          );
                                          affiche();
                                        }
                                      });
                                      if(prix>0){
                                        usersref.doc('${numr.last}').collection('cost').add(
                                            {
                                              "prix":prix,
                                              "internet": counter,
                                              "appel":counter_app,
                                              "sms":  counter_sms,
                                              "date":DateTime.now()
                                            }
                                        );
                                      }
                                    Navigator.of(context).pop();
                                    setState(() {
                                      counter=0;
                                      counter_app=0;
                                      counter_sms=0;
                                      prix=0;
                                      date="";
                                    });
                                    },
                                    child: Text("confirmer", style: TextStyle(
                                        color: Colors.white)),),
                                  MaterialButton(
                                    color: Colors.blue,
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                    child: Text("cancel", style: TextStyle(
                                        color: Colors.white)),),

                                ],
                              );
                            });
                          },
                          child: Text("Acheter"),
                        )
                    ),

                  ],)
            ),

            Expanded(
              child: SafeArea(
                child: Scaffold(
                  backgroundColor: Colors.white,
                  body: Container(
                    height: size.height,
                    child: Column(
                      children: <Widget>[

                        const SizedBox(
                          height: 10,
                        ),
                        AnimatedOpacity(
                          duration: const Duration(milliseconds: 200),
                          opacity: closeTopContainer?0:1,
                          child: AnimatedContainer(
                            duration: const Duration(milliseconds: 200),
                            width: size.width,
                            alignment: Alignment.topCenter,

                          ),
                        ),

                        Expanded(
                          child: StreamBuilder<QuerySnapshot>(
                              stream:  offr,
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

                                    controller: controller,
                                    physics: BouncingScrollPhysics(),
                                    itemCount: snapshot.data!.docs.length,
                                    itemBuilder: (context, index) {
                                      double scale = 1.0;
                                      if (topContainer > 0.5) {
                                        scale = index + 0.5 - topContainer;
                                        if (scale < 0) {
                                          scale = 0;
                                        } else if (scale > 1) {
                                          scale = 1;
                                        }
                                      }
                                      DocumentSnapshot offre = snapshot.data!.docs[index];

                                      Widget text() {
                                      late Widget t;
                                        if (offre['internet']>0&&offre['appel']>0&&offre['sms']>0) {
                                          t= Text(
                                            "${offre['internet']}Mo + ${offre['appel']} Min + ${offre['sms']} Sms",
                                            style: const TextStyle(fontSize: 17, color: Colors.grey),
                                          );
                                      } else if (offre['internet']>0&&offre['appel']==0&&offre['sms']==0){
                                        t= Text(
                                          "${offre['internet']}Mo ",
                                          style: const TextStyle(fontSize: 17, color: Colors.grey),
                                        );
                                      } else if (offre['internet']>0&&offre['appel']>0&&offre['sms']==0){
                                          t= Text(
                                            "${offre['internet']}Mo + ${offre['appel']} Min ",
                                            style: const TextStyle(fontSize: 17, color: Colors.grey),
                                          );
                                        }else if (offre['internet']>0&&offre['appel']==0&&offre['sms']>0){
                                          t= Text(
                                            "${offre['internet']}Mo + ${offre['sms']} Sms ",
                                            style: const TextStyle(fontSize: 17, color: Colors.grey),
                                          );
                                        }else if (offre['internet']==0&&offre['appel']>0&&offre['sms']>0){
                                          t= Text(
                                            "${offre['appel']}Min + ${offre['sms']} Sms ",
                                            style: const TextStyle(fontSize: 17, color: Colors.grey),
                                          );
                                        }else if (offre['internet']==0&&offre['appel']>0&&offre['sms']==0){
                                          t= Text(
                                            "${offre['appel']} Min ",
                                            style: const TextStyle(fontSize: 17, color: Colors.grey),
                                          );
                                        }else if (offre['internet']==0&&offre['appel']==0&&offre['sms']>0){
                                          t= Text(
                                            " ${offre['sms']} Sms ",
                                            style: const TextStyle(fontSize: 17, color: Colors.grey),
                                          );
                                        }else if (offre['internet']==0&&offre['appel']==0&&offre['sms']==0){
                                          t= Text("",
                                            style: const TextStyle(fontSize: 17, color: Colors.grey),
                                          );
                                        }
                                        return t;
                                    }

                                      return Opacity(
                                        opacity: scale,
                                        child: Transform(
                                          transform:  Matrix4.identity()..scale(scale,scale),
                                          alignment: Alignment.topCenter,
                                          child: Align(
                                            heightFactor: 0.7,
                                            alignment: Alignment.topCenter,
                                            child:
                                            Container(
                                              height: 150,
                                              margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                                              decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(20.0)), color: Colors.greenAccent, boxShadow: [
                                                BoxShadow(color: Colors.black.withAlpha(1000), blurRadius: 10.0),
                                              ]),
                                              child: Padding(
                                                padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
                                                child: GestureDetector(
                                                  onTap: (){
                                                    setState(() {
                                                      Navigator.of(context).push(MaterialPageRoute(builder: (context)=>des(offre:offre)));
                                                    });

                                                    },
                                                  child: Row(
                                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                    children: <Widget>[

                                                      Column(
                                                        crossAxisAlignment: CrossAxisAlignment.start,
                                                        children: <Widget>[
                                                          Text(
                                                            offre["name"],
                                                            style: const TextStyle(fontSize: 20, color: Colors.black87,fontWeight: FontWeight.bold),
                                                          ),
                                                          SizedBox(
                                                            height: 10,
                                                          ),
                                                          text(),
                                                          SizedBox(
                                                            height: 10,
                                                          ),
                                                          Text(
                                                            " ${offre["price"]} \Dt",
                                                            style: const TextStyle(fontSize: 17, color: Colors.purple, fontWeight: FontWeight.bold),
                                                          )
                                                        ],
                                                      ),
                                                      Expanded(
                                                        child: Container(
                                                          height: double.infinity,
                                                          width: double.infinity,
                                                          child: Image.network(
                                                            "${offre["img"]}",
                                                            height: double.infinity,
                                                          ),
                                                        ),
                                                      )
                                                    ],
                                                  ),
                                                ),
                                              ),

                                            ),
                                          ),
                                        ),
                                      );
                                    });
                              }
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              )
            ),

          ])
      ),
    );
  }

}


class recherche extends SearchDelegate{

  @override
  List<Widget>? buildActions(BuildContext context) {
    return[
      IconButton(icon:Icon(Icons.close), onPressed: () {
       query="";
      },
      )
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton( icon: Icon(Icons.arrow_back), onPressed: () {
      close(context, null);
    });
  }

  @override
  Widget buildResults(BuildContext context) {
    return Text("");
  }

  @override
  Widget buildSuggestions(BuildContext context) {
   return Container(
      child: query==""?
          Container()
          :Container(
          child:
          StreamBuilder<QuerySnapshot>(
              stream:  FirebaseFirestore.instance.collection('offre').where('name',isEqualTo:query ).snapshots(),
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


                    physics: BouncingScrollPhysics(),
                    itemCount: snapshot.data!.docs.length,
                    itemBuilder: (context, index) {

                      DocumentSnapshot offre = snapshot.data!.docs[index];


                      return GestureDetector(
                          onTap: (){
                            Navigator.of(context).push(MaterialPageRoute(builder: (context)=>des(offre:offre)));
                          },
                          child:Padding(
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
                                    title: Text(offre['name']),
                                    subtitle: Column(
                                      crossAxisAlignment:CrossAxisAlignment.center,
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        SizedBox(height: 5),
                                        Container(alignment: Alignment.topLeft,child: Text("Prix : ${offre['price'].toStringAsFixed(3)} dt",style: TextStyle(color: Colors.black,fontSize: 15,),)),

                                      ],
                                    ),

                                  ),
                                ),
                              ],
                            ),
                          )
                      );
                    });
              }
          )
      ),
    );
  }

}