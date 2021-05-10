import 'package:project1/api/api_service.dart';
import 'package:project1/model/login_model.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:project1/old/signup.dart';
import 'inputdeco_design.dart';

import '../ProgressHUD.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool hidePassword = true;
  bool isApiCallProcess = false;

  GlobalKey<FormState> globalFormKey = GlobalKey<FormState>();
  LoginRequestModel loginRequestModel;

  final scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  void initState() {
    super.initState();
    loginRequestModel = new LoginRequestModel();
  }

  @override
  Widget build(BuildContext context) {
    return ProgressHUD(
      child: _uiSetup(context),
      inAsyncCall: isApiCallProcess,
      opacity: 0.3,
    );
  }

  Widget _uiSetup(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      body: Center(
        child: SingleChildScrollView(
          child: Form(
            key: globalFormKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding:
                      const EdgeInsets.only(bottom: 15, left: 30, right: 30),
                  child: TextFormField(
                    onSaved: (input) => loginRequestModel.email = input,
                    style: TextStyle(color: Colors.black, fontSize: 14.0),
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
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.only(bottom: 5, left: 30, right: 30),
                  child: TextFormField(
                    style: TextStyle(color: Colors.black, fontSize: 14.0),
                    onSaved: (input) => loginRequestModel.password = input,
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
                      const EdgeInsets.only(bottom: 30, left: 200, top: 10),
                  child: Text(
                    'Şifre Unuttum?',
                    style: TextStyle(color: Colors.black, fontSize: 12.0),
                  ),
                ),
                SizedBox(
                  width: 250,
                  height: 50,
                  child: MaterialButton(
                    color: Colors.orange,
                    onPressed: () {
                      if (validateAndSave()) {
                        print(loginRequestModel.toJson());

                        setState(() {
                          isApiCallProcess = true;
                        });

                        APIService apiService = new APIService();
                        apiService.login(loginRequestModel).then((value) {
                          if (value != null) {
                            setState(() {
                              isApiCallProcess = false;
                            });

                            if (value.token.isNotEmpty) {
                              final snackBar =
                                  SnackBar(content: Text("Login Successful"));
                              scaffoldKey.currentState.showSnackBar(snackBar);
                            } else {
                              final snackBar =
                                  SnackBar(content: Text(value.error));
                              scaffoldKey.currentState.showSnackBar(snackBar);
                            }
                          }
                        });
                      }
                    },
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.0)),
                    textColor: Colors.black,
                    child: Text("Login"),
                  ),
                ),
                SizedBox(
                    height: MediaQuery.of(context).size.height / 15,
                    child: Center(
                      child: RichText(
                        text: TextSpan(
                            text: 'Do your have account?',
                            style: TextStyle(color: Colors.black, fontSize: 12),
                            children: <TextSpan>[
                              TextSpan(
                                text: ' Register',
                                style: TextStyle(
                                    color: Colors.blueAccent, fontSize: 12),
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => FormPage()));
                                  },
                              )
                            ]),
                      ),
                    ))
              ],
            ),
          ),
        ),
      ),
    );
  }

  bool validateAndSave() {
    final form = globalFormKey.currentState;
    if (form.validate()) {
      form.save();
      return true;
    }
    return false;
  }
}
