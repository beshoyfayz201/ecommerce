import 'package:betaecommerce/admin/adminscreen.dart';
import 'package:betaecommerce/services/provideradmmodal.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:betaecommerce/screens/signup.dart';
import 'package:betaecommerce/services/auth.dart';
import 'package:betaecommerce/widgets/customtextfield.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:betaecommerce/services/providermodal.dart';

import 'HomeScreen.dart';


class LoginScreen extends StatefulWidget {
  static String id = 'LoginScreen1';
  final GlobalKey<FormState> globalKey = GlobalKey<FormState>();

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  String _email, password;

  final _auth = Authant();

  final adminPassword = 'Admin123';

  bool keepMeLoggedIn = false;

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      body: ModalProgressHUD(
        inAsyncCall: Provider.of<ModalHud>(context).loading,
        child: Form(
          key: widget.globalKey,
          child: ListView(
            children: <Widget>[
             Image.asset("assets/images/esplash.png"),

              CustomTextField(
                sendText: (value) {
                  _email = value;
                },
                hint: 'Enter your email',
                iconData: Icons.email,
              ),
              Padding(
                padding: EdgeInsets.only(left: 20),
                child: Row(
                  children: <Widget>[
                    Theme(
                      data: ThemeData(unselectedWidgetColor: Colors.red.shade200),
                      child: Checkbox(

                        checkColor: Colors.red[400],
                        activeColor: Colors.red[100],
                        value: keepMeLoggedIn,
                        onChanged: (value) {
                          setState(() {
                            keepMeLoggedIn = value;
                          });
                        },
                      ),
                    ),
                    Text(
                      'Remmeber Me ',
                      style: TextStyle(
                        color: Colors.blueGrey[600]
                      ),
                    )
                  ],
                ),
              ),
              CustomTextField(
                sendText: (value) {
                  password = value;
                },
                hint: 'password',
                iconData: Icons.lock,
              ),
              SizedBox(
                height: height * .05,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 120),
                child: Builder(
                  builder: (context) => FlatButton(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20)),
                    onPressed: () {
                      if (keepMeLoggedIn == true) {
                        //keepUserLoggedIn();
                      }
                      _validate(context);
                    },
                    color: Colors.black,
                    child: Text(
                      'Login',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: height * .05,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    'Don\'t have an account ? ',
                    style: TextStyle(color: Colors.blueGrey[600], fontSize: 16),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(context, Signup.signupId);
                    },
                    child: Text(
                      'Signup',
                      style: TextStyle(fontSize: 16),
                    ),
                  )
                ],
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          Provider.of<AdmModal>(context, listen: false)
                              .changeIsAdm(false);
                        },
                        child: Text(
                          'i\'m an admin',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: Provider.of<AdmModal>(context).adm
                                  ? Colors.redAccent
                                  : Colors.white),
                        ),
                      ),
                    ),
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          Provider.of<AdmModal>(context, listen: false)
                              .changeIsAdm(true);
                        },
                        child: Text(
                          'i\'m a user',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color:
                              Provider.of<AdmModal>(context, listen: true)
                                  .adm
                                  ? Colors.white
                                  : Colors.redAccent),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _validate(BuildContext context) async {
    final modelhud = Provider.of<ModalHud>(context, listen: false);
    modelhud.changeIsLoading(true);
    if (widget.globalKey.currentState.validate()) {
      widget.globalKey.currentState.save();
      if (Provider.of<AdmModal>(context, listen: false).adm) {
        if (password == adminPassword) {
          try {
            await _auth.login(_email.trim(), password.trim());
            Navigator.pushNamed(context, AdminScreen.admScreenid);
          } catch (e) {
            modelhud.changeIsLoading(false);
            Scaffold.of(context).showSnackBar(SnackBar(
              content: Text(e.message),
            ));
          }
        } else {
          modelhud.changeIsLoading(false);
          Scaffold.of(context).showSnackBar(SnackBar(
            content: Text('Something went wrong !'),
          ));
        }
      } else {
        try {
          await _auth.login(_email.trim(), password.trim());
          Navigator.pushNamed(context, HomeScreen.homeScreenid);
        } catch (e) {
          Scaffold.of(context).showSnackBar(SnackBar(
            content: Text(e.message),
          ));
        }
      }
    }
    modelhud.changeIsLoading(false);
  }

//  void keepUserLoggedIn() async {
//    SharedPreferences preferences = await SharedPreferences.getInstance();
//    preferences.setBool(kKeepMeLoggedIn, keepMeLoggedIn);
//  }
}
