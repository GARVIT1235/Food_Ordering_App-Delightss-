//@dart=2.9
import 'dart:math';
import 'package:firebase/firebase.dart' as fb;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:image_picker_for_web/image_picker_for_web.dart';
import 'package:timelines/timelines.dart';

import 'models/data_provider.dart';


class ShopRegister extends StatefulWidget {
  const ShopRegister({Key key}) : super(key: key);

  @override
  _ShopRegisterState createState() => _ShopRegisterState();
}

class _ShopRegisterState extends State<ShopRegister> {

  TextEditingController name=new TextEditingController();
  TextEditingController description=new TextEditingController();
  TextEditingController mrp=new TextEditingController();
  TextEditingController price=new TextEditingController();
  TextEditingController selling=new TextEditingController();
  TextEditingController quantity=new TextEditingController();
  String tags1;
  String category1;
  String tags2;
  String category2;
  String pincode;
  int index=0;
  bool check=false;

  PickedFile bannerFile;
  final _picker = ImagePickerPlugin();


  @override
  Widget build(BuildContext context) {
    return Container(padding: EdgeInsets.only(right: 32),child: ListView(padding: EdgeInsets.all(12),shrinkWrap: true,
      children: [
      Card(elevation: 0,child: SizedBox(height: 80,
          child: Container(alignment: Alignment.center,child: Text('New Product',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20,color: Colors.white),),
      decoration: BoxDecoration(color: Colors.blueAccent,borderRadius: BorderRadius.circular(8)),))),
      Card(elevation: 0,child: SizedBox(height: 100,child: TimeLineViews(index))),
      index==0?_register():index==1?_personal():index==2?_accountDetails():index==3?_address():_complete()
    ],),);
  }

  _register(){
    return Card(elevation: 0,
      child: Padding(
        padding: const EdgeInsets.only(left: 12,right: 12,bottom: 12),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 5),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text('Product Details',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18),),
            ),
            SizedBox(height: 10,),
            Row(crossAxisAlignment: CrossAxisAlignment.start,mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Expanded(child: Column(children: [
                  _form('Enter Product Name','Product name',name),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(mainAxisAlignment: MainAxisAlignment.start,crossAxisAlignment: CrossAxisAlignment.start,children: <Widget>[
                      Text('Product Description',style: TextStyle(fontSize: 16),),
                      SizedBox(height: 6),
                      Container(padding: EdgeInsets.only(left: 8),
                        decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(8)),
                            border: Border.all(color: Colors.black)),
                        child: TextField(controller: description,
                          showCursor: true,textAlign: TextAlign.left,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintStyle: TextStyle(color: Color(0xFF666666),),
                            hintText: "description",
                          ),
                        ),
                      ),
                    ],),
                  )
                ],),),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(width: MediaQuery.of(context).size.width*0.3,height: MediaQuery.of(context).size.width*0.15,
                      color: Colors.white,
                      child: DottedBorder(
                        color: Colors.black,
                        strokeWidth: 1,
                        child: bannerFile==null?Center(
                          child: IconButton(icon: Icon(Icons.add_a_photo_outlined), onPressed: (){
                            _startFilePicker();
                          }),
                        ):Image.network(bannerFile.path,
                          width: MediaQuery.of(context).size.width,fit: BoxFit.cover,),
                      ),
                    ),
                  ),
                ),
              ],),
            SizedBox(height: 15,),
            Container(alignment: Alignment.centerRight,
              padding: EdgeInsets.only(right: 12),height: 40,
              child: RaisedButton(onPressed: (){
                if(name.text.length>2&&description.text.length>5&&bannerFile!=null){
                  setState(() {
                    index=1;
                  });
                }
              },child: Text('Next',style: TextStyle(color: Colors.white),),color: Colors.green,elevation: 0,),
            )
          ],
        ),
      ),
    );
  }


  _personal(){
    return  Card(elevation: 0,
      child: Padding(
        padding: const EdgeInsets.only(left: 12,right: 12,bottom: 12),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 5),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text('Product Filter',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18),),
            ),
            SizedBox(height: 10,),
            Row(
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(mainAxisAlignment: MainAxisAlignment.start,crossAxisAlignment: CrossAxisAlignment.start,children: <Widget>[
                      Text('Select Category',style: TextStyle(fontSize: 16),),
                      SizedBox(height: 6),
                      Container(padding: EdgeInsets.only(left: 8,right: 8),
                        decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(8)),
                            border: Border.all(color: Colors.black)),
                        child: StreamBuilder<QuerySnapshot>(
                          stream: dataProvider.category(),
                          builder: (context, snapshot) {
                            return DropdownButton(
                              value: tags1,
                              icon: Icon(Icons.keyboard_arrow_down),
                              iconSize: 24,
                              elevation: 16,
                              isExpanded: true,
                              underline: Container(),
                              hint: Text('Category'),
                              style: TextStyle(color: Colors.black),
                              onChanged: (v){
                                setState(() {
                                  tags1=v;
                                });
                              },
                              items: snapshot.data.documents.map((value) {
                                return DropdownMenuItem(
                                  value: value.data['tag'],
                                  child: Text(value.data['tag']),
                                );
                              }).toList(),
                            );
                          }
                        ),
                      ),
                    ],),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(mainAxisAlignment: MainAxisAlignment.start,crossAxisAlignment: CrossAxisAlignment.start,children: <Widget>[
                      Text('Select Sub Category',style: TextStyle(fontSize: 16),),
                      SizedBox(height: 6),
                      Container(padding: EdgeInsets.only(left: 8,right: 8),
                        decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(8)),
                            border: Border.all(color: Colors.black)),
                        child: StreamBuilder<QuerySnapshot>(
                            stream: dataProvider.category(),
                            builder: (context, snapshot) {
                              return DropdownButton(
                                value: category1,
                                icon: Icon(Icons.keyboard_arrow_down),
                                iconSize: 24,
                                elevation: 16,
                                isExpanded: true,
                                underline: Container(),
                                hint: Text('Category'),
                                style: TextStyle(color: Colors.black),
                                onChanged: (v){
                                  setState(() {
                                    category1=v;
                                  });
                                },
                                items: snapshot.data.documents.map((value) {
                                  return DropdownMenuItem(
                                    value: value.data['tag'],
                                    child: Text(value.data['tag']),
                                  );
                                }).toList(),
                              );
                            }
                        ),
                      ),
                    ],),
                  ),
                ),
              ],
            ),
            Row(
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(mainAxisAlignment: MainAxisAlignment.start,crossAxisAlignment: CrossAxisAlignment.start,children: <Widget>[
                      Text('Select Category',style: TextStyle(fontSize: 16),),
                      SizedBox(height: 6),
                      Container(padding: EdgeInsets.only(left: 8,right: 8),
                        decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(8)),
                            border: Border.all(color: Colors.black)),
                        child: StreamBuilder<QuerySnapshot>(
                            stream: dataProvider.category(),
                            builder: (context, snapshot) {
                              return DropdownButton(
                                value: category1,
                                icon: Icon(Icons.keyboard_arrow_down),
                                iconSize: 24,
                                elevation: 16,
                                isExpanded: true,
                                underline: Container(),
                                hint: Text('Category'),
                                style: TextStyle(color: Colors.black),
                                onChanged: (v){
                                  setState(() {
                                    category1=v;
                                  });
                                },
                                items: snapshot.data.documents.map((value) {
                                  return DropdownMenuItem(
                                    value: value.data['tag'],
                                    child: Text(value.data['tag']),
                                  );
                                }).toList(),
                              );
                            }
                        ),
                      ),
                    ],),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(mainAxisAlignment: MainAxisAlignment.start,crossAxisAlignment: CrossAxisAlignment.start,children: <Widget>[
                      Text('Select Category',style: TextStyle(fontSize: 16),),
                      SizedBox(height: 6),
                      Container(padding: EdgeInsets.only(left: 8,right: 8),
                        decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(8)),
                            border: Border.all(color: Colors.black)),
                        child: StreamBuilder<QuerySnapshot>(
                            stream: dataProvider.category(),
                            builder: (context, snapshot) {
                              return DropdownButton(
                                value: category1,
                                icon: Icon(Icons.keyboard_arrow_down),
                                iconSize: 24,
                                elevation: 16,
                                isExpanded: true,
                                underline: Container(),
                                hint: Text('Category'),
                                style: TextStyle(color: Colors.black),
                                onChanged: (v){
                                  setState(() {
                                    category1=v;
                                  });
                                },
                                items: snapshot.data.documents.map((value) {
                                  return DropdownMenuItem(
                                    value: value.data['tag'],
                                    child: Text(value.data['tag']),
                                  );
                                }).toList(),
                              );
                            }
                        ),
                      ),
                    ],),
                  ),
                ),
              ],
            ),
            SizedBox(height: 15,),
            Container(alignment: Alignment.centerRight,
              padding: EdgeInsets.only(right: 12),height: 40,
              child: Row(mainAxisSize: MainAxisSize.min,
                children: [
                  RaisedButton(onPressed: (){
                    setState(() {
                      index=0;
                    });
                  },child: Text('Back',style: TextStyle(color: Colors.black),),elevation: 0,),
                  SizedBox(width: 8,),
                  RaisedButton(onPressed: (){
                    if(category1!=null&&tags1!=null){
                      setState(() {
                        index=2;
                      });
                    }
                  },child: Text('Next',style: TextStyle(color: Colors.white),),color: Colors.green,elevation: 0,),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }


  _accountDetails(){
    return  Card(elevation: 0,
      child: Padding(
        padding: const EdgeInsets.only(left: 12,right: 12,bottom: 12),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 5),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text('Price Details',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18),),
            ),
            SizedBox(height: 10,),
            Row(crossAxisAlignment: CrossAxisAlignment.start,mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Expanded(child:  _form('Quantity','Quantity',quantity),),
                Expanded(child:  Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(mainAxisAlignment: MainAxisAlignment.start,crossAxisAlignment: CrossAxisAlignment.start,children: <Widget>[
                    Text('M.R.P',style: TextStyle(fontSize: 16),),
                    SizedBox(height: 6),
                    Container(padding: EdgeInsets.only(left: 8),
                      decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(8)),
                          border: Border.all(color: Colors.black)),
                      child: TextField(controller: mrp,
                        showCursor: true,textAlign: TextAlign.left,
                        keyboardType: TextInputType.number,
                        inputFormatters: <TextInputFormatter>[
                          FilteringTextInputFormatter.digitsOnly
                        ],
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintStyle: TextStyle(color: Color(0xFF666666),),
                          hintText: "m.r.p",
                        ),
                      ),
                    ),
                  ],),
                )),
              ],),
            Row(crossAxisAlignment: CrossAxisAlignment.start,mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Expanded(child:  Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(mainAxisAlignment: MainAxisAlignment.start,crossAxisAlignment: CrossAxisAlignment.start,children: <Widget>[
                    Text('Price',style: TextStyle(fontSize: 16),),
                    SizedBox(height: 6),
                    Container(padding: EdgeInsets.only(left: 8),
                      decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(8)),
                          border: Border.all(color: Colors.black)),
                      child: TextField(controller: price,
                        showCursor: true,textAlign: TextAlign.left,
                        keyboardType: TextInputType.number,
                        inputFormatters: <TextInputFormatter>[
                          FilteringTextInputFormatter.digitsOnly
                        ],
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintStyle: TextStyle(color: Color(0xFF666666),),
                          hintText: "price",
                        ),
                      ),
                    ),
                  ],),
                ),),
                Expanded(child:  Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(mainAxisAlignment: MainAxisAlignment.start,crossAxisAlignment: CrossAxisAlignment.start,children: <Widget>[
                    Text('Selling Price',style: TextStyle(fontSize: 16),),
                    SizedBox(height: 6),
                    Container(padding: EdgeInsets.only(left: 8),
                      decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(8)),
                          border: Border.all(color: Colors.black)),
                      child: TextField(controller: selling,
                        showCursor: true,textAlign: TextAlign.left,
                        keyboardType: TextInputType.number,
                        inputFormatters: <TextInputFormatter>[
                          FilteringTextInputFormatter.digitsOnly
                        ],
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintStyle: TextStyle(color: Color(0xFF666666),),
                          hintText: "selling price",
                        ),
                      ),
                    ),
                  ],),
                ),),
              ],),
            SizedBox(height: 15,),
            Container(alignment: Alignment.centerRight,
              padding: EdgeInsets.only(right: 12),height: 40,
              child: Row(mainAxisSize: MainAxisSize.min,
                children: [
                  RaisedButton(onPressed: (){
                    setState(() {
                      index=1;
                    });
                  },child: Text('Back',style: TextStyle(color: Colors.black),),elevation: 0,),
                  SizedBox(width: 8,),
                  RaisedButton(onPressed: (){
                    if(quantity.text.length>0&&mrp.text.length>0&&price.text.length>0){
                      setState(() {
                        index=3;
                      });
                    }
                  },child: Text('Next',style: TextStyle(color: Colors.white),),color: Colors.green,elevation: 0,),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }


  _address(){
    return  Card(elevation: 0,
      child: Padding(
        padding: const EdgeInsets.only(left: 12,right: 12,bottom: 12),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 5),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text('Regions Details',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18),),
            ),
            SizedBox(height: 10,),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(mainAxisAlignment: MainAxisAlignment.start,crossAxisAlignment: CrossAxisAlignment.start,children: <Widget>[
                Text('Pincode*',style: TextStyle(fontSize: 16),),
                SizedBox(height: 6),
                Container(padding: EdgeInsets.only(left: 8,right: 8),
                  decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(8)),
                      border: Border.all(color: Colors.black)),
                  child: StreamBuilder<QuerySnapshot>(
                      stream: dataProvider.regions(null),
                      builder: (context, snapshot) {
                        if(snapshot.hasData){
                          return DropdownButton(
                            value: pincode,
                            icon: Icon(Icons.keyboard_arrow_down),
                            iconSize: 24,
                            elevation: 16,
                            isExpanded: true,
                            underline: Container(),
                            hint: Text('Pincode'),
                            style: TextStyle(color: Colors.black),
                            onChanged: (v){
                              setState(() {
                                pincode=v;
                              });
                            },
                            items: snapshot.data.documents.map((value) {
                              return DropdownMenuItem(
                                value: value.data['pincode'].toString(),
                                child: Text(value.data['pincode'].toString()),
                                onTap: (){
                                  pincode=value.data['pincode'];
                                  setState(() {

                                  });
                                },
                              );
                            }).toList(),
                          );
                        }else{
                          return Text('Something went wrong');
                        }
                      }
                  ),
                ),
              ],),
            ),
            SizedBox(height: 15,),
            Container(alignment: Alignment.centerRight,
              padding: EdgeInsets.only(right: 12),height: 40,
              child: Row(mainAxisSize: MainAxisSize.min,
                children: [
                  RaisedButton(onPressed: (){
                    setState(() {
                      index=2;
                    });
                  },child: Text('Back',style: TextStyle(color: Colors.black),),elevation: 0,),
                  SizedBox(width: 8,),
                  RaisedButton(onPressed: (){
                    if(pincode!=null){
                      setState(() {
                        index=4;
                      });
                    }
                  },child: Text('Next',style: TextStyle(color: Colors.white),),color: Colors.green,elevation: 0,),
                ],
              ),
            ),

          ],
        ),
      ),
    );
  }

  _complete(){
    return  Card(elevation: 0,
      child: Padding(
        padding: const EdgeInsets.only(left: 12,right: 12,bottom: 12),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 15),
            ListTile(leading: Checkbox(value: check,onChanged: (val){
              setState(() {
                check=val;
              });
            },),title: Text('All the details are verified'),),
            SizedBox(height: 15,),
            Container(alignment: Alignment.centerRight,
              padding: EdgeInsets.only(right: 12),height: 40,
              child: Row(mainAxisSize: MainAxisSize.min,
                children: [
                  RaisedButton(onPressed: (){
                    setState(() {
                      index=3;
                    });
                  },child: Text('Back',style: TextStyle(color: Colors.black),),elevation: 0,),
                  SizedBox(width: 8,),
                  RaisedButton(onPressed: (){
                    if(check){
                      _upload();
                    }
                  },child: Text('Verify',style: TextStyle(color: Colors.white),),color: Colors.green,elevation: 0,),
                ],
              ),
            ),

          ],
        ),
      ),
    );
  }

  _form(String title,String hint,TextEditingController controller){
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(mainAxisAlignment: MainAxisAlignment.start,crossAxisAlignment: CrossAxisAlignment.start,children: <Widget>[
        Text('$title',style: TextStyle(fontSize: 16),),
        SizedBox(height: 6),
        Container(padding: EdgeInsets.only(left: 8),
          decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(8)),
              border: Border.all(color: Colors.black)),
          child: TextField(controller: controller,
            showCursor: true,textAlign: TextAlign.left,
            decoration: InputDecoration(
              border: InputBorder.none,
              hintStyle: TextStyle(color: Color(0xFF666666),),
              hintText: "$hint",
            ),
          ),
        ),
      ],),
    );
  }

  _startFilePicker() async {
    final im=await _picker.pickImage(source: ImageSource.gallery,imageQuality: 70);
    setState(() {
      bannerFile=im;
    });
    if(bannerFile!=null){

    }
  }


  Future _upload()async{
    showDialog(context: context,builder: (context) {
      return Center(
          child: CircularProgressIndicator(backgroundColor: Colors.amber,)
      );
    }, barrierDismissible: false);
    final filePath = '${DateTime.now()}.png';
    String banner;
    await bannerFile.readAsBytes().then((value)async{
      final ref = fb.storage().refFromURL("gs://subgkart.appspot.com").child("shops$filePath");
      await ref.put(value).future;
      banner = (await ref.getDownloadURL()).toString();
      CollectionReference reference=Firestore.instance.collection('Products');
      reference.document().setData({
        'name':name.text,
        'description':description.text,
        'quantity':quantity.text,
        'mrp':double.parse(mrp.text),
        'image':banner,
        'price':double.parse(price.text),
        'selling':double.parse(selling.text),
        'pincode':pincode,
        'category':[category1,category2],
        'tags':[tags1,tags2],
      },merge: true).then((value) {
        setState(() {
          bannerFile=null;
        });
        Navigator.pop(context);
        setState(() {
          index=0;
          name.text=null;
          description.text=null;
          quantity.text=null;
        });
        pickImage();
      }).catchError((onError){
        Navigator.pop(context);
        print(onError.toString());
      });
    });
  }

  void pickImage(){
    showDialog(context: context, builder: (context)=>Center(
      child: Container(width: MediaQuery.of(context).size.width*0.4,
        child: Card(
          margin: EdgeInsets.symmetric(horizontal: 34),
          child: Padding(
            padding: EdgeInsets.all(12),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Center(child: Icon(Icons.check_circle_outlined,size: 65,color: Colors.green,),),
                SizedBox(height: 25),
                Text('Registration Successful',style: TextStyle(color: Colors.black,fontSize: 18)),
                SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.only(left: 8,right: 8),
                  child: Text('Now you can start updating your products in store',style:TextStyle(color: Colors.black),textAlign: TextAlign.center,),
                ),
                SizedBox(height: 25),
                Container(width: 200,
                  child: MaterialButton(elevation: 0,
                      color: Color(0xfff6615e),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8),),
                      child: Text("OK", style: TextStyle(color: Colors.white,),),
                      onPressed: () async{
                        Navigator.pop(context);
                      }
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    ));
  }

}



const kTileHeight = 50.0;

const completeColor = Color(0xff5e6172);
const inProgressColor = Color(0xff5ec792);
const todoColor = Color(0xffd1d2d7);



class TimeLineViews extends StatelessWidget {

  TimeLineViews(this._processIndex);
  final int _processIndex;

  Color getColor(int index) {
    if (index == _processIndex) {
      return inProgressColor;
    } else if (index < _processIndex) {
      return completeColor;
    } else {
      return todoColor;
    }
  }

  final List<IconData>icons=[
    Icons.app_registration,
    Icons.person,
    Icons.account_balance,
    Icons.location_on_outlined,
    Icons.check_circle_outline
  ];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Timeline.tileBuilder(
        theme: TimelineThemeData(
          direction: Axis.horizontal,
          connectorTheme: ConnectorThemeData(
            space: 30.0,
            thickness: 5.0,
          ),
        ),
        builder: TimelineTileBuilder.connected(
          connectionDirection: ConnectionDirection.before,
          itemExtentBuilder: (_, __) =>
          MediaQuery.of(context).size.width*0.15,
          contentsBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.only(top: 15.0),
              child: Text(
                _processes[index],
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: getColor(index),
                ),
              ),
            );
          },
          indicatorBuilder: (_, index) {
            var color;
            var child;
            if (index == _processIndex) {
              color = inProgressColor;
              child = Padding(
                padding: const EdgeInsets.all(8.0),
                child: CircularProgressIndicator(
                  strokeWidth: 3.0,
                  valueColor: AlwaysStoppedAnimation(Colors.white),
                ),
              );
            } else if (index < _processIndex) {
              color = completeColor;
              child = Icon(
                Icons.check,
                color: Colors.white,
                size: 15.0,
              );
            } else {
              color = todoColor;
            }

            if (index <= _processIndex) {
              return Stack(
                children: [
                  CustomPaint(
                    size: Size(30.0, 30.0),
                    painter: _BezierPainter(
                      color: color,
                      drawStart: index > 0,
                      drawEnd: index < _processIndex,
                    ),
                  ),
                  DotIndicator(
                    size: 30.0,
                    color: color,
                    child: child,
                  ),
                ],
              );
            } else {
              return Stack(
                children: [
                  CustomPaint(
                    size: Size(15.0, 15.0),
                    painter: _BezierPainter(
                      color: color,
                      drawEnd: index < _processes.length - 1,
                    ),
                  ),
                  OutlinedDotIndicator(
                    borderWidth: 4.0,
                    color: color,
                  ),
                ],
              );
            }
          },
          connectorBuilder: (_, index, type) {
            if (index > 0) {
              if (index == _processIndex) {
                final prevColor = getColor(index - 1);
                final color = getColor(index);
                List<Color> gradientColors;
                if (type == ConnectorType.start) {
                  gradientColors = [Color.lerp(prevColor, color, 0.5), color];
                } else {
                  gradientColors = [
                    prevColor,
                    Color.lerp(prevColor, color, 0.5)
                  ];
                }
                return DecoratedLineConnector(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: gradientColors,
                    ),
                  ),
                );
              } else {
                return SolidLineConnector(
                  color: getColor(index),
                );
              }
            } else {
              return null;
            }
          },
          itemCount: _processes.length,
        ),
      ),
    );
  }

}


