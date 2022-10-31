import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(stream: FirebaseFirestore.instance.collection('chats/2kfpAtSgc0QeNEJraXez/messages')
          .snapshots() ,builder:(ctx,streamSnapshot) {
        final documents=streamSnapshot.data?.docs;
        return ListView.builder(
          itemCount: documents?.length,
          itemBuilder: (ctx, index) =>
              Container(
                padding: const EdgeInsets.all(8.0),
                child: Text(documents![index]['text']),
              ),
        );
      },
      ),

      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: (){
          FirebaseFirestore.instance
              .collection('chats/2kfpAtSgc0QeNEJraXez/messages')
              .add({"text":'this was added by clicking the button'});
    },
    ),
    );
    }
}








