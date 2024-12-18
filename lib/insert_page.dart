import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:shadow_space/helper/firestore.dart';
import 'package:shadow_space/helper/topic_service.dart';

class InsertPage extends StatefulWidget {
  const InsertPage({super.key});

  @override
  State<InsertPage> createState() => _InsertPageState();
}

class _InsertPageState extends State<InsertPage> {
  final FirestoreThread firestoreThread = FirestoreThread();
  var _threadController = TextEditingController();

  void createThread() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        content: TextField(
          controller: _threadController,
        ),
        actions: [
          ElevatedButton(
            onPressed: () {
              firestoreThread.addThread(
                  _threadController.text, TopicService.selectedTopic!.title);
              _threadController.clear();
              Navigator.pop(context);
            },
            child: Text('Post'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(TopicService.selectedTopic!.title),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: createThread,
        child: const Icon(Icons.add),
      ),
      body: Container(
        child: Column(
          children: [
            StreamBuilder<QuerySnapshot>(
              stream: firestoreThread.getThreadStream(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                } else if (snapshot.hasData) {
                  List threadList = snapshot.data!.docs;
                  //display as list
                  return Expanded(
                    child: ListView.builder(
                      itemCount: threadList.length,
                      itemBuilder: (context, index) {
                        //get each individual docs
                        DocumentSnapshot document = threadList[index];

                        //get thread from each docs
                        Map<String, dynamic> data =
                            document.data() as Map<String, dynamic>;

                        String threadText = data['content'];
                        String threadUser = data['username'];

                        //display as list tile
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(threadUser),
                            Text(threadText),
                            SizedBox(
                              height: 5,
                            ),
                          ],
                        );
                      },
                    ),
                  );
                } else {
                  return Text('no thread');
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
