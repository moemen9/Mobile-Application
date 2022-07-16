import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:offre/descServ.dart';


class services extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<services> {

  ScrollController controller = ScrollController();
  bool closeTopContainer = false;
  double topContainer = 0;
  final Stream<QuerySnapshot> serv = FirebaseFirestore.instance.collection('service').snapshots();


  @override
  void initState() {
    super.initState();

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
          IconButton(icon: Icon(Icons.search,size: 30,), onPressed: () {
            showSearch(context: context, delegate: recherche());
          },)
        ],
      ),
      backgroundColor: Colors.white,
      body:
      Container(
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
                        stream:  serv,
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
                                int ind=index;
                                double scale = 1.0;
                                if (topContainer > 0.5) {
                                  scale = index + 0.5 - topContainer;
                                  if (scale < 0) {
                                    scale = 0;
                                  } else if (scale > 1) {
                                    scale = 1;
                                  }
                                }
                                DocumentSnapshot service = snapshot.data!.docs[index];

                                Widget text() {
                                  late Widget t;
                                  if (service['internet']>0&&service['appel']>0&&service['sms']>0) {
                                    t= Text(
                                      "${service['internet']}Mo + ${service['appel']} Min + ${service['sms']} Sms",
                                      style: const TextStyle(fontSize: 17, color: Colors.black54),
                                    );
                                  } else if (service['internet']>0&&service['appel']==0&&service['sms']==0){
                                    t= Text(
                                      "${service['internet']}Mo ",
                                      style: const TextStyle(fontSize: 17, color: Colors.black54),
                                    );
                                  } else if (service['internet']>0&&service['appel']>0&&service['sms']==0){
                                    t= Text(
                                      "${service['internet']}Mo + ${service['appel']} Min ",
                                      style: const TextStyle(fontSize: 17, color: Colors.black54),
                                    );
                                  }else if (service['internet']>0&&service['appel']==0&&service['sms']>0){
                                    t= Text(
                                      "${service['internet']}Mo + ${service['sms']} Sms ",
                                      style: const TextStyle(fontSize: 17, color: Colors.black54),
                                    );
                                  }else if (service['internet']==0&&service['appel']>0&&service['sms']>0){
                                    t= Text(
                                      "${service['appel']}Min + ${service['sms']} Sms ",
                                      style: const TextStyle(fontSize: 17, color: Colors.black54),
                                    );
                                  }else if (service['internet']==0&&service['appel']>0&&service['sms']==0){
                                    t= Text(
                                      "${service['appel']} Min ",
                                      style: const TextStyle(fontSize: 17, color: Colors.black54),
                                    );
                                  }else if (service['internet']==0&&service['appel']==0&&service['sms']>0){
                                    t= Text(
                                      " ${service['sms']} Sms ",
                                      style: const TextStyle(fontSize: 17, color: Colors.black54),
                                    );
                                  }else if (service['internet']==0&&service['appel']==0&&service['sms']==0){
                                    t= Text(
                                      "  ",
                                      style: const TextStyle(fontSize: 17, color: Colors.black54),
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
                                                Navigator.of(context).push(MaterialPageRoute(builder: (context)=>descser(service:service)));
                                              });

                                            },
                                            child: Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              children: <Widget>[

                                                Column(
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: <Widget>[
                                                    Text(
                                                      service["name"],
                                                      style: const TextStyle(fontSize: 20, color: Colors.black87,fontWeight: FontWeight.bold),
                                                    ),
                                                    SizedBox(
                                                      height: 10,
                                                    ),
                                                    SizedBox(
                                                      height: 10,
                                                    ),

                                                  ],
                                                ),
                                                Expanded(
                                                  child: Container(
                                                    height: double.infinity,
                                                    width: double.infinity,
                                                    child: Image.network(
                                                      "${service["img"]}",
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
              stream:  FirebaseFirestore.instance.collection('service').where('name',isEqualTo:query ).snapshots(),
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

                      DocumentSnapshot service = snapshot.data!.docs[index];


                      return GestureDetector(
                          onTap: (){
                            Navigator.of(context).push(MaterialPageRoute(builder: (context)=>descser(service:service)));
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
                                    title: Text(service['name']),
                                    subtitle: Column(
                                      crossAxisAlignment:CrossAxisAlignment.center,
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        SizedBox(height: 5),
                                        Container(alignment: Alignment.topLeft,child: Text("Prix : ${service['price'].toStringAsFixed(3)} dt",style: TextStyle(color: Colors.black,fontSize: 15,),)),

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