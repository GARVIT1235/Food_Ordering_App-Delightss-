//@dart=2.9
import 'package:flutter/material.dart';
import 'imagess.dart';


class ProductView extends StatelessWidget {

  final String image;
  final String name;
  final String description;
  final String quantity;
  final String mrp;
  final String wholesale;
  final Function onClick;
  final Function onDelete;


  ProductView({Key key,this.image,this.name,this.description,this.quantity,this.mrp,this.wholesale,this.onClick,this.onDelete}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Card(elevation: 0,
        child: Column(
          children: [
            Container(
                child: Row(mainAxisSize: MainAxisSize.min,mainAxisAlignment: MainAxisAlignment.start,crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Expanded(flex: 4,child: Container(height: MediaQuery.of(context).size.height*0.2,
                        child: Padding(
                          padding: EdgeInsets.all(4.0),
                          child: Container(child: Stack(children: [
                            Positioned(top: 0,child: Container(width: 80,height: 80,
                              padding: const EdgeInsets.all(8.0),
                              child: image!=null&&image.isNotEmpty?MyImage(imageUrl: image,):Icon(Icons.photo_size_select_actual_outlined),
                            )),
                          ],),),
                        ),
                      ),),
                      Expanded(flex: 6,child: Column(children: [
                        ListTile(title: Text(name,  style: TextStyle(
                          fontSize: 18.0,
                          color: Colors.black,
                          fontWeight: FontWeight.w500,
                          letterSpacing: 0.5,
                        ),),
                          subtitle: Text(description,  style: TextStyle(
                            fontSize: 14.0,
                          ),),
                        trailing: IconButton(padding: EdgeInsets.all(0),icon: Icon(Icons.delete_outline) , onPressed: onDelete),),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(width: MediaQuery.of(context).size.width,
                            decoration: BoxDecoration(border: Border.all(color: Colors.grey.shade300),borderRadius: BorderRadius.circular(4)),
                            padding: EdgeInsets.all(6),
                            child: Text('$quantity'),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 8,right: 8,top: 4),
                          child: Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(left: 8,),
                                child: Text('₹$wholesale',style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold,color: Colors.green),),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 8,),
                                child: Text('₹$mrp',style: TextStyle(fontSize: 14,color: Colors.grey,decoration: TextDecoration.lineThrough),),
                              ),
                            ],
                          ),
                        ),
                      ],))
                    ])
            ),
          ],
        ),
      ),
      onTap: onClick
    );
  }
}
