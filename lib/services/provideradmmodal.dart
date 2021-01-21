import 'package:flutter/cupertino.dart';

class AdmModal extends ChangeNotifier
{
  bool adm =false ;
  changeIsAdm(bool value )
  {
    adm=value;
    notifyListeners();
  }
}