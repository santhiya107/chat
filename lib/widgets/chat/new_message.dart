import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class NewMessage extends StatefulWidget {
  const NewMessage({Key? key}) : super(key: key);

  @override
  State<NewMessage> createState() => _NewMessageState();
}

class _NewMessageState extends State<NewMessage> {
  var _enteredMessage = '';
  final _controller =  TextEditingController();

  void _sendMessage() async {
    print('inside sendmessage method');
    FocusScope.of(context).unfocus();
    final user = FirebaseAuth.instance.currentUser;
    final userdata = await FirebaseFirestore.instance
        .collection('users')
        .doc(user?.uid)
        .get();
    FirebaseFirestore.instance.collection('chat').add({
      'text': _enteredMessage,
      'createdAt': Timestamp.now(),
      'userId': user?.uid,
      'username': userdata['username'],
      //'userImage': userdata['image_url']

    });
  //print(user);
    _controller.clear();
  }


  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 8),
      padding: EdgeInsets.all(8),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: _controller,
              decoration: const InputDecoration(labelText: 'Send a message'),
              onChanged: (value) {
                setState(() {
                  _enteredMessage = value;

                });
              },
            ),
          ),
          IconButton(
            onPressed: (){
              FirebaseFirestore.instance.collection('chats/wYwm3VyMZ4RTwXpJibZU/messages/')
                 .snapshots()
              .listen((data){

                print(data.docs[1]['text']);
              });

            //  _sendMessage;
              //print(_sendMessage.toString());

              print('entered msg:$_enteredMessage');
               //_enteredMessage == null ? _sendMessage() :null;
              if (_enteredMessage != null){
                _sendMessage();
              }


            },
            icon: Icon(
              Icons.send,
              color: Colors.blue,
            ),
          )
        ],
      ),
    );
  }
}
