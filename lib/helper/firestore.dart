import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shadow_space/helper/foryou_Service.dart';
import 'package:shadow_space/helper/topic_service.dart';

class FirestoreThread {
  final CollectionReference threads =
      FirebaseFirestore.instance.collection(TopicService.selectedTopic!.title);

  Future<void> addThread(String thread, String title) async {
    DocumentReference threadRef = FirebaseFirestore.instance
        .collection('threads')
        .doc(title); // Memberikan ID kustom pada dokumen

    await threadRef.collection('comments').add({
      'username': 'Anonymous',
      'content': thread,
      'timestamp': Timestamp.now()
    });
  }

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

class FirestoreUser {
  final CollectionReference users =
      FirebaseFirestore.instance.collection('users');

  Future<void> addUsers(String username, String email) async {
    users.add({'username': username, 'email': email});
  }
}

class FirestoreAddForYouTopic {
  final CollectionReference forYou =
      FirebaseFirestore.instance.collection('foryou');

  Future<void> newTopics(String topicTitle, String topicDescription) async {
    DocumentReference foryouRef =
        FirebaseFirestore.instance.collection('foryou').doc(topicTitle);

    await foryouRef.set({
      'title': topicTitle,
      'description': topicDescription,
      'timestamp': Timestamp.now()
    });
  }

  Stream<QuerySnapshot> getTitleStream() {
    final titleStream =
        FirebaseFirestore.instance.collection('foryou').snapshots();

    return titleStream;
  }
}

class FirestoreCommentForYou {
  final CollectionReference foryouComment = FirebaseFirestore.instance
      .collection(ForyouService.selectedForyouTopic!.forYouTitle);

  Future<void> addForyouComment(String comment, String title) async {
    DocumentReference threadRef = FirebaseFirestore.instance
        .collection('foryou')
        .doc(title); // Memberikan ID kustom pada dokumen

    await threadRef.collection('comments').add({
      'content': comment,
      'timestamp': Timestamp.now(),
    });
  }

  Stream<QuerySnapshot> getForyouCommentStream() {
    final commentStream = FirebaseFirestore.instance
        .collection('foryou')
        .doc(ForyouService.selectedForyouTopic!.forYouTitle)
        .collection('comments')
        .orderBy('timestamp', descending: true)
        .snapshots(); // Menggunakan snapshots untuk mendapatkan stream data secara real-time

    return commentStream;
  }
}
