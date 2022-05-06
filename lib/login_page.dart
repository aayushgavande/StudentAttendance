import 'package:flutter/material.dart';
import 'signup_page.dart';
import 'package:teacher_attendance/home_screen.dart';

class LoginDemo extends StatefulWidget {
  @override
  _LoginDemoState createState() => _LoginDemoState();
}

class _LoginDemoState extends State<LoginDemo> {
  late bool _loadingInProgress;

  @override
  void initState() {
    super.initState();
    _loadingInProgress = true;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(top: 0.0),
              child: Center(
                child: SizedBox(
                    width: 650,
                    height: 300,
                    child: Image.asset('assets/images/login_background.png')),
              ),
            ),

            const Padding(
              //padding: const EdgeInsets.only(left:15.0,right: 15.0,top:0,bottom: 0),
              padding: EdgeInsets.symmetric(horizontal: 15, vertical: 20),
              child: TextField(
                style: TextStyle(color: Color(0xFF5367ff)),
                decoration: InputDecoration(
                  prefixIcon: Icon(
                    Icons.person_outline_rounded,
                    color: Color(0xFF5367ff),
                    size: 30,
                  ),
                  enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Color(0xFF5367ff)),
                      borderRadius: BorderRadius.all(Radius.circular(30))),
                  focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Color(0xFF5367ff))),
                  floatingLabelStyle: TextStyle(color: Color(0xFF5367ff)),
                  labelText: 'Email',
                  labelStyle: TextStyle(color: Color(0xFF5367ff)),
                  contentPadding: EdgeInsets.all(20),

                  //focusColor: Colors.orange,
                  //hintText: 'Enter valid email id as abc@gmail.com',
                ),
              ),
            ),
            const Padding(
              padding:
                  EdgeInsets.only(left: 15.0, right: 15.0, top: 0, bottom: 0),
              //padding: EdgeInsets.symmetric(horizontal: 15),
              child: TextField(
                style: TextStyle(color: Color(0xFF5367ff)),
                obscureText: true,
                decoration: InputDecoration(
                    prefixIcon: Icon(
                      Icons.lock_outline_rounded,
                      color: Color(0xFF5367ff),
                      size: 30,
                    ),
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Color(0xFF5367ff)),
                        borderRadius: BorderRadius.all(
                          Radius.circular(30),
                        )),
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Color(0xFF5367ff))),
                    floatingLabelStyle: TextStyle(color: Color(0xFF5367ff)),
                    labelText: 'Password',
                    labelStyle: TextStyle(color: Color(0xFF5367ff)),
                    contentPadding: EdgeInsets.all(20)
                    //hintText: 'Enter secure password'
                    ),
              ),
            ),
            // // ignore: deprecated_member_use
            // FlatButton(
            //   onPressed: () {
            //     //TODO FORGOT PASSWORD SCREEN GOES HERE
            //   },
            //   child: const Text(
            //     'Forgot Password',
            //     style: TextStyle(color: Colors.blue, fontSize: 15),
            //   ),
            // ),
            const SizedBox(height: 30),
            Container(
              padding:
                  EdgeInsets.only(left: 15.0, right: 15.0, top: 0, bottom: 0),
              height: 60,
              width: 325,
              decoration: BoxDecoration(
                  color: Color(0xFF5367ff),
                  borderRadius: BorderRadius.circular(30)),
              // ignore: deprecated_member_use
              child: FlatButton(
                onPressed: () {
                  Navigator.push(
                      context, MaterialPageRoute(builder: (_) => HomeScreen()));
                },
                child: const Text(
                  'LOGIN',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.normal),
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Container(
              padding:
                  EdgeInsets.only(left: 15.0, right: 15.0, top: 0, bottom: 0),
              height: 60,
              width: 325,
              decoration: BoxDecoration(
                  color: Color(0xFF5367ff),
                  borderRadius: BorderRadius.circular(30)),
              // ignore: deprecated_member_use
              child: FlatButton(
                onPressed: () {
                  Navigator.push(
                      context, MaterialPageRoute(builder: (_) => Signup()));
                },
                child: const Text(
                  'SIGNUP',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.normal),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
