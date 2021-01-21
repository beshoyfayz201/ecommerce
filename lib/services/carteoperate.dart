import 'package:betaecommerce/model/product.dart';
import 'package:flutter/material.dart';

class CarteOperate extends ChangeNotifier{
  List<Product>prods=[];
  addProduct(Product product){
        prods.add(product);
        notifyListeners();
  }
}