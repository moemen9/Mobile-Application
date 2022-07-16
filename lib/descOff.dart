import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class des extends StatefulWidget {
DocumentSnapshot offre;
  des ({required this.offre});


  @override
  State<des> createState() => _MyHomePageState(offre);
}

class _MyHomePageState extends State<des> {
DocumentSnapshot offre;
_MyHomePageState(this.offre);

CollectionReference usersref = FirebaseFirestore.instance.collection("users");
num solde = 0;
num internet = 0;
num appel = 0;
num sms= 0;
getnum()async{
  var responce=await FirebaseFirestore.instance.collection('variable').get();

  responce.docs.forEach((element) {
    setState(() {
      numr.add((element.data() as dynamic)['var']);
    });
  });

}

List numr=[0];
get_user_data()async{
  await getnum();
  print(numr.last);
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



void affiche(){
  Fluttertoast.showToast(
      msg: "Achat de l'offre ${offre['name']} effectue Avec Succeés",
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
            Image.network("${offre["img"]}"),
              SizedBox(
                height: 30,
              ),
            Image.network("${offre["desc"]}"),
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
                            "prix : ${offre["price"]} Dt"),
                        actions: [
                          ElevatedButton(
                            onPressed: () {

                              if((solde>offre['price'])&&(offre['internet']>0)&&(offre['appel']==0)&&(offre['sms']==0)){
                                usersref.doc('numr.last').update(
                                    {
                                      "solde":solde-offre['price'],
                                      "internet": internet + offre['internet']/1000,
                                    }
                                );
                                affiche();
                              }else if((solde>offre['price'])&&(offre['internet']==0)&&(offre['appel']>0)&&(offre['sms']==0)){
                                usersref.doc('numr.last').update(
                                    {
                                      "solde":solde-offre['price'],
                                      "appel": appel + offre['appel'],
                                    }
                                );
                                affiche();
                              }else if((solde>offre['price'])&&(offre['internet']==0)&&(offre['appel']==0)&&(offre['sms']>0)){
                                usersref.doc('${numr.last}').update(
                                    {
                                      "solde":solde-offre['price'],
                                      "sms": sms + offre['sms'],
                                    }
                                );
                                affiche();
                              }else if((solde>offre['price'])&&(offre['internet']>0)&&(offre['appel']>0)&&(offre['sms']==0)){
                                usersref.doc('${numr.last}').update(
                                    {
                                      "solde":solde-offre['price'],
                                      "internet": internet + offre['internet']/1000,
                                      "appel": appel + offre['appel'],
                                    }
                                );
                                affiche();
                              }else if((solde>offre['price'])&&(offre['internet']>0)&&(offre['appel']==0)&&(offre['sms']>0)){
                                usersref.doc('${numr.last}').update(
                                    {
                                      "solde":solde-offre['price'],
                                      "internet": internet + offre['internet']/1000,
                                      "sms": sms + offre['sms'],
                                    }
                                );
                                affiche();
                              }else if((solde>offre['price'])&&(offre['internet']==0)&&(offre['appel']>0)&&(offre['sms']>0)){
                                usersref.doc('${numr.last}').update(
                                    {
                                      "solde":solde-offre['price'],
                                      "appel": appel + offre['appel'],
                                      "sms": sms + offre['sms'],
                                    }
                                );
                                affiche();
                              }else if((solde>offre['price'])&&(offre['internet']>0)&&(offre['appel']>0)&&(offre['sms']>0)){
                                usersref.doc('${numr.last}').update(
                                    {
                                      "solde":solde-offre['price'],
                                      "internet": internet + offre['internet']/1000,
                                      "appel": appel + offre['appel'],
                                      "sms": sms + offre['sms'],
                                    }
                                );
                                affiche();
                              }else if  (solde<offre['price']){
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
                    child: Text("Acheter",textAlign: TextAlign.center,)))
            )
          ],
          ),
        ),

    );
  }
}
