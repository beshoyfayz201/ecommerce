import 'package:betaecommerce/consts.dart';
import 'package:betaecommerce/model/product.dart';
import 'package:betaecommerce/myfunctions.dart';
import 'package:betaecommerce/services/store.dart';
import 'package:betaecommerce/widgets/customtextfield.dart';
import 'package:flutter/material.dart';

class OrderScreen extends StatefulWidget {
 
  static String id = "OrderScreen";
  @override
  _OrderScreenState createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen> {
  
  int v = 1;
  Store store=Store();
  String addresse;
  String telephone;
  @override
  Widget build(BuildContext context) {
     List<Product> products=ModalRoute.of(context).settings.arguments;
    
   
    return Scaffold(
      
      floatingActionButton: Builder(
              builder:(context)=> FloatingActionButton(

          child: Icon(Icons.done,color: Colors.grey[100],),
          backgroundColor: Colors.redAccent,
          onPressed: (){
 if(addresse==null||telephone==null){
   Scaffold.of(context).showSnackBar(SnackBar(content: Text("please fill the required data"),));
 }
 
 else{
            try{
           
           
            
          store.makeOrder({
            Oaddrese:addresse,
            Otele:telephone,
            Ototal:getTotalCost(products),
            
          }, products);
          }catch(e){
            Scaffold.of(context).showSnackBar(SnackBar(content: Text(e.message),));
          }}
        }
        
        
        
        ),
      ),



      backgroundColor: Colors.white,
      resizeToAvoidBottomPadding: false,
      appBar: AppBar(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(1)),
        backgroundColor: Colors.redAccent,

        elevation: 10,
      ),
      body: Stack(
        children: <Widget>[
           Positioned(
             bottom: 0,
                        child: Container(
             height: 230,
             
          width: MediaQuery.of(context).size.width,
          child: CustomPaint(
              painter: CurvePainter(),
          ),
          ),
           ),
          Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Image.asset(
                  "assets/images/ord.png",
                ),
              OrdTextField(hint: "addrese",icon: Icons.location_on,fun: (tex){
                setState(() {
                  addresse=tex;
                });
              },),
            
              OrdTextField(hint: "telephone",icon: Icons.phone,fun: (tex){
                setState(() {
                  
                  telephone=tex;
                });
              },),
                
                Padding(
                  padding: const EdgeInsets.only(left: 10, top: 20),
                  child: Text(
                    "Payment meathod :",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
                Row(
                  children: <Widget>[
                    Image.asset(
          "assets/images/v.jpg",
          height: 50,
                    ),
                    Radio(value: 0, groupValue: v, onChanged: check,activeColor: Colors.deepPurple,),
                    Image.asset(
          "assets/images/vv.jpg",
          height: 50,
                    ),
                    Radio(value: 1, groupValue: v, onChanged: check,activeColor: Colors.deepPurple),
                    Text(
          "Cash",
          style: TextStyle(fontWeight: FontWeight.w700, fontSize: 18),
                    ),
                    Radio(value: 2, groupValue: v, onChanged: check,activeColor: Colors.deepPurple)
                  ],
                ),
              ],
            ),
          
         
        ],
       
      ),
    );
  }

  void check(int a) {
    setState(() {
      v = a;
    });
  }
}

class CurvePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    var paint = Paint();
    paint.color = Colors.redAccent;
    paint.style = PaintingStyle.fill;

    var path = Path();

    path.moveTo(0, size.height * 0.6067);
    path.quadraticBezierTo(size.width * 0.25, size.height * 0.875,
        size.width * 0.5, size.height * 0.9167);
    path.quadraticBezierTo(size.width * 0.75, size.height * 0.9584,
        size.width * 1.0, size.height * 0.9167);
    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}




