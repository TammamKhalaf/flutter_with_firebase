import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_with_firebase/login.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class RegisterScreen extends StatefulWidget {
  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  void initState() {
    super.initState();
  }

  final _formkey = GlobalKey<FormState>();

  TextEditingController _emailcontroller = TextEditingController();

  TextEditingController _passwordcontroller = TextEditingController();

  @override
  void dispose() {
    _emailcontroller.dispose();

    _passwordcontroller.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text('Register New Account'),
      ),
      body: Container(
        padding: EdgeInsets.all(16),
        child: Form(
            key: _formkey,
            child: Column(
              children: <Widget>[
                TextFormField(
                  controller: _emailcontroller,
                  decoration: InputDecoration(
                    hintText: 'Email',
                  ),
                  // ignore: missing_return
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Please Fill Email Input';
                    }
                  },
                ),
                SizedBox(
                  height: 20,
                ),
                TextFormField(
                  controller: _passwordcontroller,
                  decoration: InputDecoration(
                    hintText: 'Password',
                  ),
                  // ignore: missing_return
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Please Fill Password Input';
                    }
                  },
                ),
                SizedBox(
                  height: 25,
                ),
                RaisedButton(
                  color: Colors.blue,
                  child: Text(
                    'Register New Account',
                    style: TextStyle(color: Colors.white),
                  ),
                  onPressed: () async {
                    if (_formkey.currentState.validate()) {
                      var result = FirebaseAuth.instance
                          .createUserWithEmailAndPassword(
                              email: _emailcontroller.text,
                              password: _passwordcontroller.text);

                      if (result != null) {
                        CollectionReference users = FirebaseFirestore.instance.collection('users');
                        users.add({
                              'email': _emailcontroller.text
                            }).then((value) => print("User Added")).catchError((error) => print("Failed to add user: $error"));

                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => LoginScreen()),
                        );
                      } else {
                        print('please try later');
                      }
                    }
                  },
                )
              ],
            )),
      ),
    );
  }
}
