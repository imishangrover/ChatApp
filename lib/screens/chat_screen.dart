//import 'package:firebase_core/firebase_core.dart';
import 'package:chat/constants.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

final _firestore = FirebaseFirestore.instance;
User? loggedInUser;

class chatScreen extends StatefulWidget {
  static String id = 'chat_screen';
  const chatScreen({super.key});

  @override
  State<chatScreen> createState() => _chatScreenState();
}

class _chatScreenState extends State<chatScreen> {
  final messageTextController = TextEditingController();
  final _auth = FirebaseAuth.instance;
  late String messageText;

  @override
  void initState() {
    super.initState();
    getCurrentUser();
  }

  getCurrentUser() async {
    try {
      final user = await _auth.currentUser;
      if (user != null) {
        loggedInUser = user;
        //print(loggedInUser.email);
      }
    } catch (e) {
      //print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.blue,
          leading: null,
          title: const Center(
              child: Text(
            'Chat',
            style: TextStyle(color: Colors.white),
          )),
          actions: <Widget>[
            IconButton(
                onPressed: () {
                  _auth.signOut();
                  Navigator.pop(context);
                },
                icon: const Icon(
                  Icons.logout,
                  color: Colors.white,
                ))
          ],
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            messageStream(),
            Row(children: <Widget>[
              Expanded(
                child: TextFormField(
                  controller: messageTextController,
                  onChanged: (value) {
                    messageText = value;
                  },
                  decoration: kTextFildDecoration('Enter message here...'),
                ),
              ),
              TextButton(
                  onPressed: () {
                    messageTextController.clear();
                    _firestore.collection('messages').add({
                      'text': messageText,
                      'sender': loggedInUser?.email,
                    });
                  },
                  child: const Text(
                    'Send',
                    style: TextStyle(color: Colors.blue),
                  ))
            ]),
          ],
        ));
  }
}

class messageBubble extends StatelessWidget {
  final String? sender;
  final String? text;
  final bool? isMe;

  const messageBubble({this.sender, this.text, this.isMe});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        crossAxisAlignment:
            isMe! ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            sender!,
            style: const TextStyle(color: Colors.grey, fontSize: 11),
          ),
          Material(
            elevation: 5,
            borderRadius: isMe!
                ? const BorderRadius.only(
                    topLeft: Radius.circular(30),
                    bottomLeft: Radius.circular(30),
                    bottomRight: Radius.circular(30))
                : const BorderRadius.only(
                    topRight: Radius.circular(30),
                    bottomLeft: Radius.circular(30),
                    bottomRight: Radius.circular(30)),
            color: isMe! ? Colors.lightBlueAccent : Colors.white,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Text(
                text!,
                style: TextStyle(
                    color: isMe! ? Colors.white : Colors.black, fontSize: 20),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class messageStream extends StatelessWidget {
  const messageStream({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: _firestore.collection('messages').snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return const Center(
            child: CircularProgressIndicator(
              backgroundColor: Colors.lightBlueAccent,
            ),
          );
        }
        final messages = snapshot.data!.docs.reversed;
        List<messageBubble> messageBubbles = [];
        for (var message in messages) {
          final Map<String, dynamic> messageData =
              message.data() as Map<String, dynamic>;
          final messageText = messageData['text'];
          final messageSender = messageData['sender'];
          final currentUser = loggedInUser?.email;

          final messageBubbleInestence = messageBubble(
            sender: messageSender,
            text: messageText,
            isMe: currentUser == messageSender,
          );
          messageBubbles.add(messageBubbleInestence);
        }
        return Expanded(
          child: ListView(
              reverse: true,
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
              children: messageBubbles
              ),
        );
      },
    );
  }
}
