import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
class crudMethods{
  bool isLoggedIn(){
    if(FirebaseAuth.instance.currentUser !=null){
      return true;
    }
    else{
      return false;
    }
  }
  Future<void> addData(postData) async{
    if(isLoggedIn()){
      /* FirebaseFirestore.instance.collection('testcrud').add(carData).catchError((e){
        print(e);
      });*/
      FirebaseFirestore.instance.runTransaction((Transaction crudTransaction) async{
        CollectionReference reference=await FirebaseFirestore.instance.collection('postData');
        reference.add(postData);
      });
    }
    else{
      print('You need to be logged in first');
    }
  }
  getData() async{
    return await FirebaseFirestore.instance.collection('postData').snapshots();
  }
}
