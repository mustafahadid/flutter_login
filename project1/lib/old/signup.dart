import 'package:flutter/material.dart';
import 'inputdeco_design.dart';

class FormPage extends StatefulWidget {
  @override
  _FormPageState createState() => _FormPageState();
}

class _FormPageState extends State<FormPage> {
  String name, email, phone;

  //TextController to read text entered in text field
  TextEditingController password = TextEditingController();
  TextEditingController confirmpassword = TextEditingController();

  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Form(
            key: _formkey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding:
                      const EdgeInsets.only(bottom: 5, left: 30, right: 30),
                  child: TextFormField(
                    style: TextStyle(color: Colors.grey, fontSize: 14.0),
                    keyboardType: TextInputType.text,
                    decoration: buildInputDecoration(
                      Icons.person,
                      "Full Name",
                    ),
                    validator: (String value) {
                      if (value.isEmpty) {
                        return 'Please Enter Name';
                      }
                      return null;
                    },
                    onSaved: (String value) {
                      name = value;
                    },
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.only(bottom: 5, left: 30, right: 30),
                  child: TextFormField(
                    style: TextStyle(color: Colors.grey, fontSize: 14.0),
                    keyboardType: TextInputType.text,
                    decoration: buildInputDecoration(Icons.email, "Email"),
                    validator: (String value) {
                      if (value.isEmpty) {
                        return 'Please a Enter';
                      }
                      if (!RegExp("^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]")
                          .hasMatch(value)) {
                        return 'Please a valid Email';
                      }
                      return null;
                    },
                    onSaved: (String value) {
                      email = value;
                    },
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.only(bottom: 5, left: 30, right: 30),
                  child: TextFormField(
                    style: TextStyle(color: Colors.grey, fontSize: 14.0),
                    keyboardType: TextInputType.number,
                    decoration: buildInputDecoration(Icons.phone, "Phone No"),
                    validator: (String value) {
                      if (value.isEmpty) {
                        return 'Please enter phone no ';
                      }
                      return null;
                    },
                    onSaved: (String value) {
                      phone = value;
                    },
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.only(bottom: 5, left: 30, right: 30),
                  child: TextFormField(
                    style: TextStyle(color: Colors.grey, fontSize: 14.0),
                    controller: password,
                    keyboardType: TextInputType.text,
                    decoration: buildInputDecoration(Icons.lock, "Password"),
                    validator: (String value) {
                      if (value.isEmpty) {
                        return 'Please a Enter Password';
                      }
                      return null;
                    },
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.only(bottom: 20, left: 30, right: 30),
                  child: TextFormField(
                    style: TextStyle(color: Colors.grey, fontSize: 14.0),
                    controller: confirmpassword,
                    obscureText: true,
                    keyboardType: TextInputType.text,
                    decoration:
                        buildInputDecoration(Icons.lock, "Confirm Password"),
                    validator: (String value) {
                      if (value.isEmpty) {
                        return 'Please re-enter password';
                      }
                      print(password.text);

                      print(confirmpassword.text);

                      if (password.text != confirmpassword.text) {
                        return "Password does not match";
                      }

                      return null;
                    },
                  ),
                ),
                SizedBox(
                  width: 250,
                  height: 50,
                  child: RaisedButton(
                    color: Colors.orange,
                    onPressed: () {
                      if (_formkey.currentState.validate()) {
                        print("successful");

                        return;
                      } else {
                        print("UnSuccessfull");
                      }
                    },
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    textColor: Colors.black,
                    child: Text("Kayıt ol"),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
