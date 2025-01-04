import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:shadow_space/helper/firestore.dart';
import 'package:shadow_space/helper/foryou_Service.dart';
import 'package:shadow_space/models/foryou_topic.dart';
import 'package:timeago/timeago.dart' as timeago;

class TabForYou extends StatefulWidget {
  const TabForYou({super.key});

  @override
  State<TabForYou> createState() => _TabForYouState();
}

class _TabForYouState extends State<TabForYou> {
  final FirestoreAddForYouTopic firestoreAddForYouTopic =
      FirestoreAddForYouTopic();

  var _titleController = TextEditingController();
  var _descriptionController = TextEditingController();

  Set<String> likedItems = {};

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Colors.black,
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        shape: CircleBorder(),
        onPressed: () {
          showModalBottomSheet(
            useSafeArea: true,
            isScrollControlled: true,
            context: context,
            builder: (BuildContext context) {
              final MediaQueryData mediaQueryData = MediaQuery.of(context);
              return Container(
                padding:
                    EdgeInsets.only(bottom: mediaQueryData.viewInsets.bottom),
                child: Padding(
                  padding: EdgeInsets.all(20),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        width: 50,
                        height: 5,
                        decoration: BoxDecoration(
                          color: Color.fromARGB(
                            255,
                            184,
                            184,
                            184,
                          ),
                          borderRadius: BorderRadius.all(
                            Radius.circular(10),
                          ),
                        ),
                      ),

                      //judul sama icon silang
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Make New Topic',
                            style: TextStyle(
                                fontSize: 20,
                                fontFamily: 'j-medium',
                                color: Colors.black),
                          ),
                          IconButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            icon: Icon(Icons.close),
                          ),
                        ],
                      ),

                      SizedBox(
                        width: double.infinity,
                        child: Divider(
                          color: Colors.black,
                          thickness: 1,
                        ),
                      ),

                      //topic name
                      TextFormField(
                        controller: _titleController,
                        decoration: InputDecoration(
                          labelText: 'Title',
                          labelStyle: TextStyle(
                            color: Colors.black,
                            fontFamily: 'j-reg',
                          ),
                          floatingLabelBehavior: FloatingLabelBehavior.never,
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.black),
                          ),
                        ),
                        cursorColor: Colors.black,
                        style: TextStyle(
                          fontFamily: 'j-reg',
                        ),
                      ),

                      //topic description
                      TextFormField(
                        controller: _descriptionController,
                        decoration: InputDecoration(
                          labelText: 'Description',
                          labelStyle: TextStyle(
                            color: Colors.black,
                            fontFamily: 'j-reg',
                          ),
                          floatingLabelBehavior: FloatingLabelBehavior.never,
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.black),
                          ),
                        ),
                        cursorColor: Colors.black,
                        style: TextStyle(
                          fontFamily: 'j-reg',
                        ),
                      ),

                      SizedBox(
                        height: 10,
                      ),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          ElevatedButton(
                            onPressed: () {
                              if (_titleController.text.trim().isEmpty &&
                                  _descriptionController.text.trim().isEmpty) {
                                Navigator.pop(context);
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text(
                                      'Failed to post: No text found!',
                                    ),
                                  ),
                                );
                                _titleController.clear();
                                _descriptionController.clear();
                              } else {
                                firestoreAddForYouTopic.newTopics(
                                    _titleController.text,
                                    _descriptionController.text);
                                _titleController.clear();
                                _descriptionController.clear();
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text(
                                      'Topic has been posted',
                                    ),
                                  ),
                                );
                                Navigator.pop(context);
                              }
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.black,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            child: Text(
                              'Post',
                              style: TextStyle(
                                  fontFamily: 'j-medium', color: Colors.white),
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                ),
              );
            },
          );
        },
        child: const Icon(Icons.add),
      ),
      body: Container(
        padding: EdgeInsets.only(left: 20, right: 20),
        child: Column(
          children: [
            StreamBuilder(
              stream: firestoreAddForYouTopic.getTitleStream(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(
                    child: CircularProgressIndicator(
                      color: Colors.white,
                    ),
                  );
                } else if (snapshot.hasData) {
                  List titleList = snapshot.data!.docs;
                  return Expanded(
                    child: ListView.builder(
                      itemCount: titleList.length,
                      itemBuilder: (context, index) {
                        DocumentSnapshot document = titleList[index];
                        Map<String, dynamic> data =
                            document.data() as Map<String, dynamic>;

                        String id = document.id;
                        String titleText = data['title'];
                        String descriptionText = data['description'];
                        Timestamp timestamp = data['timestamp'];
                        DateTime dateTime = timestamp.toDate();
                        String timeAgo = timeago.format(dateTime);

                        bool isLiked = likedItems.contains(id);

                        return GestureDetector(
                          onTap: () {
                            ForyouService.selectedForyouTopic = ForyouTopic(
                                forYouTitle: data['title'],
                                forYouDescription: data['description'],
                                forYouTime: timeAgo);
                            Navigator.pushNamed(
                                context, '/for_you_comments_page');
                          },
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                spacing: screenWidth * 0.02,
                                children: [
                                  Image.asset(
                                    'lib/assets/ui_icon/account.png',
                                    width: screenWidth * 0.085,
                                    height: screenHeight * 0.085,
                                  ),
                                  Text(
                                    'Anonymous',
                                    style: TextStyle(
                                      fontFamily: 'j-medium',
                                      color: Colors.white,
                                    ),
                                  ),
                                  Icon(
                                    Icons.circle,
                                    color: Colors.white,
                                    size: 5,
                                  ),
                                  Text(
                                    timeAgo,
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontFamily: 'j-reg',
                                    ),
                                  ),
                                ],
                              ),
                              Container(
                                width: double.infinity,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      titleText,
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontFamily: 'j-medium',
                                        fontSize: 20,
                                      ),
                                    ),
                                    Text(
                                      descriptionText,
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontFamily: 'j-reg',
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                decoration: BoxDecoration(
                                  border: Border(
                                    bottom: BorderSide(
                                      color: Color(0xFF353535),
                                    ),
                                  ),
                                ),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    IconButton(
                                      onPressed: () {
                                        setState(() {
                                          if (isLiked) {
                                            likedItems.remove(id);
                                          } else {
                                            likedItems.add(id);
                                          }
                                        });
                                      },
                                      icon: Image.asset(
                                        isLiked
                                            ? 'lib/assets/ui_icon/heart.png'
                                            : 'lib/assets/ui_icon/like.png',
                                        width: screenWidth * 0.06,
                                        height: screenHeight * 0.06,
                                      ),
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Image.asset(
                                      'lib/assets/ui_icon/chat.png',
                                      width: screenWidth * 0.05,
                                      height: screenHeight * 0.05,
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Image.asset(
                                      'lib/assets/ui_icon/refresh.png',
                                      width: screenWidth * 0.055,
                                      height: screenHeight * 0.055,
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
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
