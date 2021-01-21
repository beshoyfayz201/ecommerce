import 'package:betaecommerce/admin/edit.dart';
import 'package:betaecommerce/model/product.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:betaecommerce/services/store.dart';


import '../consts.dart';

class Manage extends StatefulWidget {
  static final String id = "EditProduct";

  @override
  _ManageState createState() => _ManageState();
}

class _ManageState extends State<Manage> {
  Store store = Store();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: StreamBuilder<QuerySnapshot>(
        stream: store.loadProducts(),
        builder: (BuildContext context, snapshot) {
          List<Product> res = [];
          if (snapshot.hasData) {
            for (var LstDocs in snapshot.data.documents) {
              var s = LstDocs.data;
              res.add(Product(
                  pId: LstDocs.documentID,
                  pCatagory: s[kProductCata],
                  pDescreiption: s[kProductDescription],
                  pLocation: s[kProductLocation],
                  pName: s[kProductName],
                  pPrice: s[kProductPrice]));
            }

            return GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  childAspectRatio: 0.8,
                    crossAxisCount: 2),
                itemCount: res.length,
                itemBuilder: (BuildContext context, i) => Padding(
                  padding: EdgeInsets.all(4),
                  child: GestureDetector(
                    onTapUp: (details){
                      double x1=details.globalPosition.dx;
                      double x2=MediaQuery.of(context).size.width-x1;
                      double y1=details.globalPosition.dy;
                      double y2=MediaQuery.of(context).size.height-y1;
                      showMenu(context: context, position: RelativeRect.fromLTRB(x1, y1, x2, y2), items: [
                        MyPopUpMenuItem(
                            child: Text("Edit"),
                            onclc: (){
                            Navigator.pushNamed(context,EditProduct.id,arguments: res[i]);

                            },
                        ),
                        MyPopUpMenuItem(
                          child: Text("Delete"),
                          onclc:() {
                            store.deleteProd(res[i].pId);
                            Navigator.pop(context);
                          },
                        )
                      ]);
                    },
                    child: Stack(
                          children: <Widget>[
                            Positioned.fill(
                                child: Image.asset(
                              res[i].pLocation,
                              fit: BoxFit.fill,
                            )),
                            Positioned(
                              bottom: 0,
                              child: Opacity(
                                opacity: 0.8,
                                child: Container(
                                  width: MediaQuery.of(context).size.width,
                                  color: Colors.red[400],
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children:<Widget>[
                                      RichText(
                                        text: TextSpan(
                                          children:<TextSpan> [
                                            TextSpan(text:res[i].pName ),
                                            TextSpan(text:"\n"+res[i].pPrice+"\$" )

                                          ]
                                        ),
                                      )


                                    ]
                                  )

                                ),
                              ),
                            )
                          ],
                        ),
                  ),
                ));
          }

          //data isnt ready____________________________________
          else {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                CircularProgressIndicator(
                  backgroundColor: Colors.red,
                ),
                Text(
                  "Loading....",
                  style: TextStyle(fontSize: 18),
                )
              ],
            );
          }
        },
      ),
    ));
  }
}

// ignore: must_be_immutable



class MyPopUpMenuItemState<T,PopupMenuItem> extends PopupMenuItemState<T,MyPopUpMenuItem<T>>{


  @override
  void handleTap() {
    widget.onclc();
    print ("test1");
  }
}

// ignore: must_be_immutable
class MyPopUpMenuItem<T>extends PopupMenuItem<T>{
  Widget child;
  Function onclc;


  MyPopUpMenuItem({this.child, this.onclc}):super(child:child); //
  @override
  PopupMenuItemState<T, PopupMenuItem<T>> createState() {
    return PopupMenuItemState();
  }
}