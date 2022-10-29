import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class MySignUpPageUi extends StatefulWidget {
  final VoidCallback showLoginPage;
  const MySignUpPageUi({super.key, required this.showLoginPage});

  @override
  State<MySignUpPageUi> createState() => _MySignUpPageUiState();
}

class _MySignUpPageUiState extends State<MySignUpPageUi> {

  final _emailController = TextEditingController();
  final _pwdController = TextEditingController();
  final _confirmpwdController = TextEditingController();
  final _usernamecontroller = TextEditingController();
  final _firstnameController = TextEditingController();
  final _LastnameController = TextEditingController();
  final _ageController = TextEditingController();


  @override 
  void dispose() {
    _emailController.dispose();
    _pwdController.dispose();
    _confirmpwdController.dispose();
    _usernamecontroller.dispose();
    _firstnameController.dispose();
    _LastnameController.dispose();
    _ageController.dispose();
    super.dispose();
  }


  Future signUp(String firstname, String lastname, int age, String password, String username) async {
    if(passwordConfirmed()) {

      //create a user account
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: _emailController.text.trim(), 
        password: _pwdController.text.trim(),
      );

    
    await FirebaseFirestore.instance.collection('users').doc('${(_emailController.text.trim())}').set({
      'user email': '${(_emailController.text.trim())}',
      'password': password,
      'user name': username,
      'first name': firstname,
      'last name': lastname,
      'age': age,
      'bannerurl': 'https://w.wallha.com/ws/14/jbVvEcAi.jpg',
      'profilepicurl': 'https://i.pinimg.com/736x/c0/c2/16/c0c216b3743c6cb9fd67ab7df6b2c330.jpg',
    });
    //create a collection to add posts
    await FirebaseFirestore.instance.collection('users').doc('${(_emailController.text.trim())}').collection('posts').add({
      'letsgo': 'new collection to add more posts',
    });


    }
  }


  bool passwordConfirmed() {
    if(_pwdController.text.trim() == _confirmpwdController.text.trim()){
      return true;
    }else{
      return false;
    }
  }


  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sign Up Page '),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 5,bottom: 15),
              child: Text('SignUp Now For Free', style: TextStyle(fontSize: 20),),
            ),
            
            //UserName TextField
            Padding(
              padding: EdgeInsets.only(bottom: 8, left: 15, right: 15),
              child: TextField(
                obscureText: false,
                controller: _usernamecontroller,
                decoration: InputDecoration(
                  hintText: 'user name',
                  
                ),
              ),
            ),

            //Email TextField
            Padding(
              padding: EdgeInsets.only(bottom: 8, left: 15, right: 15),
              child: TextField(
                controller: _emailController,
                decoration: InputDecoration(
                  hintText: 'your email',
                  
                ),
              ),
            ),

            //Password TextField
            Padding(
              padding: EdgeInsets.only(bottom: 8, left: 15, right: 15),
              child: TextField(
                obscureText: true,
                controller: _pwdController,
                decoration: InputDecoration(
                  hintText: 'your password',
                  
                ),
              ),
            ),

            //Confirm Password TextField
            Padding(
              padding: EdgeInsets.only(bottom: 8, left: 15, right: 15),
              child: TextField(
                obscureText: true,
                controller: _confirmpwdController,
                decoration: InputDecoration(
                  hintText: 'confirm password',
                  
                ),
              ),
            ),

            //first name TextField
            Padding(
              padding: EdgeInsets.only(bottom: 8, left: 15, right: 15),
              child: TextField(
                controller: _firstnameController,
                decoration: InputDecoration(
                  hintText: 'first name',
                  
                ),
              ),
            ),

            //last name TextField
            Padding(
              padding: EdgeInsets.only(bottom: 8, left: 15, right: 15),
              child: TextField(
                controller: _LastnameController,
                decoration: InputDecoration(
                  hintText: 'last name',
                  
                ),
              ),
            ),

            //age TextField
            Padding(
              padding: EdgeInsets.only(bottom: 8, left: 15, right: 15),
              child: TextField(
                controller: _ageController,
                decoration: InputDecoration(
                  hintText: 'age',
                  
                ),
              ),
            ),

            //Button SignUp
              GestureDetector(
                onTap: (() {
                  signUp(_firstnameController.text.trim(),_LastnameController.text.trim(),int.parse(_ageController.text.trim()),_pwdController.text.trim(), _usernamecontroller.text.trim());
                }),
                child: Container(
                  alignment: Alignment.center,
                  height: 35,
                  width: 80,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: Colors.blue,
                  ),
                  child: Text('SignUp',style: TextStyle(color: Colors.white,fontSize: 17),)),
                ),

            SizedBox(height: 30,),

            //Don't Have An Account 
            Padding(
            padding: EdgeInsets.only(left: 15),
            child: Row(
              children: [
                RichText(
                  text: TextSpan(
                    text: 'Have an account! ',style: TextStyle(
                      color: Colors.black,

                    ),
                    ),
                  ),
                GestureDetector(
                  onTap: widget.showLoginPage,
                  child: Text('Sign In',style: TextStyle(
                    color: Colors.blue,
                  ),),
                ),
              ],
            ),
          )
          ],
        ),
      ),
    );
  }
}