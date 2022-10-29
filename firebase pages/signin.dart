import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class MyLoginPageUi extends StatefulWidget {
  final VoidCallback showRegisterPage;
  const MyLoginPageUi({super.key, required this.showRegisterPage});

  @override
  State<MyLoginPageUi> createState() => _MyLoginPageUiState();
}

class _MyLoginPageUiState extends State<MyLoginPageUi> {
  
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();


  @override
  void dispose() {
    // TODO: implement dispose
    _emailController.dispose();
    _passwordController.dispose();

    super.dispose();
  }

  Future signIn() async {

    showDialog(
      context: context, 
      builder: (context) {
        return Center(child: CircularProgressIndicator(),);
    });

    await FirebaseAuth.instance.signInWithEmailAndPassword(
      email: _emailController.text.trim(), 
      password: _passwordController.text.trim(),
    );

    Navigator.of(context).pop();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('LoginPage'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 10,),
            Text('Login Now',style: TextStyle(fontSize: 20),),
          
            //Email
            Padding(
              padding: EdgeInsets.only(top: 5,left: 15,right: 15,bottom: 5),
              child: TextField(
                controller: _emailController,
                decoration: InputDecoration(
                  hintText: 'your Email',
                ),
              ),
            ),
          
            //Password
            Padding(
              padding: EdgeInsets.only(top: 5,left: 15,right: 15,bottom: 5),
              child: TextField(
                controller: _passwordController,
                decoration: InputDecoration(
                  hintText: 'your Password',
                ),
              ),
            ),
          
            //Button
            SizedBox(height: 20,),
            GestureDetector(
              onTap: signIn,
              child: Container(
                alignment: Alignment.center,
                height: 40,
                width: 80,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: Colors.blue
                ),
                child: Text('SignIn ', style: TextStyle(color: Colors.white,fontSize: 17)),
              ),
            ),
          
            //Dont have an account
            SizedBox(height: 10,),
            Padding(
              padding: const EdgeInsets.only(left:15,top: 20,),
              child: Row(
                children: [
                  Text('Dont have an account? '),
                  GestureDetector(
                    onTap: widget.showRegisterPage,
                    child: 
                      Text('Create Now! ',style: TextStyle(color: Colors.blue),))
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}