import 'package:chatapp/widgets/chat/message_bubble.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Messages extends StatelessWidget {
  const Messages({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final user = FirebaseAuth.instance.currentUser;
    return StreamBuilder(
      stream: FirebaseFirestore.instance
          .collection('chat')
          .orderBy('createdAt', descending: true,)
          .snapshots(),
      builder: (ctx, AsyncSnapshot<QuerySnapshot> chatSnapshot)  {
        if (chatSnapshot.connectionState == ConnectionState.waiting){
          return Center(
            child: CircularProgressIndicator(),
          );
        }
        final chatdoc = chatSnapshot.data!.docs;
        //print('doc:$chatdoc');
        return ListView.builder(
          reverse: true,
          itemCount: chatdoc.length,
          itemBuilder: (ctx, index) => MessageBubble(
            chatdoc[index]['text'],
            chatdoc[index]['username'],
            // chatdoc[index]['userImage'],
            chatdoc[index]['userId'] == user?.uid,
            key: ValueKey(chatdoc[index].id),
          ),
        );
      },
    );
  }
}
