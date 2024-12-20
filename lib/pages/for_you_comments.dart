import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:shadow_space/helper/firestore.dart';
import 'package:shadow_space/helper/foryou_Service.dart';
import 'package:timeago/timeago.dart' as timeago;

class ForYouComments extends StatefulWidget {
  const ForYouComments({super.key});

  @override
  State<ForYouComments> createState() => _ForYouCommentsState();
}

class _ForYouCommentsState extends State<ForYouComments> {
  final FirestoreCommentForYou firestoreCommentForYou =
      FirestoreCommentForYou();
  var _commentController = TextEditingController();
  late Stream<QuerySnapshot> commentStream;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    commentStream = firestoreCommentForYou.getForyouCommentStream();
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.black,
      appBar: AppBar(
        toolbarHeight: screenHeight * 0.1,
        title: Text('Comments'),
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
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  spacing: screenWidth * 0.02,
                  children: [
                    Image.asset(
                      'lib/assets/ui_icon/account.png',
                      width: screenWidth * 0.08,
                      height: screenHeight * 0.08,
                    ),
                    Text(
                      'Anonymous',
                      style: TextStyle(
                          color: Colors.white, fontFamily: 'j-medium'),
                    ),
                  ],
                ),
                Text(
                  ForyouService.selectedForyouTopic!.forYouTime,
                  style: TextStyle(
                    color: Colors.white,
                    fontFamily: 'j-reg',
                  ),
                ),
              ],
            ),
            Text(
              ForyouService.selectedForyouTopic!.forYouTitle,
              style: TextStyle(
                color: Colors.white,
                fontFamily: 'j-medium',
                fontSize: 20,
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              ForyouService.selectedForyouTopic!.forYouDescription,
              style: TextStyle(
                color: Colors.white,
                fontFamily: 'j-reg',
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Divider(
              color: Colors.white,
            ),
            TextField(
              controller: _commentController,
              decoration: InputDecoration(
                labelText: 'Add Comment',
                labelStyle: TextStyle(
                  color: Colors.white,
                  fontFamily: 'j-reg',
                ),
                floatingLabelBehavior: FloatingLabelBehavior.never,
                suffixIcon: IconButton(
                  onPressed: () {
                    if (_commentController.text.trim().isEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                            'Failed to post: No text found!',
                          ),
                        ),
                      );
                      _commentController.clear();
                    } else {
                      firestoreCommentForYou.addForyouComment(
                          _commentController.text,
                          ForyouService.selectedForyouTopic!.forYouTitle);
                      _commentController.clear();
                    }
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
            SizedBox(
              height: 20,
            ),
            StreamBuilder<QuerySnapshot>(
              stream: commentStream,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return CircularProgressIndicator(color: Colors.white);
                } else if (snapshot.hasData) {
                  List commentList = snapshot.data!.docs;
                  return Text(
                    '${commentList.length} Comments',
                    style: TextStyle(
                      color: Colors.white,
                      fontFamily: 'j-medium',
                    ),
                  );
                } else {
                  return Text(
                    'No comments yet',
                    style: TextStyle(color: Colors.white),
                  );
                }
              },
            ),
            SizedBox(height: 20),
            StreamBuilder<QuerySnapshot>(
              stream: commentStream,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(
                    child: CircularProgressIndicator(
                      color: Colors.white,
                    ),
                  );
                } else if (snapshot.data!.docs.isEmpty) {
                  return Center(
                    child: Column(
                      children: [
                        Image.asset(
                          'lib/assets/ui_icon/no-comment.png',
                          width: screenWidth * 0.1,
                          height: screenHeight * 0.1,
                        ),
                        Text(
                          'no comments yet',
                          style: TextStyle(
                            color: Colors.white,
                            fontFamily: 'j-medium',
                            fontSize: 15,
                          ),
                        ),
                      ],
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
                        Timestamp timestamp = data['timestamp'];
                        DateTime dateTime = timestamp.toDate();
                        String timeAgo = timeago.format(dateTime);

                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                                            fontFamily: 'j-reg',
                                            color: Colors.white,
                                          ),
                                        ),
                                        Text(
                                          commentText,
                                          style: TextStyle(
                                            fontFamily: 'j-reg',
                                            color: Colors.white,
                                          ),
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                                Text(
                                  timeAgo,
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontFamily: 'j-reg',
                                  ),
                                )
                              ],
                            )
                          ],
                        );
                      },
                    ),
                  );
                } else {
                  return Text(
                    'an error has occured',
                    style: TextStyle(color: Colors.white),
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
