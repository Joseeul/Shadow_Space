import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:shadow_space/helper/firestore.dart';
import 'package:shadow_space/helper/foryou_Service.dart';
import 'package:shadow_space/models/foryou_topic.dart';

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

  @override
  Widget build(BuildContext context) {
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
                              firestoreAddForYouTopic.newTopics(
                                  _titleController.text,
                                  _descriptionController.text);
                              _titleController.clear();
                              _descriptionController.clear();
                              Navigator.pop(context);
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
        child: Column(
          children: [
            StreamBuilder(
                stream: firestoreAddForYouTopic.getTitleStream(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(
                        child: CircularProgressIndicator(
                      color: Colors.white,
                    ));
                  } else if (snapshot.hasData) {
                    List titleList = snapshot.data!.docs;
                    return Expanded(
                      child: ListView.builder(
                        itemCount: titleList.length,
                        itemBuilder: (context, index) {
                          DocumentSnapshot document = titleList[index];
                          Map<String, dynamic> data =
                              document.data() as Map<String, dynamic>;

                          String titleText = data['title'];
                          String descriptionText = data['description'];

                          return GestureDetector(
                            onTap: () {
                              ForyouService.selectedForyouTopic = ForyouTopic(
                                  forYouTitle: data['title'],
                                  forYouDescription: data['description']);
                              Navigator.pushNamed(
                                  context, '/for_you_comments_page');
                            },
                            child: Card(
                              margin: EdgeInsets.symmetric(vertical: 3.5),
                              shape: RoundedRectangleBorder(
                                side: BorderSide(
                                  strokeAlign: BorderSide.strokeAlignOutside,
                                  color: Color(0xFF353535),
                                ),
                              ),
                              color: Colors.transparent,
                              child: ListTile(
                                title: Text(
                                  titleText,
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontFamily: 'j-medium',
                                  ),
                                ),
                                subtitle: Text(
                                  descriptionText,
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontFamily: 'j-reg',
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    );
                  } else {
                    return Text('no thread');
                  }
                }),
          ],
        ),
      ),
    );
  }
}
