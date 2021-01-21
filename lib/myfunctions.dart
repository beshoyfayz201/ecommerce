import 'package:betaecommerce/user/productinfo.dart';
import 'package:flutter/material.dart';

import 'model/product.dart';

class AddCarButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomRight,
      child: Container(

        padding: EdgeInsets.symmetric(vertical: 5,horizontal: 7),


        decoration: BoxDecoration(
          gradient: LinearGradient(colors: [Colors.grey[300],Colors.red[700],]),),
        child: Text("Add to carte"),),
    );
  }
}


Widget otherViews(String spec,List<Product>_products){
  List <Product>res=getProductByCat(spec,_products);
  return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          childAspectRatio: 0.8,
          crossAxisCount: 2),
      itemCount: res.length,
      itemBuilder: (BuildContext context, i) => Padding(
        padding: EdgeInsets.all(4),
        child: GestureDetector(
          onTap: (){
            Navigator.of(context).pushNamed(ProductInfo.id,arguments: res[i]);
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
                      height: MediaQuery.of(context).size.height*0.08,
                      width: MediaQuery.of(context).size.width,
                      color: Colors.white,
                      child: Column(

                          crossAxisAlignment: CrossAxisAlignment.start,
                          children:<Widget>[
                            RichText(
                              text: TextSpan(
                                  style: TextStyle(color: Colors.black),
                                  children:<TextSpan> [
                                    TextSpan(text:res[i].pName ),
                                    TextSpan(text:"\n"+res[i].pPrice+"\$" )

                                  ]
                              ),
                            ),



                          ]
                      )

                  ),
                ),
              ),
              AddCarButton()
            ],
          ),
        ),
      ));
}

List<Product>getProductByCat(String c,List<Product>_products){
  List<Product>ress=[];
  for(Product pro in _products){
    if(pro.pCatagory==c){
      ress.add(pro);
    }
  }
  return ress;
}


String getTotalCost(List<Product>pr){
  double res=0;
for(Product p in pr){
  res+=int.parse(p.pPrice)*p.pQuantity;
}
return res.toString();
}