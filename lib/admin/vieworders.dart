import 'package:betaecommerce/consts.dart';
import 'package:betaecommerce/model/ordermodel.dart';
import 'package:betaecommerce/services/store.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ViewOrderScreen extends StatelessWidget {
  static String id="ViewScreenID";
  Store store=Store();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<QuerySnapshot>(
        stream: store.loadOrders(),
builder: (context,snapshot){
  if(!snapshot.hasData){
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
           Image.asset("assets/images/sadface.png",fit: BoxFit.fitWidth,height: 100,),
           SizedBox(height: 30,),
          Text("there is no Orders yet",style: TextStyle(fontSize: 20),),
         
        ],
      ),
    );
  }else{
    List<Order>orders=[];
    
    for(var a in snapshot.data.documents){
      orders.add(Order(addrese: a.data[Oaddrese],
      telenum: a.data[Otele],
      totlalCost: double.parse(a.data[Ototal])));
    }
   
    return ListView.builder(
      itemCount: orders.length,
      itemBuilder: (context,i)=>Text(
   orders[i].totlalCost.toString()
    ));
  }

},

      ),
    );
  }
}