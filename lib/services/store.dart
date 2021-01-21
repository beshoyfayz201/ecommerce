import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:betaecommerce/consts.dart';
import 'package:betaecommerce/model/product.dart';


class Store {
  final Firestore _firestore = Firestore.instance;

  additemproduct(Product product) {
    _firestore.collection(prodscollection).add({
      kProductName: product.pName,
      kProductPrice: product.pPrice,
      kProductCata: product.pCatagory,
      kProductDescription: product.pDescreiption,
      kProductLocation: product.pLocation
    });
  }

  Stream <QuerySnapshot>loadProducts() {


    return _firestore.collection(prodscollection).snapshots();
  }

  Stream <QuerySnapshot>loadOrders(){
    return _firestore.collection(orderCollection).snapshots();
  }
  
  deleteProd(docId){
    _firestore.collection(prodscollection).document(docId).delete();
  }
  editProd(data,proId){
    _firestore.collection(prodscollection).document(proId).updateData(data);
  }



  makeOrder(data,List<Product>products){
   var docref= _firestore.collection(orderCollection).document();
  docref.setData(data);
 for(Product product in products){
    docref.collection(ODcollection).document().setData(

    {
       kProductName: product.pName,
      kProductPrice: product.pPrice,
      ODquantity:product.pQuantity.toString(),
      kProductLocation: product.pLocation



    }
  );
 }
  
  }
  
}