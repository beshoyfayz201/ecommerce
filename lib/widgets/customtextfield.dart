import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final IconData iconData;
  final String hint;
  final Function sendText;

  String errorMassage(String str) {
    switch (hint) {
      case "Name":
        return "Name is empty";
      case "Email":
        return "Email is empty";
      case "Password":
        return "Password is empty";
      default:
        return "something wrong happen";
    }
  }

  const CustomTextField({
    @required this.sendText,
    this.iconData,
    this.hint,
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: TextFormField(
        onSaved: sendText,
        keyboardType:(hint != "password") ? TextInputType.emailAddress:
        TextInputType.text,


        obscureText: (hint == "password") ? true : false,
        // ignore: missing_return
        validator: (value) {
          if (value.isEmpty) {
            return errorMassage(hint);
          }
        },
        cursorColor: Colors.white,

        decoration: InputDecoration(

            hintText: hint,
            prefixIcon: Icon(
              iconData,
              color: Colors.white,
            ),
            filled: true,
            focusColor: Colors.red[900],
            fillColor: Colors.red[200],
            //hoverColor: Colors.black,
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(40),
              ),
              borderSide: BorderSide(width: 1.2, color: Colors.white),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(40),
              ),
              borderSide: BorderSide(width: 1, color: Colors.white),
            ),
            border: OutlineInputBorder(
              
              borderRadius: BorderRadius.all(
                Radius.circular(40),
              ),
              borderSide: BorderSide(width: 1, color: Colors.white),
            )),
      ),
    );
  }
}


//Order TextField
class OrdTextField extends StatelessWidget {
  int num;
  String hint;
  Function fun;
  IconData icon;
  OrdTextField({this.num,this.hint,this.icon,this.fun});
  @override
  Widget build(BuildContext context) {
    return   Padding(
      padding: EdgeInsets.symmetric(horizontal: 10,vertical: 5),
          child: TextField(
        enabled: (num==2)?false:true,
                    cursorColor: Colors.grey,
                   decoration: InputDecoration(
                     border: OutlineInputBorder(borderSide: BorderSide(color: Colors.redAccent)),
                     fillColor: Colors.grey.shade200,
                    
                     enabledBorder:OutlineInputBorder(borderSide: BorderSide(color: Colors.red[300],width: 2)), 
                     focusedBorder:OutlineInputBorder(borderSide: BorderSide(color: Colors.red[500],width: 2),
                     borderRadius: BorderRadius.all(Radius.circular(15))),  
                    icon:Icon( icon,color: Colors.grey[700],),
                     filled: true,
                     labelText: hint,
                     labelStyle: TextStyle(color: Colors.grey[700]),
                     

                   ),
                    onChanged: fun
                  ),
    );
  }
}





