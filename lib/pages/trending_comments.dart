import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:shadow_space/helper/firestore.dart';
import 'package:shadow_space/helper/topic_service.dart';

class TrendingCommentsPage extends StatefulWidget {
  const TrendingCommentsPage({super.key});

  @override
  State<TrendingCommentsPage> createState() => _TrendingCommentsPageState();
}

class _TrendingCommentsPageState extends State<TrendingCommentsPage> {
  final FirestoreThread firestoreThread = FirestoreThread();
  var _threadController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        toolbarHeight: screenHeight * 0.1,
        title: Text(
          'Comments',
          style: TextStyle(
            fontFamily: 'j-reg',
          ),
        ),
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(screenHeight * 0.001),
          child: Container(
            color: Colors.white,
            height: screenHeight * 0.001,
          ),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              TopicService.selectedTopic!.title,
              style: TextStyle(
                color: Colors.white,
                fontFamily: 'j-bold',
                fontSize: 30,
              ),
            ),
            TextField(
              controller: _threadController,
              decoration: InputDecoration(
                labelText: 'Add Comment',
                labelStyle: TextStyle(
                  color: Colors.white,
                ),
                floatingLabelBehavior: FloatingLabelBehavior.never,
                suffixIcon: IconButton(
                  onPressed: () {
                    firestoreThread.addThread(_threadController.text,
                        TopicService.selectedTopic!.title);
                    _threadController.clear();
                  },
                  icon: Icon(Icons.send_rounded),
                ),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.white),
                ),
              ),
              cursorColor: Colors.white,
              style: TextStyle(color: Colors.white),
            ),
            StreamBuilder<QuerySnapshot>(
              stream: firestoreThread.getThreadStream(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(
                    child: CircularProgressIndicator(
                      color: Colors.white,
                    ),
                  );
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
                        // String userText = data['username'];

                        //display as list tile
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  spacing: screenWidth * 0.02,
                                  children: [
                                    Image.asset(
                                      'lib/assets/ui_icon/account.png',
                                      width: screenWidth * 0.08,
                                      height: screenHeight * 0.08,
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'Anonymous',
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontFamily: 'j-medium',
                                            fontSize: 15,
                                          ),
                                        ),
                                        Text(
                                          commentText,
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontFamily: 'j-reg',
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ],
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
                  return Text('no threads yet');
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
