import 'package:betaecommerce/screens/HomeScreen.dart';
import 'package:betaecommerce/services/providermodal.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:betaecommerce/screens/login.dart';
import 'package:betaecommerce/services/auth.dart';
import 'package:betaecommerce/widgets/customtextfield.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// ignore: must_be_immutable
class Signup extends StatelessWidget {
  String name,em,pass;
  static String signupId="SignUpId";
  final  authant=new Authant();
  final GlobalKey<FormState>formstate=GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {

    return  Scaffold(
        backgroundColor: Colors.grey[100],
        body: ModalProgressHUD(
          inAsyncCall: Provider.of<ModalHud>(context).loading,
          child: Builder(
            builder: (BuildContext context)=>Form(
              key: formstate,
              child: ListView(
                children: <Widget>[
                  Column(children: <Widget>[

                    Image.asset("assets/images/esplash.png"),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.03,
                    ),
                    CustomTextField(
                      sendText: (z){name=z;},
                      iconData: Icons.person,
                      hint: "Name",
                    ),
                    SizedBox(height: 7,),
                    CustomTextField(
                      sendText: (z){em=z;},
                      iconData: Icons.email,
                      hint: "Email",
                    ),
                    SizedBox(height: 7,),
                    CustomTextField(
                      sendText: (z){pass=z;},
                      iconData: Icons.lock,
                      hint: "Password",
                    ),
                    RaisedButton(

                      color: Colors.grey[600],
                      child: Text(
                        "Signup",
                        style: TextStyle(color: Colors.white),
                      ),
                      shape: StadiumBorder(),
                      onPressed: ()async{
                        final modalprovider=Provider.of<ModalHud>(context,listen: false);
                        modalprovider.changeIsLoading(true);

                        if(formstate.currentState.validate()){

                          formstate.currentState.save();
                         
                          try {
                            final aw = await authant.signIn(em, pass);

                            print(aw.user.uid.toString() + "\n\n\n\n");
                            modalprovider.changeIsLoading(false);
                             Navigator.of(context).pushNamed(HomeScreen.homeScreenid);
                          }catch(  e ){
                            //pr_mod.changeIsLoading(false);
                            Scaffold.of(context).showSnackBar(SnackBar(
                              content: Text(
                                 e.message

                              ),
                            ));
                          }

                        }
                        modalprovider.changeIsLoading(false);
                      },
                    ),
                    SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text("Do have an account ?   "),
                        InkWell(
                          onTap: (){Navigator.of(context).pushNamed(LoginScreen.id);},
                          child: Text("Login",style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold
                          ),),
                        )
                      ],
                    )
                  ])
                ],
              ),
            ),
          ),
        )

    );
  }
}
