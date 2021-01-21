import 'package:firebase_auth/firebase_auth.dart';
class Authant{
  final _auth=FirebaseAuth.instance;


 Future<AuthResult> signIn(String email,String password)async{
    final authResult=await  _auth.createUserWithEmailAndPassword(email: email, password: password);
    return authResult;

  }

  Future<AuthResult> login(String email,String password)async{
    final authResult=await  _auth.signInWithEmailAndPassword(email: email, password: password);
    return authResult;
  }

  getUser()async{
   FirebaseUser fbu=await _auth.currentUser();
   if(fbu!=null){
     return fbu;
   }
  }
}