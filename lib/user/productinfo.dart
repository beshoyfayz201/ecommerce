import 'package:betaecommerce/model/product.dart';
import 'package:betaecommerce/screens/cartscreen.dart';
import 'package:betaecommerce/services/carteoperate.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProductInfo extends StatefulWidget {
  static String id = "productinfo";
  @override
  _ProductInfoState createState() => _ProductInfoState();
}

class _ProductInfoState extends State<ProductInfo> {
  int quantity = 1;
  @override
  Widget build(BuildContext context) {
    Product product = ModalRoute.of(context).settings.arguments;
    return Scaffold(
      backgroundColor: Colors.red[300],
      body: Stack(
        children: <Widget>[
          Positioned(
            bottom: -4,
            child: Container(
              width: MediaQuery.of(context).size.width,
              child: RaisedButton(
                child: Text(
                  "Buy Now",
                  style: TextStyle(color: Colors.white),
                ),
                color: Colors.red[300],
                elevation: 2,
                onPressed: () {
                  Navigator.of(context).pushNamed(CarteScreen.id);
                },
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.only(left: 30),
            margin: EdgeInsets.symmetric(vertical: 40),
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(60)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                SizedBox(
                  height: 30,
                ),
                Image.asset(
                  product.pLocation,
                  height: 250,
                ),
                Text(
                  product.pName,
                  style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.red[400]),
                ),
                Expanded(
                  child: Text(
                    product.pDescreiption +
                        "\n" +
                        "it got high quality materials" +
                        "\n" +
                        "made in Egypt",
                    style: TextStyle(
                      fontSize: 18,
                    ),
                  ),
                ),
                Divider(
                  thickness: 3,
                  endIndent: 25,
                  color: Colors.grey[400],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Text(
                      "\$" + product.pPrice,
                      style: TextStyle(
                          fontSize: 27,
                          fontWeight: FontWeight.bold,
                          color: Colors.redAccent,
                          shadows: [
                            Shadow(
                              color: Colors.grey[300],
                              blurRadius: 10,
                            )
                          ]),
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    Builder(
                      builder: (context) => RaisedButton(
                        child: Text(
                          "   add to carte +   ",
                          style: TextStyle(color: Colors.white),
                        ),
                        color: Colors.redAccent,
                        shape: StadiumBorder(
                            side: BorderSide(
                          color: Colors.white,
                        )),
                        elevation: 2,
                        onPressed: () {
                          addToCarte(context, product);
                        },
                      ),
                    )
                  ],
                ),
                //quantity controller
                Padding(
                  padding: EdgeInsets.only(right: 25, bottom: 15, top: 10),
                  child: Card(
                    elevation: 8,
                    shape: StadiumBorder(
                        side: BorderSide(color: Colors.cyan[700], width: 0.2)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        FlatButton(
                          child: Text(
                            "+",
                            style: buttonText,
                          ),
                          color: Colors.transparent,
                          onPressed: () {
                            setState(() {
                              quantity += 1;
                            });
                          },
                        ),
                        Text(
                          " $quantity ",
                          style: buttonText,
                        ),
                        FlatButton(
                          child: Text(
                            "-",
                            style: buttonText,
                          ),
                          color: Colors.transparent,
                          onPressed: () {
                            setState(() {
                              if (quantity > 1) quantity -= 1;
                            });
                          },
                        )
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  TextStyle buttonText = TextStyle(fontSize: 20);

  addToCarte(context, Product product) {

    product.pQuantity = quantity;
  bool found=false;
    CarteOperate carteOperate =
        Provider.of<CarteOperate>(context, listen: false);

        List<Product>lista=carteOperate.prods;
        for(Product i in lista){
          if(i.pName==product.pName){
           found=true;
          }
        }
 
 if(found){
    Scaffold.of(context).showSnackBar(SnackBar(content: Text("These item has been added before")
    ,duration: Duration(milliseconds: 200)));
 }
else{
  carteOperate.addProduct(product);
}
    
    Scaffold.of(context).showSnackBar(SnackBar(content: Text("Done"),duration: Duration(milliseconds: 200),));
  }
}
