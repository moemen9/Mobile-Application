import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class descser extends StatefulWidget {
  DocumentSnapshot service;
  descser ({required this.service});


  @override
  State<descser> createState() => _MyHomePageState(service);
}

class _MyHomePageState extends State<descser> {
  DocumentSnapshot service;
  _MyHomePageState(this.service);

  CollectionReference usersref = FirebaseFirestore.instance.collection("users");
  num solde = 0;
  num internet = 0;
  num appel = 0;
  num sms= 0;
  num c=0;
  List numr=[0];
  Map notif={};
  List l=[];
  late bool check;
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

  get_notification()async{
    await getnum();

    var responce=await FirebaseFirestore.instance.collection('users').doc('${numr.last}').collection('notification').get();

    responce.docs.forEach((element) {
      setState(() {
       notif.addAll(element.data());
      });
    });

  }


  void affiche(){
    Fluttertoast.showToast(
        msg: "le service ${service['name']} Activé Avec Succeés",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.deepPurpleAccent,
        textColor: Colors.white,
        fontSize: 22.0
    );
  }



  @override
  void initState() {
    super.initState();
    getnum();
    get_user_data();
    get_notification();

  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(

      ),
      body:
      SingleChildScrollView(
        child: Column(
          children: [
            Image.network("${service["img"]}"),
            SizedBox(
              height: 30,
            ),
            Image.network("${service["desc"]}"),
            SizedBox(
              height: 30,
            ),
            ElevatedButton(
                onPressed: (){},
                child:Container(
                    margin: EdgeInsets.only(left: 10,right: 10),
                    width: double.infinity,
                    child:
                    MaterialButton(onPressed: () {


                      showDialog(context: context, builder: (context) {
                        return AlertDialog(
                          title: Text(
                              "prix : ${service["price"]} Dt"),
                          actions: [
                            ElevatedButton(
                              onPressed: () {
                                setState(() {


                                  FirebaseFirestore.instance.collection('users').doc('${numr.last}').collection('notification').get().then((value) {


                                    value.docs.forEach((element) {
                                      if (((element.data() as dynamic)['name'] == service['name']) && ((element.data() as dynamic)['statue'] == "activer")) {
                                        setState(() {
                                          check = true;
                                        });
                                      }
                                      else{
                                        setState(() {
                                          check = false;
                                        });
                                      }
                                      setState(() {
                                        l.add(check);
                                      });
                                    }

                                    );
                                    if(l.contains(true)){
                                      Fluttertoast.showToast(
                                          msg: "le service ${service['name']} est déja activer ",
                                          toastLength: Toast.LENGTH_SHORT,
                                          gravity: ToastGravity.BOTTOM,
                                          timeInSecForIosWeb: 1,
                                          backgroundColor: Colors.deepOrange,
                                          textColor: Colors.white,
                                          fontSize: 22.0
                                      );
                                    }else{
                                      if(solde>service['price']){
                                        usersref.doc('${numr.last}').update(
                                            {
                                              "solde":solde-service['price'],
                                            }
                                        );
                                        FirebaseFirestore.instance.collection('users').doc('${numr.last}').collection('notification').add(
                                            {
                                              "name":service['name'],
                                              "statue":"activer"
                                            }
                                        );
                                        affiche();

                                      }else if  (solde<service['price']){
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

                                    }
                                  });
                                });
                                Navigator.of(context).pop();
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
                        child: Text("Activer",textAlign: TextAlign.center,)))
            )
          ],
        ),
      ),

    );
  }
}
