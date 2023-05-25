import 'package:flutter/material.dart';
import 'package:amigo_app/Login.dart';
import 'package:amigo_app/main.dart';
import 'package:flutter/material.dart';
import 'package:amigo_app/styles.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:email_validator/email_validator.dart';



class Create extends StatefulWidget {


  @override
  State<Create> createState() => _CreatePageState();
}

class _CreatePageState extends State<Create> {

  bool isLogin = true;



  final User_namecontroller = TextEditingController();
  final Passwordcontroller = TextEditingController();
  final newpasswordcontroller = TextEditingController();



  @override
  //void initState(){
  // FirebaseAuth.instance.currentUser()
  //    .then((value)){

  // Firestore.instance.collection('user')
  //    .where('uid',isEqualTo: val.uid)
  //    .getDocument()
  //    .then((userDocs){
  //  setState((){
  //     User_namecontroller = userDocs.documents[0].data['User name'];
  //    User_namecontroller = userDocs.documents[0].data['User name'];
//    User_namecontroller = userDocs.documents[0].data['User name'];
//    }

//        }
//      };
  //  };
  // Bool _obscuretext=false;
  bool _obscuretext = false;
  IconData id = Icons.visibility_off;

  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(
      title: const Text(
        'Sign In', style: TextStyle(fontSize: 20, color: Colors.black),),
      backgroundColor: Colors.grey,),
      resizeToAvoidBottomInset: false,
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).requestFocus(new FocusNode());
        },
        child: Container(
          decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('images/backround.jpg'),
                colorFilter: new ColorFilter.mode(
                    Colors.black.withOpacity(0.6), BlendMode.color),
                fit: BoxFit.fill,
              )),

            child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  SizedBox(
                    child: Image(
                      image: AssetImage('images/logo.jpg'),),
                    height: 350,
                  ),

                  SizedBox(
                    width: 350,
                    child: TextFormField(
                      controller: User_namecontroller,
                      style: inputstyle(),
                      // controller: uc.uname,
                      decoration:
                      inputdec("Username", Icons.person_outline),
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      validator: (email) =>
                      email != null && !EmailValidator.validate(email)
                          ? 'Enter a valid email'
                          : null,
                    ),),
                  SizedBox(
                    height: 10,),

                  SizedBox(
                    width: 350,
                    child: TextFormField(
                      controller: Passwordcontroller,
                      obscureText: _obscuretext,
                      style: inputstyle(),
                      // controller: uc.pwd,
                      decoration: InputDecoration(
                          suffixIcon: IconButton(
                              icon: Icon(id),
                              color: Colors.black,
                              onPressed: () {
                                setState(() {
                                  _obscuretext = !_obscuretext;
                                  if (_obscuretext)
                                    id = Icons.visibility_off;
                                  else
                                    id = Icons.visibility;
                                });
                              }),
                          fillColor: Colors.white,
                          filled: true,
                          border: new OutlineInputBorder(
                              borderRadius:
                              BorderRadius.all(Radius.circular(10.0)),
                              borderSide: BorderSide(color: Colors.black)),
                          focusedBorder: OutlineInputBorder(
                              borderRadius:
                              BorderRadius.all(Radius.circular(10.0)),
                              borderSide: BorderSide(color: Colors.cyan)),
                          enabledBorder: OutlineInputBorder(
                              borderRadius:
                              BorderRadius.all(Radius.circular(10.0)),
                              borderSide: BorderSide(color: Colors.black)),
                          errorBorder: InputBorder.none,
                          disabledBorder: InputBorder.none,
                          hintStyle: TextStyle(
                            fontSize: 16, // or whatever
                            color: Colors.grey,
                            height:
                            2.2, //                                <----- this was the key
                          ),
                          prefixIcon: Icon(
                            Icons.lock_outline,
                            size: 20,
                            color: Colors.black,
                          ),
                          contentPadding: EdgeInsets.all(0),
                          isDense: true,
                          hintText: "Password"),
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      validator: (value) =>
                      value != null && value.length < 6
                          ? 'Enter min 6 characters'
                          : null,

                    ),
                  ),
                  SizedBox(
                    height: 20,),
                  SizedBox(
                    height: 20,),
                  ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                      minimumSize: Size.fromHeight(50),
                    ),
                    icon: Icon(Icons.arrow_forward, size: 32),
                    label: Text(
                      'SignUp',
                      style: TextStyle(fontSize: 14),
                    ),
                    onPressed: Create,

                  ),
                  SizedBox(
                    height: 14,),


                ]),

        ),
      ),
    );
  }
  Future Create() async{
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => Center(child: CircularProgressIndicator()),

    );
    try{
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: User_namecontroller.text.trim(),
        password: Passwordcontroller.text.trim(),
      );
    }
    on FirebaseAuthException catch (e){
      print(e);
    }
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => LoginPage()),);
  }
}
