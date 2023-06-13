import 'package:cloud_firestore/cloud_firestore.dart';

Future<void> uploadingData(String _discription, String _heading, String _image,
    String _url, _isFav) async {
  await FirebaseFirestore.instance.collection("newsdetails").add({
    'discription': _discription,
    'heading': _heading,
    '_image': _image,
    'isFav': _isFav,
    'url': _url,
  });
}

Future<void> editProduct(bool _isFav, String id) async {
  await FirebaseFirestore.instance
      .collection("newsdetails")
      .doc(id)
      .update({"isFav": !_isFav});
}

Future<void> deleteProduct(DocumentSnapshot doc) async {
  await FirebaseFirestore.instance
      .collection("newsdetails")
      .doc(doc.id)
      .delete();
}
