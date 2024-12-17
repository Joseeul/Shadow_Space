import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shadow_space/helper/topic_service.dart';

class FirestoreService {
  //get collections
  final CollectionReference threads =
      FirebaseFirestore.instance.collection(TopicService.selectedTopic!.title);

  //create
  Future<void> addThread(
      String thread, String customId) async {
    // Menambahkan thread ke koleksi 'threads' dengan ID kustom dan data
    DocumentReference threadRef = FirebaseFirestore.instance
        .collection('threads')
        .doc(customId); // Memberikan ID kustom pada dokumen

    // Menambahkan koleksi baru (misalnya 'reactions') setelah dokumen dibuat
    await threadRef.collection('comments').add({
      'username': 'Anonymous',
      'content': thread,
      'timestamp': Timestamp.now()
    });
  }


  //read
  Stream<QuerySnapshot> getThreadStream() {
    final threadStream = FirebaseFirestore.instance
        .collection('threads')
        .doc(TopicService.selectedTopic!.title)
        .collection('comments')
        .orderBy('timestamp', descending: true)
        .snapshots(); // Menggunakan snapshots untuk mendapatkan stream data secara real-time

    return threadStream;
  }
}
