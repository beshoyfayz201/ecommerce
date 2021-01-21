import 'package:betaecommerce/consts.dart';
import 'package:betaecommerce/model/product.dart';
import 'package:betaecommerce/screens/cartscreen.dart';
import 'package:betaecommerce/services/auth.dart';
import 'package:betaecommerce/services/store.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/rendering.dart';

import '../myfunctions.dart';

class HomeScreen extends StatefulWidget {
  static String homeScreenid = "HomeScreen";

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Authant auth = Authant();
  FirebaseUser fbu;
  Store store = Store();

  int chosenTab = 0;
  int bottomIndex=0;
  List<Product>_products=[];

  @override
  void initState() {
    getCurrentUser();
    super.initState();
  }

  void getCurrentUser() async {
    fbu = await auth.getUser();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        DefaultTabController(
          length: 5,
          child: Scaffold(
            appBar: AppBar(
              elevation: 0,
              backgroundColor: Colors.white,
              bottom: TabBar(
                indicatorColor: Colors.redAccent,
                isScrollable: true,
                onTap: (val) {
                  setState(() {
                    chosenTab = val;
                  });
                },
                tabs: <Widget>[
                  Text(
                    catjacket,
                    style: (chosenTab == 0) ? activeTab : notActiveTab,
                  ),
                  Text(
                    catShoes,
                    style: (chosenTab == 1) ? activeTab : notActiveTab,
                  ),
                  Text(
                    catTrousers,
                    style: (chosenTab == 2) ? activeTab : notActiveTab,
                  ),
                  Text(
                    catTshirts,
                    style: (chosenTab == 3) ? activeTab : notActiveTab,
                  ),
                  Text(
                    catMeats,
                    style: (chosenTab == 4) ? activeTab : notActiveTab,
                  ),
                ],
              ),
            ),
            body: TabBarView(

              children: <Widget>[
                jacketview(catjacket),
                otherViews(catShoes,_products),
                otherViews(catTrousers,_products ),
                otherViews(catTshirts,_products),

                otherViews(catMeats,_products),
              ],
            ),
            bottomNavigationBar: mybottomNavigationbar()
          ),
        ),


        //----------------------------------Real app bar parts
        Material(
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 20),
            height: MediaQuery.of(context).size.height * 0.15,
            decoration: BoxDecoration(color: Colors.white),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  "EasyBuy",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
                ),
                IconButton(
                  icon: Icon(Icons.shopping_cart),
                  onPressed: () {
                    Navigator.of(context).pushNamed(CarteScreen.id);
                  },
                )
              ],
            ),
          ),
        )
      ],
    );
  }
  Widget mybottomNavigationbar(){
    return BottomNavigationBar(
      items: [
        BottomNavigationBarItem(icon: Icon(Icons.person),title: Text("test")),
        BottomNavigationBarItem(icon: Icon(Icons.person),title: Text("test")),
        BottomNavigationBarItem(icon: Icon(Icons.person),title: Text("test")),
        BottomNavigationBarItem(icon: Icon(Icons.person),title: Text("test"))
      ],

      fixedColor: Colors.black,
      showSelectedLabels: true,
      type: BottomNavigationBarType.fixed,
      onTap: (val){
        setState(() {
          bottomIndex=val;

                 });
      },
      currentIndex: bottomIndex,
    );
  }



// ___________________________________________getting catagory
  Widget jacketview(String spec) {
    return StreamBuilder<QuerySnapshot>(
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
                pPrice: s[kProductPrice]));}

          // ignore: sdk_version_ui_as_code
          _products=[...res];
          res.clear();
          res=getProductByCat("jacket",_products);
        return otherViews("jacket",_products);
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
    );
  }

}


















