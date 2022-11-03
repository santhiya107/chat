import 'package:chatapp/widgets/chat/new_message.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:chatapp/widgets/chat/messages.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Flutter chat'),
        actions: [
          DropdownButton(icon:const Icon(
            Icons.more_vert,
            color:Colors.white,
          ),

            onChanged:(itemIdentifier){
            if(itemIdentifier == 'logout'){
              FirebaseAuth.instance.signOut();
            }
            },
            items: [DropdownMenuItem(value: 'logout',
              child: Container(child: Row(children: [
              Icon(Icons.exit_to_app,
              color: Colors.black,),

              SizedBox(width: 8.0,),
              Text('Logout')

            ],
            ),
            ),
            ),
            ],)
        ],
      ),

      body: Container(
        child: Column(children: [
          Expanded(child:Messages(),
          ),
          NewMessage(),
        ],
      ),
      ),


    );
    }
}








