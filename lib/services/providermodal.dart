import 'package:flutter/cupertino.dart';

class ModalHud extends ChangeNotifier
{
  bool loading =false;

  changeIsLoading(bool value)
  {
    loading=value;
    notifyListeners();
  }
}