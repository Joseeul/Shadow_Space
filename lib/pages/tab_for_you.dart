import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:shadow_space/helper/firestore.dart';

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
    double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Colors.black,
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.white,
        onPressed: () {
          showModalBottomSheet(
            context: context,
            builder: (BuildContext context) {
              return Container(
                height: screenHeight * 0.4,
                width: double.infinity,
                child: Padding(
                  padding: EdgeInsets.all(20),
                  child: Column(
                    children: [
                      //judul sama icon silang
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Make New Topic'),
                          IconButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            icon: Icon(Icons.close),
                          ),
                        ],
                      ),

                      //topic name
                      TextFormField(
                        controller: _titleController,
                        decoration: InputDecoration(
                          labelText: 'Title',
                          labelStyle: TextStyle(
                            color: Colors.black,
                          ),
                          floatingLabelBehavior: FloatingLabelBehavior.never,
                        ),
                      ),

                      //topic description
                      TextFormField(
                        controller: _descriptionController,
                        decoration: InputDecoration(
                          labelText: 'Description',
                          labelStyle: TextStyle(
                            color: Colors.black,
                          ),
                          floatingLabelBehavior: FloatingLabelBehavior.never,
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
                            child: Text('Post'),
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
                    return Center(child: CircularProgressIndicator());
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

                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                titleText,
                                style: TextStyle(color: Colors.white),
                              ),
                              Text(
                                descriptionText,
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
                }),
          ],
        ),
      ),
    );
  }
}
