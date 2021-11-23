//@dart=2.9
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:image_picker_for_web/image_picker_for_web.dart';
import 'package:firebase/firebase.dart' as fb;
import 'package:ecom_admin_panel/models/data_provider.dart';

import 'componds/imagess.dart';

class Category extends StatefulWidget {
  @override
  _CategoryState createState() => _CategoryState();
}

class _CategoryState extends State<Category> {

  final ScrollController _view = ScrollController();
  TextEditingController name = TextEditingController();
  TextEditingController tag = TextEditingController();
  TextEditingController index = TextEditingController();
  TextEditingController sunname = TextEditingController();
  PickedFile category;
  PickedFile icon;
  StateSetter _setState;
  final _picker = ImagePickerPlugin();
  List<dynamic>sub=[];


  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      child: Container(
          child: Column(
            children: [
              SizedBox(height: 20),
              Container(
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        padding: const EdgeInsets.only(
                            top: 5, right: 8, left: 8, bottom: 5),
                        child: Text("Category",
                            style: TextStyle(
                                fontSize: 32,
                                fontWeight: FontWeight.w400,
                                color: Colors.black87)),
                      ),
                      Container(
                        child: RaisedButton(elevation: 0,
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                'Add New',
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                            color: Colors.green,
                            onPressed: () {
                          _addCategory();
                            }),
                      ),
                    ]),
              ),
              SizedBox(height: 20),
              StreamBuilder<QuerySnapshot>(
                stream: dataProvider.category(),
                builder: (context, snapshot) {
                  if(snapshot.hasData){
                    return Container(width: MediaQuery.of(context).size.width,
                      child: GridView.builder(
                        controller: _view,shrinkWrap: true,
                        itemCount: snapshot.data.documents.length,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3, childAspectRatio: 3 / 4.5,
                        ),
                        itemBuilder: (BuildContext context, int index) {
                          if(snapshot.hasData){
                            return customlist(snapshot.data.documents[index]);
                          }
                          return Center(child: CircularProgressIndicator());
                        },
                      ),
                    );
                  }
                  return Center(child: CircularProgressIndicator());
                }
              ),
            ],
          )),
    );
  }

  Widget customlist(DocumentSnapshot snapshot) {
    return Card(elevation: 0,
      child: Column(mainAxisSize: MainAxisSize.max,
        children: [
          Container(width: MediaQuery.of(context).size.width,
            height: 200,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                  topRight: Radius.circular(8),
                  topLeft: Radius.circular(8)),
            ),
            child: MyImage(imageUrl:snapshot.data['image']),
          ),
          Container(width: MediaQuery.of(context).size.width,
              child: ListTile(leading: Container(width: 80,height: 80,child: MyImage(imageUrl:snapshot.data['icon'])),
                title: Text('${snapshot.data['name']}',style: TextStyle(fontWeight: FontWeight.bold),),
                trailing: Container(width: 80,height: 80,
                  child: Row(children: [
                    IconButton(icon: Icon(Icons.add),onPressed: (){
                      _addSub(snapshot.documentID, snapshot.data['sub']);
                    },),
                    IconButton(icon: Icon(Icons.delete_outline_rounded),onPressed: (){

                    },)
                  ],),
                ),)
          ),
          Container(width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                  bottomRight: Radius.circular(15),
                  bottomLeft: Radius.circular(15)),
            ),
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: snapshot.data['tags']!=null?snapshot.data['tags'].length:0,
              itemBuilder: (_, i) => ListTile(
                  leading: Container(width: 80,height: 80,child: MyImage(imageUrl:snapshot.data['tags'][i]['image'])),
                  title: Text(snapshot.data['tags'][i]['name'].toString(),
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.normal,
                          color: Colors.black)),
                  subtitle: Text("tag :$i"),
                  trailing: IconButton(
                      icon: Icon(Icons.delete_outline_rounded),
                      tooltip: "delete item",
                      iconSize: 25,
                      onPressed: () {

                      })),
            ),
          ),
        ],
      ),
    );
  }



  _addCategory(){
    showDialog(
        context: context,
        builder: (context,) {
          return Dialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15.0),
            ),
            child: StatefulBuilder(
                builder: (BuildContext context, StateSetter setState) {
                  _setState=setState;
                  return Container(height: MediaQuery.of(context).size.height*0.8, width: MediaQuery.of(context).size.width*0.4,
                    child: Padding(
                      padding: EdgeInsets.all(6.0),
                      child: ListView(
                        children: [
                          SizedBox(height: 8),
                          Center(
                            child: Padding(
                                padding: EdgeInsets.all(15),
                                child: Text(
                                    "Add Category Details", style: TextStyle(
                                    fontSize: 40,
                                    fontWeight:
                                    FontWeight.w400,
                                    color:
                                    Colors.black87)
                                )),
                          ),
                          DottedBorder(child: GestureDetector(
                            child: Container(width: MediaQuery.of(context).size.width, height: MediaQuery.of(context).size.height*0.2, color: Colors.black12,
                              child: category!= null? Image.network(category.path) :Icon(Icons.image),),
                            onTap: () {
                              _startFilePicker();
                            },
                          ),
                          ),
                          SizedBox(height: 8),
                          DottedBorder(child: GestureDetector(
                            child: Container(width: MediaQuery.of(context).size.width, height: MediaQuery.of(context).size.height*0.2, color: Colors.black12,
                              child: icon!= null? Image.network(icon.path) :Icon(Icons.image),),
                            onTap: () {
                           _startIconPicker();
                            },
                          ),
                          ),
                          SizedBox(height: 8),
                          Center(
                            child: Container(
                              width: MediaQuery
                                  .of(context)
                                  .size
                                  .width * 0.3,
                              decoration: BoxDecoration(
                                  border: Border.all(
                                    color: Colors.black38,
                                    width: 2,
                                  ),
                                  borderRadius:
                                  BorderRadius.circular(
                                      20)),
                              child: TextFormField(
                                controller: name,
                                autofocus: false,
                                decoration: InputDecoration(
                                  hintText: 'Name',
                                  border: InputBorder.none,
                                  contentPadding: EdgeInsets.fromLTRB(
                                      20.0, 10.0, 20.0, 10.0),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(height: 8),

                          SizedBox(height: 8),
                          Center(
                            child: Container(
                              width: MediaQuery
                                  .of(context)
                                  .size
                                  .width * 0.3,
                              decoration: BoxDecoration(border: Border.all(
                                color: Colors.black38, width: 1,),
                                  borderRadius:
                                  BorderRadius.circular(
                                      20)),
                              child: TextFormField(
                                autofocus: false,
                                controller: index,
                                decoration: InputDecoration(
                                  hintText: 'Index',
                                  border: InputBorder.none,
                                  contentPadding: EdgeInsets.fromLTRB(
                                      20.0, 10.0, 20.0, 10.0),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(height: 30),
                          RaisedButton(elevation: 0,child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text('ADD',style: TextStyle(color: Colors.white,),),
                          ),
                            onPressed: () {
                              _upload();
                            }, color: Colors.green,)
                        ],
                      ),
                    ),
                  );
                })
          );
        });
  }

  _startFilePicker() async {
    final im=await _picker.pickImage(source: ImageSource.gallery,imageQuality: 70);
    _setState(() {
      category=im;
    });
    setState(() {

    });
  }

  _startIconPicker()async{
    final im=await _picker.pickImage(source: ImageSource.gallery,imageQuality: 70);
    _setState(() {
      icon=im;
    });
    setState(() {

    });
  }

  Future _upload()async{
    Navigator.pop(context);
    final filePath = 'category/${DateTime.now()}.png';
    final iconPath = 'icon/${DateTime.now()}.png';
    showDialog(context: context,builder: (context) {
      return Center(
          child: CircularProgressIndicator(backgroundColor: Colors.amber,)
      );
    }, barrierDismissible: false);
    String catogoryUrl;
    String iconUrl;
    if(category!=null&&icon!=null){
      await category.readAsBytes().then((value)async{
        final ref = fb.storage().refFromURL("gs://atus-kart.appspot.com").child("$filePath");
        await ref.put(value).future;
        catogoryUrl = (await ref.getDownloadURL()).toString();
        icon.readAsBytes().then((value)async{
          final ref = fb.storage().refFromURL("gs://atus-kart.appspot.com").child("$iconPath");
          await ref.put(value).future;
          iconUrl = (await ref.getDownloadURL()).toString();
          if(catogoryUrl!=null&&iconUrl!=null){
            CollectionReference reference=Firestore.instance.collection('Category');
            reference.document().setData({
              'index':index.text,
              'name':name.text,
              'tag':name.text,
              'icon':iconUrl,
              'image':catogoryUrl,
            },merge: true).then((value) {
              setState(() {
                index.text=null;
                tag.text=null;
                icon=null;
                category=null;
              });
              setState(() {

              });
            }).catchError((onError){
              print(onError.toString());
            });
          }
        });
      });
    }
    Navigator.pop(context);
  }

  _addSub(String document,List<dynamic>s){
    showDialog(
        context: context,
        builder: (context,) {
          return Dialog(
            shape: RoundedRectangleBorder(
              borderRadius:
              BorderRadius.circular(15.0),
            ),
            child: StatefulBuilder(
                builder: (BuildContext context, StateSetter setState) {
                  _setState=setState;
                  return Container(height: MediaQuery.of(context).size.height*0.6,
                    width: MediaQuery.of(context).size.width*0.4,
                    child: Padding(
                      padding: EdgeInsets.all(20),
                      child: ListView(
                        children: [
                          SizedBox(height: 8),
                          Center(
                            child: Padding(
                                padding: EdgeInsets.all(30),
                                child: Text(
                                    "Add Sub Category",
                                    style: TextStyle(
                                        fontSize: 40,
                                        fontWeight:
                                        FontWeight.w400,
                                        color: Colors
                                            .black87))),
                          ),
                          SizedBox(height: 8),
                          DottedBorder(child: GestureDetector(
                            child: Container(width: MediaQuery.of(context).size.width,
                              height: MediaQuery.of(context).size.height*0.2, color: Colors.black12,
                              child: icon != null?Image.network(icon.path):Icon(Icons.image),),
                            onTap: () {
                              _startIconPicker();
                            },
                          ),
                          ),
                          SizedBox(height: 4),
                          Center(
                            child: Container(
                              width: MediaQuery.of(context).size.width*0.3,
                              // margin: EdgeInsets.symmetric(horizontal: 20),
                              decoration: BoxDecoration(
                                  border: Border.all(
                                    color: Colors.black38, width: 2),
                                  borderRadius: BorderRadius.circular(20)),
                              child: TextFormField(
                                controller: sunname,
                                autofocus: false,
                                decoration: InputDecoration(
                                  hintText: 'sub category',
                                  border: InputBorder.none,
                                  contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0)),
                              ),
                            ),
                          ),
                          SizedBox(height: 30),
                          RaisedButton(color: Colors.lightGreen, child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text('ADD Sub Category',
                              style: TextStyle(color: Colors.white),),
                          ),
                            onPressed: () {
                            if(s!=null){
                              setState((){
                                sub=List.from(s);
                              });
                            }
                              _uploadSub(document);
                            },)
                        ],
                      ),
                    ),
                  );
                }),
          );
        });
  }

  Future _uploadSub(String document)async{
    Navigator.pop(context);
    CollectionReference tags=Firestore.instance.collection('Tags');
    final iconPath = 'icon/${DateTime.now()}.png';
    showDialog(context: context,builder: (context) {
      return Center(
          child: CircularProgressIndicator(backgroundColor: Colors.amber,)
      );
    }, barrierDismissible: false);
    String iconUrl;
    if(icon!=null){
      icon.readAsBytes().then((value)async{
        final ref = fb.storage().refFromURL("gs://atus-kart.appspot.com").child("$iconPath");
        await ref.put(value).future;
        iconUrl = (await ref.getDownloadURL()).toString();
        var v={
          'name':sunname.text,
          'image':iconUrl
        };
        sub.add(v);
        await tags.document().setData(v);
        CollectionReference reference=Firestore.instance.collection('Category');
        reference.document(document).setData({
          'tags':sub,
        },merge: true).then((value) {
          setState(() {
            index.text=null;
            tag.text=null;
            icon=null;
            category=null;
            sub=null;
          });
          setState(() {

          });
        });
      });
    }
    Navigator.pop(context);
  }


  _deleteCategory(String name){
    showDialog(
        context: context,
        builder: (
            context,
            ) {
          return Dialog(
            shape: RoundedRectangleBorder(
              borderRadius:
              BorderRadius.circular(15.0),
            ),
            child: StatefulBuilder(
            builder: (BuildContext context, StateSetter setState) {
              return Container(
                height:
                MediaQuery.of(context).size.height *
                    0.5,
                width:
                MediaQuery.of(context).size.width *
                    0.5,
                child: Padding(
                  padding: EdgeInsets.all(10),
                  child: Column(
                    crossAxisAlignment:
                    CrossAxisAlignment.start,
                    mainAxisAlignment:
                    MainAxisAlignment.center,
                    children: [
                      SizedBox(height: 8),
                      Center(
                        child: Padding(
                            padding: EdgeInsets.all(10),
                            child: Text(
                                "Are you sure do you want to delete ${name}",
                                textAlign:
                                TextAlign.center,
                                style: TextStyle(
                                    fontSize: 36,
                                    fontWeight:
                                    FontWeight.w400,
                                    color: Colors
                                        .black87))),
                      ),
                      SizedBox(height: 30),
                      Center(
                        child: Container(
                          padding: EdgeInsets.only(
                              left: 6, right: 6),
                          margin: EdgeInsets.all(6),
                          width: MediaQuery.of(context)
                              .size
                              .width *
                              0.2,
                          height: 40,
                          decoration: BoxDecoration(
                              color: Theme.of(context)
                                  .accentColor,
                              gradient: LinearGradient(
                                  colors: [
                                    Color.fromRGBO(116,
                                        116, 191, 1.0),
                                    Color.fromRGBO(52,
                                        138, 199, 1.0)
                                  ]),
                              borderRadius:
                              BorderRadius.circular(
                                  6),
                              border: Border.all(
                                  color: Colors
                                      .transparent,
                                  width: 0)),
                          child: Material(
                            color: Colors.transparent,
                            child: InkWell(
                                highlightColor:
                                Theme.of(context)
                                    .highlightColor,
                                splashColor:
                                Theme.of(context)
                                    .splashColor,
                                child: Center(
                                  child: Text(
                                    "delete",
                                    style: TextStyle(
                                        color:
                                        Colors.white,
                                        fontSize: 16,
                                        fontWeight:
                                        FontWeight
                                            .w300),
                                  ),
                                ),
                                onTap: (){

                                }
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
          })
          );
        });
  }



  _deleteSub(String name){
    showDialog(
        context: context,
        builder: (
            context,
            ) {
          return Dialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15.0),
            ),
            child: Container(
              height:
              MediaQuery.of(context).size.height *
                  0.5,
              width: MediaQuery.of(context).size.width *
                  0.4,
              child: Padding(
                padding: EdgeInsets.all(10),
                child: Column(
                  crossAxisAlignment:
                  CrossAxisAlignment.start,
                  mainAxisAlignment:
                  MainAxisAlignment.center,
                  children: [
                    SizedBox(height: 8),
                    Center(
                      child: Padding(
                          padding: EdgeInsets.all(10),
                          child: Text(
                              "Are you sure do you want to delete \n $name ",
                              textAlign:
                              TextAlign.center,
                              style: TextStyle(
                                  fontSize: 36,
                                  fontWeight:
                                  FontWeight.w400,
                                  color:
                                  Colors.black87))),
                    ),
                    SizedBox(height: 30),
                    Center(
                      child: Container(
                        padding: EdgeInsets.only(
                            left: 6, right: 6),
                        margin: EdgeInsets.all(6),
                        width: MediaQuery.of(context)
                            .size
                            .width *
                            0.2,
                        height: 40,
                        decoration: BoxDecoration(
                            color: Theme.of(context)
                                .accentColor,
                            gradient:
                            LinearGradient(colors: [
                              Color.fromRGBO(
                                  116, 116, 191, 1.0),
                              Color.fromRGBO(
                                  52, 138, 199, 1.0)
                            ]),
                            borderRadius:
                            BorderRadius.circular(
                                6),
                            border: Border.all(
                                color:
                                Colors.transparent,
                                width: 0)),
                        child: Material(
                          color: Colors.transparent,
                          child: InkWell(
                              highlightColor:
                              Theme.of(context)
                                  .highlightColor,
                              splashColor:
                              Theme.of(context)
                                  .splashColor,
                              child: Center(
                                child: Text(
                                  "delete",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 16,
                                      fontWeight:
                                      FontWeight
                                          .w300),
                                ),
                              ),
                              onTap: () {

                              }
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        });
  }
}
