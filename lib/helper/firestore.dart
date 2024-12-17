import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreService{
  //get collections
  final CollectionReference threads = FirebaseFirestore.instance.collection('thread');

  //create
  Future<void> addThread(String thread){
    return threads.add({
      'username': 'Anonymous',
      'content': thread,
      'timestamp': Timestamp.now()
    });
  }
  

  //read
  Stream<QuerySnapshot> getThreadStream(){
    final threadStream = threads.orderBy('timestamp', descending: true).snapshots();

    return threadStream;
  }

}