/// hardcoded bezier painter
/// TODO: Bezier curve into package component
class _BezierPainter extends CustomPainter {
  const _BezierPainter({
    this.color,
    this.drawStart = true,
    this.drawEnd = true,
  });

  final Color color;
  final bool drawStart;
  final bool drawEnd;

  Offset _offset(double radius, double angle) {
    return Offset(
      radius * cos(angle) + radius,
      radius * sin(angle) + radius,
    );
  }

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..style = PaintingStyle.fill
      ..color = color;

    final radius = size.width / 2;

    var angle;
    var offset1;
    var offset2;

    var path;

    if (drawStart) {
      angle = 3 * pi / 4;
      offset1 = _offset(radius, angle);
      offset2 = _offset(radius, -angle);
      path = Path()
        ..moveTo(offset1.dx, offset1.dy)
        ..quadraticBezierTo(0.0, size.height / 2, -radius,
            radius) // TODO connector start & gradient
        ..quadraticBezierTo(0.0, size.height / 2, offset2.dx, offset2.dy)
        ..close();

      canvas.drawPath(path, paint);
    }
    if (drawEnd) {
      angle = -pi / 4;
      offset1 = _offset(radius, angle);
      offset2 = _offset(radius, -angle);

      path = Path()
        ..moveTo(offset1.dx, offset1.dy)
        ..quadraticBezierTo(size.width, size.height / 2, size.width + radius,
            radius) // TODO connector end & gradient
        ..quadraticBezierTo(size.width, size.height / 2, offset2.dx, offset2.dy)
        ..close();

      canvas.drawPath(path, paint);
    }
  }

  @override
  bool shouldRepaint(_BezierPainter oldDelegate) {
    return oldDelegate.color != color ||
        oldDelegate.drawStart != drawStart ||
        oldDelegate.drawEnd != drawEnd;
  }
}

final _processes = [
  'Product Details',
  'Product Filter',
  'Price Details',
  'Regions Details',
  'Verify',
];