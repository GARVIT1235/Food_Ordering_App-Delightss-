//@dart=2.9
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:image_picker_for_web/image_picker_for_web.dart';
import 'package:firebase/firebase.dart' as fb;

class RegistrationEmployee extends StatefulWidget {
  const RegistrationEmployee({Key key}) : super(key: key);

  @override
  _RegistrationEmployeeState createState() => _RegistrationEmployeeState();
}

class _RegistrationEmployeeState extends State<RegistrationEmployee> {
  TextEditingController name=new TextEditingController();
  TextEditingController email=new TextEditingController();
  TextEditingController phone=new TextEditingController();
  TextEditingController deliveryLicence=new TextEditingController();
  TextEditingController adharNumber=new TextEditingController();
  TextEditingController registrationNO=new TextEditingController();
  String role;
  PickedFile bannerFile;
  final _picker = ImagePickerPlugin();


  @override
  Widget build(BuildContext context) {
    return Container(child: ListView(children: [
      Card(elevation: 0,child: SizedBox(height: 80,
          child: Container(alignment: Alignment.center,child: Text('New Employee',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20,color: Colors.white),),
            decoration: BoxDecoration(color: Colors.blueAccent,borderRadius: BorderRadius.circular(8)),))),
      Card(elevation: 0,
        child: Padding(
          padding: const EdgeInsets.only(left: 12,right: 12,bottom: 12),
          child: Column(crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 5),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text('Employee Details',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18),),
              ),
              SizedBox(height: 10,),
              Row(children: [
                Expanded(flex: 7,child: Container(),),
                Expanded(flex: 2,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(width: MediaQuery.of(context).size.width*0.1,height: MediaQuery.of(context).size.width*0.1,
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
              Row(crossAxisAlignment: CrossAxisAlignment.start,mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Expanded(child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(mainAxisAlignment: MainAxisAlignment.start,crossAxisAlignment: CrossAxisAlignment.start,children: <Widget>[
                      Text('Enter Name*',style: TextStyle(fontSize: 16),),
                      SizedBox(height: 6),
                      Container(padding: EdgeInsets.only(left: 8),
                        decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(8)),
                            border: Border.all(color: Colors.black)),
                        child: TextField(controller: name,
                          showCursor: true,textAlign: TextAlign.left,maxLines: 1,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintStyle: TextStyle(color: Color(0xFF666666),),
                            hintText: "name",
                          ),
                        ),
                      ),
                    ],),
                  ),),
                  Expanded(child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(mainAxisAlignment: MainAxisAlignment.start,crossAxisAlignment: CrossAxisAlignment.start,children: <Widget>[
                      Text('Select Role*',style: TextStyle(fontSize: 16),),
                      SizedBox(height: 6),
                      Container(padding: EdgeInsets.only(left: 8),
                        decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(8)),
                            border: Border.all(color: Colors.black)),
                        child: DropdownButton(
                          value: role,
                          icon: Icon(Icons.keyboard_arrow_down),
                          iconSize: 24,
                          elevation: 16,
                          isExpanded: true,
                          underline: Container(),
                          hint: Text('Roles'),
                          style: TextStyle(color: Colors.black),
                          onChanged: (v){
                            setState(() {
                              role=v;
                            });
                          },
                          items: ['Delivery Boy'].map((value) {
                            return DropdownMenuItem(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                        ),
                      ),
                    ],),
                  ),),
                ],),
              Row(crossAxisAlignment: CrossAxisAlignment.start,mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Expanded(child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(mainAxisAlignment: MainAxisAlignment.start,crossAxisAlignment: CrossAxisAlignment.start,children: <Widget>[
                      Text('Register Mail*',style: TextStyle(fontSize: 16),),
                      SizedBox(height: 6),
                      Container(padding: EdgeInsets.only(left: 8),
                        decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(8)),
                            border: Border.all(color: Colors.black)),
                        child: TextField(controller: email,
                          showCursor: true,textAlign: TextAlign.left,maxLines: 1,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintStyle: TextStyle(color: Color(0xFF666666),),
                            hintText: "Email",
                          ),
                        ),
                      ),
                    ],),
                  ),),
                  Expanded(child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(mainAxisAlignment: MainAxisAlignment.start,crossAxisAlignment: CrossAxisAlignment.start,children: <Widget>[
                      Text('Phone Number*',style: TextStyle(fontSize: 16),),
                      SizedBox(height: 6),
                      Container(padding: EdgeInsets.only(left: 8),
                        decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(8)),
                            border: Border.all(color: Colors.black)),
                        child: TextField(controller: phone,
                          showCursor: true,textAlign: TextAlign.left,maxLines: 1,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintStyle: TextStyle(color: Color(0xFF666666),),
                            hintText: "Number*",
                          ),
                        ),
                      ),
                    ],),
                  ),),
                ],),
              Row(crossAxisAlignment: CrossAxisAlignment.start,mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Expanded(child:  _form('Driving Licence*','licence no',deliveryLicence),),
                  Expanded(child:  _form('Adhar Number*','number',adharNumber),),
                ],),
              Row(crossAxisAlignment: CrossAxisAlignment.start,mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Expanded(child:  _form('Vehicle No*','no',registrationNO),),
                  Expanded(child:  Container(),),
                ],),
              SizedBox(height: 15,),
              Container(alignment: Alignment.centerRight,
                padding: EdgeInsets.only(right: 12),height: 40,
                child: RaisedButton(onPressed: (){
                  if(name.text.length>2&&bannerFile!=null){
                    _create();
                  }else{

                  }
                },child: Text('Save',style: TextStyle(color: Colors.white),),color: Colors.green,elevation: 0,),
              )
            ],
          ),
        ),
      )
    ],),);
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

  Future _create()async{
    FirebaseAuth auth=FirebaseAuth.instance;
    showDialog(context: context,builder: (context) {
      return Center(
          child: CircularProgressIndicator(backgroundColor: Colors.amber,)
      );
    }, barrierDismissible: false);

    try{
      var v=await auth.createUserWithEmailAndPassword(email: email.text.trim(), password: phone.text.trim());
      if(v!=null){
        _upload(v.user);
      }
    }catch(e){

      print(e.toString());
      Navigator.pop(context);
    }
  }

  Future _upload(FirebaseUser user)async {
    CollectionReference reference = Firestore.instance.collection('Employee');
    try {
      final filePath = '${DateTime.now()}.png';
      String banner;
      await bannerFile.readAsBytes().then((value) async {
        final ref = fb.storage()
            .refFromURL("gs://subgkart.appspot.com")
            .child("employee$filePath");
        await ref.put(value).future;
        banner = (await ref.getDownloadURL()).toString();
        reference.document(user.uid).setData({
          'name': name.text,
          'mail': email.text,
          'phone': phone.text,
          'role': role,
          'licence':deliveryLicence.text,
          'adharNO':adharNumber.text,
          'no':registrationNO.text,
          'image': banner
        }, merge: true).then((value) {
          setState(() {
            bannerFile = null;
          });
          Navigator.pop(context);
          setState(() {
            name.text = null;
            email.text = null;
            phone.text = null;
          });
          pickImage();
        }).catchError((onError) {
          Navigator.pop(context);
          print(onError.toString());
        });
      });
    } catch (e) {
      Navigator.pop(context);
    }
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
                  child: Text('',style:TextStyle(color: Colors.black),textAlign: TextAlign.center,),
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
