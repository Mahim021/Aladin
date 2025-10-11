import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreService {

  // get collection of orders
  final CollectionReference orders = 
    FirebaseFirestore.instance.collection('orders');

  // save order to db
  Future<void> saveOrderToDatabase(String receipt) async {
    try {
      await orders.add({
        'date': DateTime.now(),
        'order': receipt,
        'status': 'confirmed',
        'orderNumber': DateTime.now().millisecondsSinceEpoch.toString().substring(7),
        // add more fields as necessary
      });
      print('Order saved to Firebase successfully');
    } catch (e) {
      print('Error saving order to Firebase: $e');
    }
  }


}