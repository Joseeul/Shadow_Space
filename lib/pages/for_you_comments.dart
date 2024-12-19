import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:shadow_space/helper/firestore.dart';
import 'package:shadow_space/helper/foryou_Service.dart';

class ForYouComments extends StatefulWidget {
  const ForYouComments({super.key});

  @override
  State<ForYouComments> createState() => _ForYouCommentsState();
}

class _ForYouCommentsState extends State<ForYouComments> {
  final FirestoreCommentForYou firestoreCommentForYou =
      FirestoreCommentForYou();

  var _commentController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text('Comments'),
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          children: [
            Text(
              ForyouService.selectedForyouTopic!.forYouTitle,
              style: TextStyle(color: Colors.white),
            ),
            Text(
              ForyouService.selectedForyouTopic!.forYouDescription,
              style: TextStyle(color: Colors.white),
            ),
            TextField(
              controller: _commentController,
              decoration: InputDecoration(
                labelText: 'Add Comment',
                labelStyle: TextStyle(
                  color: Colors.white,
                ),
                floatingLabelBehavior: FloatingLabelBehavior.never,
                suffixIcon: IconButton(
                  onPressed: () {
                    firestoreCommentForYou.addForyouComment(
                        _commentController.text,
                        ForyouService.selectedForyouTopic!.forYouTitle);
                    _commentController.clear();
                  },
                  icon: Icon(Icons.send_rounded),
                ),
              ),
              style: TextStyle(color: Colors.white),
            ),
            StreamBuilder<QuerySnapshot>(
              stream: firestoreCommentForYou.getForyouCommentStream(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                } else if (snapshot.hasData) {
                  List commentList = snapshot.data!.docs;
                  //display as list
                  return Expanded(
                    child: ListView.builder(
                      itemCount: commentList.length,
                      itemBuilder: (context, index) {
                        //get each individual docs
                        DocumentSnapshot document = commentList[index];

                        //get thread from each docs
                        Map<String, dynamic> data =
                            document.data() as Map<String, dynamic>;

                        String commentText = data['content'];

                        //display as list tile
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              commentText,
                              style: TextStyle(color: Colors.white),
                            ),
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
