import 'package:betaecommerce/model/product.dart';
import 'package:betaecommerce/widgets/customtextfield.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:betaecommerce/services/store.dart';

// ignore: must_be_immutable
class Addproduct extends StatelessWidget {
  String pname, pprice, pdesc, pcata, ploc;
  static final String id = "AddProduct";
  GlobalKey<FormState> _formState = new GlobalKey<FormState>();
  final Store store = Store();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        // padding: EdgeInsets.only(top: MediaQuery.of(context).size.height*0.15),
        width: double.infinity,
        child: Form(
          key: _formState,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              CustomTextField(
                sendText: (val) {
                  pname = val;
                },
                hint: "product name",
                iconData: Icons.assignment_ind,
              ),
              CustomTextField(
                  sendText: (val) {
                    pprice = val;
                  },
                  hint: "Product Price",
                  iconData: Icons.monetization_on),
              CustomTextField(
                  sendText: (val) {
                    pdesc = val;
                  },
                  hint: "Product description",
                  iconData: Icons.question_answer),
              CustomTextField(
                  sendText: (val) {
                    pcata = val;
                  },
                  hint: "product category",
                  iconData: Icons.card_membership),
              CustomTextField(
                  sendText: (val) {
                    ploc = val;
                  },
                  hint: "Product location",
                  iconData: Icons.location_on),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(
              title: Text("Add Item"), icon: Icon(Icons.add)),
          BottomNavigationBarItem(
              title: Text("Go Back"), icon: Icon(Icons.backspace))
        ],
        elevation: 5,
        selectedItemColor: Colors.red.shade900,
        unselectedItemColor: Colors.red.shade900,
        onTap: (i) {
          if (i == 0) {
            if (_formState.currentState.validate()) {
              _formState.currentState.save();
              store.additemproduct(Product(
                  pCatagory: pcata,
                  pDescreiption: pdesc,
                  pLocation: ploc,
                  pName: pname,
                  pPrice: pprice));
              _formState.currentState.reset();
            }
          } else {
            Navigator.pop(context);
          }
        },
      ),
    );
  }
}
