
//@dart=2.9
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:image_picker_for_web/image_picker_for_web.dart';
import 'package:firebase/firebase.dart' as fb;
import 'componds/banner_view.dart';
import 'models/data_provider.dart';

class Banners extends StatefulWidget {
  const Banners({Key key}) : super(key: key);

  @override
  _BannersState createState() => _BannersState();
}

class _BannersState extends State<Banners> {

  PickedFile bannerFile;
  final _picker = ImagePickerPlugin();

  @override
  Widget build(BuildContext context) {
    return Container(child: ListView(shrinkWrap: true,children: [
      SizedBox(height: 20,),
      Text("Home Slide", style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 24),),
      SizedBox(height: 20,),
      StreamBuilder<QuerySnapshot>(
        stream: dataProvider.banners(''),
        builder: (context, snapshot) {
          if(snapshot.hasData){
            return AspectRatio(aspectRatio: 1/0.15,
              child: ListView.builder(shrinkWrap: true,itemCount: snapshot.data.documents.length+1,
                scrollDirection: Axis.horizontal,
                itemBuilder: (BuildContext context, int index) {
                  return snapshot.data.documents.length>index?Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: BannerView(image: snapshot.data.documents[index]['image'],
                      onClick: () async {
                      await dataProvider.bannerDelete(snapshot.data.documents[index].documentID);
                      },
                    ),
                  ):Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(height: MediaQuery.of(context).size.width*0.2,
                      width: MediaQuery.of(context).size.width*0.2,
                      color: Colors.white,
                      child: DottedBorder(
                        color: Colors.black,
                        strokeWidth: 1,
                        child: Center(
                          child: IconButton(icon: Icon(Icons.add), onPressed: (){
                            _startFilePicker('slide');
                          }),
                        ),
                      ),
                    ),
                  );
                },),
            );
          }
         else{
           return Container(height: MediaQuery.of(context).size.width*2,
             width: MediaQuery.of(context).size.width*2,
             color: Colors.white,
             child: DottedBorder(
               color: Colors.black,
               strokeWidth: 1,
               child: Center(
                 child: IconButton(icon: Icon(Icons.add), onPressed: (){
                   _startFilePicker('slide');
                 }),
               ),
             ),
           );
          }
        }
      ),

    ],),);
  }

  _startFilePicker(String screen) async {
    final im=await _picker.pickImage(source: ImageSource.gallery,imageQuality: 70);
    setState(() {
      bannerFile=im;
    });
    if(bannerFile!=null){
      _upload(screen);
    }
  }

  Future _upload(String screen)async{
    final filePath = 'banners/${DateTime.now()}.png';
    showDialog(context: context,builder: (context) {
      return Center(
          child: CircularProgressIndicator(backgroundColor: Colors.amber,)
      );
    }, barrierDismissible: false);
    String banner;
    await bannerFile.readAsBytes().then((value)async{
      final ref = fb.storage().refFromURL("gs://deliverycartoon.appspot.com").child("$filePath");
      await ref.put(value).future;
      banner = (await ref.getDownloadURL()).toString();
      CollectionReference reference=Firestore.instance.collection('Banners');
      reference.document().setData({
        'screen':screen,
        'image':banner,
      },merge: true).then((value) {
        setState(() {
          bannerFile=null;
        });
        Navigator.pop(context);
      }).catchError((onError){
        Navigator.pop(context);
        print(onError.toString());
      });
    });
  }

}
