import 'dart:ui';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'fade_animation.dart';
import 'link.dart';
class LoginForm extends StatefulWidget {
  const LoginForm({Key? key}) : super(key: key);

  @override
  State<LoginForm> createState() => _LoginFormState();

}

class _LoginFormState extends State<LoginForm> {
  GlobalKey <ScaffoldState> scaffoldkey=new GlobalKey <ScaffoldState>();
  bool _passwordVisible=true;
  late CollectionReference usersref;
  List l=[] ;
  late bool check;
  num varia=0;
  TextEditingController phone=  TextEditingController();
  TextEditingController pass=  TextEditingController();
  CollectionReference variable =FirebaseFirestore.instance.collection('variable');
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();

  }
  @override
  void dispose() {
    // Clean up the controller when the Widget is disposed
    phone.dispose();
    pass.dispose();
    super.dispose();
  }



  @override
  Widget build(BuildContext context) {

    return Form(
      key: _formKey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
              margin: const EdgeInsets.only(bottom:8),
              child:Column(
                children: <Widget>[
                  Image.asset('images/TT.png',width:140),
                ],)
          ),
          Container(
            margin: const EdgeInsets.only(bottom: 60),
            child: const Text(
              "Bienvenue",
              style: TextStyle(
                  fontSize: 35,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Milonga'

              ),
            ),
          ),

          FadeAnimation(
            2,
            Container(
                width: double.infinity,
                height: 70,
                margin: const EdgeInsets.symmetric(
                    horizontal: 20, vertical: 20),
                padding: const EdgeInsets.symmetric(
                    horizontal: 15, vertical: 5),
                decoration: BoxDecoration(
                    border: Border.all(
                        color: Colors.blueAccent, width: 1),
                    boxShadow: const [
                      BoxShadow(
                          color: Colors.blueAccent,
                          blurRadius: 10,
                          offset: Offset(1, 1)),
                    ],
                    color: Colors.white,
                    borderRadius: const BorderRadius.all(
                        Radius.circular(20))),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const Icon(Icons.phone,color:Colors.blueAccent ,),
                    Expanded(
                      child: Container(
                        margin: const EdgeInsets.only(left: 10),
                        child: TextFormField(
                          controller: phone,
                          keyboardType: TextInputType.phone,
                          textInputAction:TextInputAction.next,
                          maxLines: 1,
                          maxLength: 8,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter some text';
                            }else if (value.length < 8 || value.isEmpty) {
                              return 'invalid format number';
                            }
                            return null;
                          },
                          decoration: const InputDecoration(
                            label: Text(" Votre numéro TT"),
                            counterStyle: TextStyle(height: double.minPositive),
                            border: InputBorder.none,
                          ),
                        ),
                      ),
                    ),
                  ],
                )),
          ),

          FadeAnimation(
            2,
            Container(
                width: double.infinity,
                height: 70,
                margin: const EdgeInsets.symmetric(
                    horizontal: 20, vertical: 20),
                padding: const EdgeInsets.symmetric(
                    horizontal: 15, vertical: 5),
                decoration: BoxDecoration(
                    border: Border.all(
                        color: Colors.blueAccent, width: 1),
                    boxShadow: const [
                      BoxShadow(
                          color: Colors.blueAccent,
                          blurRadius: 10,
                          offset: Offset(1, 1)),
                    ],
                    color: Colors.white,
                    borderRadius: const BorderRadius.all(
                        Radius.circular(20))),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const Icon(Icons.lock_open_sharp,color:Colors.blueAccent ,),
                    Expanded(
                      child: Container(
                        margin: const EdgeInsets.only(left: 10),
                        child: TextFormField(
                          controller: pass,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter some text';
                            }
                            return null;
                          },
                          textInputAction: TextInputAction.done,
                          obscureText: _passwordVisible,
                          enableSuggestions: false,
                          autocorrect: false,
                          maxLines: 1,

                          decoration:  InputDecoration(
                            //---------------------------------
                            suffixIcon: IconButton(
                                icon: Icon(
                                    _passwordVisible ? Icons.visibility : Icons.visibility_off),
                                onPressed: () {
                                  setState(() {
                                    _passwordVisible = !_passwordVisible;
                                  });
                                }),
                            //-----------------------------------------
                            label: Text("Mot de passe"),
                            border: InputBorder.none,
                          ),
                        ),
                      ),
                    ),
                  ],
                )),
          ),

          const SizedBox(
            height: 20,
          ),

          FadeAnimation(
            2,
            ElevatedButton(
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  print('');
                }
                FirebaseFirestore.instance.collection('variable').doc('var').set({'var':num.parse(phone.text)});
                  setState(() {
                  usersref = FirebaseFirestore.instance.collection("users");

                  usersref.get().then((value) {
                    num ph=num.parse(phone.text);

                    value.docs.forEach((element) {
                      if (((element.data() as dynamic)['numero'] == ph) &&
                          ((element.data() as dynamic)['pass'] == "${pass.text}")) {
                        setState(() {
                          check = true;
                        });

                        Fluttertoast.showToast(
                            msg: "Login Successfuly",
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.BOTTOM,
                            timeInSecForIosWeb: 1,
                            backgroundColor: Colors.indigoAccent,
                            textColor: Colors.white,
                            fontSize: 22.0
                        );
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
                      Navigator.pushReplacement(context,MaterialPageRoute(builder: (context)=>link()));
                    }else{
                      Alert(
                        context: context,
                        type: AlertType.warning,
                        title: "Information",
                        desc: "Le numéro de téléphone ou le mot de pasee est invalide.",
                        buttons: [
                          DialogButton(
                            child: Text(
                              "OK",
                              style: TextStyle(color: Colors.white, fontSize: 20),
                            ),
                            onPressed: () => Navigator.of(context, rootNavigator: true).pop()

                            ,
                            width: 120,
                          )
                        ],
                      ).show();



                    }});
                });

              },
              style: ElevatedButton.styleFrom(
                  onPrimary: Colors.purpleAccent,
                  shadowColor: Colors.purpleAccent,
                  elevation: 18,
                  padding: EdgeInsets.zero,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20))),
              child: Ink(
                decoration: BoxDecoration(
                    gradient: const LinearGradient(colors: [
                      Colors.deepOrange,
                      Colors.lightBlue
                    ]),
                    borderRadius: BorderRadius.circular(20)),
                child: Container(
                  width: 200,
                  height: 50,
                  alignment: Alignment.center,
                  child: const Text(
                    'Login',
                    style: TextStyle(
                        fontSize: 30,
                        color: Colors.white,
                        fontFamily: 'Milonga'
                    ),
                  ),
                ),
              ),
            ),
          ),


        ],



      ),
    );
  }

}