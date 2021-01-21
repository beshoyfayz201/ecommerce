import 'package:betaecommerce/model/product.dart';
import 'package:betaecommerce/screens/orderscreen.dart';
import 'package:betaecommerce/services/carteoperate.dart';
import 'package:betaecommerce/user/productinfo.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CarteScreen extends StatefulWidget {
  static String id = "CarteScreen";

  @override
  _CarteScreenState createState() => _CarteScreenState();
}

class _CarteScreenState extends State<CarteScreen> {
  String img="assets/images/cart.png";

  @override
  Widget build(BuildContext context) {
    
   
    double screenWidth = MediaQuery.of(context).size.width;
   
    List<Product> products = Provider.of<CarteOperate>(context).prods;
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      backgroundColor: Colors.white,
      appBar: AppBar(backgroundColor: Colors.redAccent,elevation: 0,),
      body: Stack(
        children: <Widget>[Positioned(
           bottom: 24,
           child: Image.asset(img,fit: BoxFit.fitWidth,height: 200,),
         ),

          LayoutBuilder(builder: (context,constrains){
            return (products.isNotEmpty)?Column(
          children: <Widget>[
            SizedBox(height: 20,),
      Expanded(
                      child: ListView.builder(itemCount:products.length,
        itemBuilder:(context,i)=>Card(
          elevation: 2,
          borderOnForeground: true,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
            side: BorderSide(color: Colors.grey[300])
          ),
          
          color: Color(0xffffffff),
                          child: ListTile(

                            onTap:() {
                             showDialog(context: context,
                             child:  AlertDialog(content: Text("are you sure about deleting that product?"),
                              title: Text("warning!"),
                              actions: <Widget>[
                                FlatButton(child: Text("delete"),
                                onPressed: (){
                                
                                setState(() {
                                   products.removeAt(i);
                                });
                                   Navigator.pop(context);
                                },),
                                  FlatButton(child: Text("Edit"),
                                onPressed: (){
                                  Navigator.pop(context);
                                  Navigator.pushNamed(context,ProductInfo.id,arguments:products[i]);
                                  
                                },)
                                
                              ],));
                            
                            },
                            isThreeLine: true,
                            
            title:Text(products[i].pName,style: TextStyle(fontSize: 20),) ,
            subtitle: Text(products[i].pCatagory
            +"\n"+products[i].pQuantity.toString(),style: TextStyle(fontSize: 16)),
            trailing: Text(products[i].pPrice + " \$",style: TextStyle(
              color: Colors.redAccent,fontSize: 20,fontWeight: FontWeight.bold
            ),),
            leading: Image.asset(products[i].pLocation),
            
          ),
        )),
      ),
      ButtonTheme(child: FlatButton(onPressed: (){
        Navigator.of(context).pushNamed(OrderScreen.id,arguments: products);


      },
      color: Colors.redAccent,
      child: Text("Order",style: TextStyle(
        color: Colors.white,
        fontSize: 20
      ),)),minWidth: screenWidth,
             
      
      )
          ],
        )
        
        :Center(
          child:Row(
                     mainAxisAlignment: MainAxisAlignment.center,

                      children:<Widget>[Text("Carte is empty",style: TextStyle(

                color: Colors.red[300],fontSize: 25,fontWeight: FontWeight.bold
              ),),Icon(Icons.add_shopping_cart,color: Colors.blueGrey[700],)] 
          ),
        );
          },
          )],
      )
    );
  }




 


}
