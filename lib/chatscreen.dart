// import 'package:chat_messenger_app/services/chat_service.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';

// class Chatscreen extends StatefulWidget {
//   final String receiverUserEmail;
//   final String receiverUserID;
//   const Chatscreen({
//     super.key,
//     required this.receiverUserEmail,
//     required this.receiverUserID,
//   });

//   @override
//   State<Chatscreen> createState() => _Chatscreen();
// }

// class _Chatscreen extends State<Chatscreen> {
//   final TextEditingController _messageController = TextEditingController();
//   final ChatService _chatService = ChatService();
//   final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

//   void sendMessage() async {
//     if (_messageController.text.isNotEmpty) {
//       await _chatService.sendMessage(
//         widget.receiverUserID,
//         _messageController.text,
//       );
//       _messageController.clear();
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: const Color(0xFF075E54),
//         elevation: 2,
//         title: Row(
//           children: [
//             const CircleAvatar(
//               backgroundColor: Color(0xFF25D366),
//               child: Icon(Icons.person, color: Colors.white),
//             ),
//             const SizedBox(width: 12),
//             Expanded(
//               child: Text(
//                 widget.receiverUserEmail,
//                 style: const TextStyle(
//                   fontWeight: FontWeight.bold,
//                   color: Colors.white,
//                   fontSize: 18,
//                 ),
//                 overflow: TextOverflow.ellipsis,
//               ),
//             ),
//           ],
//         ),
//         actions: [
//           IconButton(
//             icon: const Icon(Icons.call, color: Colors.white),
//             onPressed: () {},
//           ),
//           IconButton(
//             icon: const Icon(Icons.videocam, color: Colors.white),
//             onPressed: () {},
//           ),
//           IconButton(
//             icon: const Icon(Icons.more_vert, color: Colors.white),
//             onPressed: () {},
//           ),
//         ],
//       ),
//       body: Container(
//         color: const Color(0xFFEFEFEF),
//         child: Column(
//           children: [
//             Expanded(
//               child: StreamBuilder(
//                 stream: _chatService.getMessages(
//                   _firebaseAuth.currentUser!.uid,
//                   widget.receiverUserID,
//                 ),
//                 builder: (context, snapshot) {
//                   if (snapshot.connectionState == ConnectionState.waiting) {
//                     return const Center(child: CircularProgressIndicator());
//                   }
//                   if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
//                     return const Center(child: Text("No messages yet."));
//                   }
//                   final messages = snapshot.data!.docs;
//                   return ListView.builder(
//                     reverse:
//                         false, // Show old messages at the top, new at the bottom
//                     padding: const EdgeInsets.symmetric(
//                       vertical: 16,
//                       horizontal: 8,
//                     ),
//                     itemCount: messages.length,
//                     itemBuilder: (context, index) {
//                       final msg = messages[index];
//                       final isMe =
//                           msg['senderId'] == _firebaseAuth.currentUser?.uid;
//                       return Align(
//                         alignment: isMe
//                             ? Alignment.centerRight
//                             : Alignment.centerLeft,
//                         child: Container(
//                           margin: EdgeInsets.only(
//                             top: 4,
//                             bottom: 4,
//                             left: isMe ? 60 : 8,
//                             right: isMe ? 8 : 60,
//                           ),
//                           padding: const EdgeInsets.symmetric(
//                             horizontal: 16,
//                             vertical: 10,
//                           ),
//                           decoration: BoxDecoration(
//                             color: isMe
//                                 ? const Color(0xFFDCF8C6)
//                                 : Colors.white,
//                             borderRadius: BorderRadius.only(
//                               topLeft: const Radius.circular(16),
//                               topRight: const Radius.circular(16),
//                               bottomLeft: Radius.circular(isMe ? 16 : 0),
//                               bottomRight: Radius.circular(isMe ? 0 : 16),
//                             ),
//                             boxShadow: [
//                               BoxShadow(
//                                 color: Colors.black12,
//                                 blurRadius: 2,
//                                 offset: const Offset(0, 1),
//                               ),
//                             ],
//                           ),
//                           child: Text(
//                             msg['message'],
//                             style: TextStyle(
//                               color: Colors.black87,
//                               fontSize: 16,
//                             ),
//                           ),
//                         ),
//                       );
//                     },
//                   );
//                 },
//               ),
//             ),
//             Container(
//               padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
//               color: Colors.white,
//               child: Row(
//                 children: [
//                   IconButton(
//                     icon: const Icon(
//                       Icons.emoji_emotions_outlined,
//                       color: Colors.grey,
//                     ),
//                     onPressed: () {},
//                   ),
//                   Expanded(
//                     child: TextField(
//                       controller: _messageController,
//                       decoration: InputDecoration(
//                         hintText: "Type a message",
//                         filled: true,
//                         fillColor: Colors.grey[200],
//                         contentPadding: const EdgeInsets.symmetric(
//                           horizontal: 16,
//                           vertical: 10,
//                         ),
//                         border: OutlineInputBorder(
//                           borderRadius: BorderRadius.circular(24),
//                           borderSide: BorderSide.none,
//                         ),
//                       ),
//                     ),
//                   ),
//                   IconButton(
//                     icon: const Icon(Icons.attach_file, color: Colors.grey),
//                     onPressed: () {},
//                   ),
//                   const SizedBox(width: 4),
//                   CircleAvatar(
//                     backgroundColor: const Color(0xFF25D366),
//                     child: IconButton(
//                       icon: const Icon(Icons.send, color: Colors.white),
//                       onPressed: sendMessage,
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

import 'package:chat_messenger_app/services/chat_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

class Chatscreen extends StatefulWidget {
  final String receiverUserEmail;
  final String receiverUserID;
  const Chatscreen({
    super.key,
    required this.receiverUserEmail,
    required this.receiverUserID,
  });

  @override
  State<Chatscreen> createState() => _Chatscreen();
}

class _Chatscreen extends State<Chatscreen> with SingleTickerProviderStateMixin {
  final TextEditingController _messageController = TextEditingController();
  final ChatService _chatService = ChatService();
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final ScrollController _scrollController = ScrollController();
  
  late AnimationController _animationController;
  late Animation<double> _appBarAnimation;
  late Animation<double> _inputAnimation;

  void sendMessage() async {
    if (_messageController.text.isNotEmpty) {
      await _chatService.sendMessage(
        widget.receiverUserID,
        _messageController.text,
      );
      _messageController.clear();
      
      // Scroll to bottom after sending message
      _scrollToBottom();
    }
  }

  void _scrollToBottom() {
    if (_scrollController.hasClients) {
      _scrollController.animateTo(
        _scrollController.position.maxScrollExtent,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOut,
      );
    }
  }

  @override
  void initState() {
    super.initState();
    
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );

    _appBarAnimation = CurvedAnimation(
      parent: _animationController,
      curve: const Interval(0.0, 0.5, curve: Curves.easeOut),
    );

    _inputAnimation = CurvedAnimation(
      parent: _animationController,
      curve: const Interval(0.3, 1.0, curve: Curves.easeOut),
    );

    _animationController.forward();

    // Scroll to bottom after initial build
    SchedulerBinding.instance.addPostFrameCallback((_) {
      _scrollToBottom();
    });
  }

  @override
  void dispose() {
    _animationController.dispose();
    _messageController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF0F0F0),
      body: Column(
        children: [
          // Animated App Bar
          ScaleTransition(
            scale: _appBarAnimation,
            child: FadeTransition(
              opacity: _appBarAnimation,
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      Colors.blueAccent,
                      Colors.purpleAccent.shade400,
                    ],
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 8,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: AppBar(
                  backgroundColor: Colors.transparent,
                  elevation: 0,
                  leading: IconButton(
                    icon: const Icon(Icons.arrow_back, color: Colors.white),
                    onPressed: () => Navigator.pop(context),
                  ),
                  title: Row(
                    children: [
                      Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.1),
                              blurRadius: 6,
                              offset: const Offset(0, 2),
                            ),
                          ],
                        ),
                        child: Icon(
                          Icons.person,
                          color: Colors.blueAccent,
                          size: 24,
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Text(
                          widget.receiverUserEmail,
                          style: const TextStyle(
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                            fontSize: 18,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                  actions: [
                    IconButton(
                      icon: const Icon(Icons.call, color: Colors.white, size: 22),
                      onPressed: () {},
                    ),
                    IconButton(
                      icon: const Icon(Icons.videocam, color: Colors.white, size: 24),
                      onPressed: () {},
                    ),
                    IconButton(
                      icon: const Icon(Icons.more_vert, color: Colors.white),
                      onPressed: () {},
                    ),
                  ],
                ),
              ),
            ),
          ),

          // Messages List
          Expanded(
            child: StreamBuilder(
              stream: _chatService.getMessages(
                _firebaseAuth.currentUser!.uid,
                widget.receiverUserID,
              ),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          width: 28,
                          height: 28,
                          child: CircularProgressIndicator(
                            strokeWidth: 2.5,
                            valueColor: AlwaysStoppedAnimation<Color>(Colors.blueAccent),
                          ),
                        ),
                        const SizedBox(height: 12),
                        Text(
                          "Loading messages...",
                          style: TextStyle(
                            color: Colors.grey.shade600,
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                  );
                }
                
                if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.chat_bubble_outline,
                          size: 64,
                          color: Colors.grey.shade400,
                        ),
                        const SizedBox(height: 16),
                        Text(
                          "No messages yet",
                          style: TextStyle(
                            color: Colors.grey.shade600,
                            fontSize: 16,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          "Send a message to start the conversation",
                          style: TextStyle(
                            color: Colors.grey.shade500,
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                  );
                }
                
                final messages = snapshot.data!.docs;
                
                return ListView.builder(
                  controller: _scrollController,
                  reverse: false,
                  padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 12),
                  itemCount: messages.length,
                  itemBuilder: (context, index) {
                    final msg = messages[index];
                    final isMe = msg['senderId'] == _firebaseAuth.currentUser?.uid;
                    
                    // Animation for message appearance
                    final messageAnimation = CurvedAnimation(
                      parent: _animationController,
                      curve: Interval(
                        0.5 + (0.5 * index / messages.length.clamp(1, 10)), 
                        1.0,
                        curve: Curves.easeOut,
                      ),
                    );
                    
                    return FadeTransition(
                      opacity: messageAnimation,
                      child: SlideTransition(
                        position: Tween<Offset>(
                          begin: Offset(isMe ? 0.5 : -0.5, 0),
                          end: Offset.zero,
                        ).animate(messageAnimation),
                        child: Container(
                          margin: EdgeInsets.only(
                            top: 4,
                            bottom: 4,
                            left: isMe ? 60 : 8,
                            right: isMe ? 8 : 60,
                          ),
                          child: Material(
                            borderRadius: BorderRadius.only(
                              topLeft: const Radius.circular(20),
                              topRight: const Radius.circular(20),
                              bottomLeft: Radius.circular(isMe ? 20 : 4),
                              bottomRight: Radius.circular(isMe ? 4 : 20),
                            ),
                            elevation: 1,
                            shadowColor: Colors.black.withOpacity(0.1),
                            color: isMe
                                ? Colors.blueAccent
                                : Colors.white,
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 16,
                                vertical: 12,
                              ),
                              child: Text(
                                msg['message'],
                                style: TextStyle(
                                  color: isMe ? Colors.white : Colors.black87,
                                  fontSize: 16,
                                  height: 1.4,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ),

          // Message Input
          ScaleTransition(
            scale: _inputAnimation,
            child: FadeTransition(
              opacity: _inputAnimation,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 8,
                      offset: const Offset(0, -2),
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    // Emoji button
                    Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.grey.shade100,
                      ),
                      child: Icon(
                        Icons.emoji_emotions_outlined,
                        color: Colors.grey.shade600,
                        size: 22,
                      ),
                    ),
                    const SizedBox(width: 8),
                    
                    // Message input field
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.grey.shade100,
                          borderRadius: BorderRadius.circular(24),
                        ),
                        child: TextField(
                          controller: _messageController,
                          decoration: InputDecoration(
                            hintText: "Type a message...",
                            border: InputBorder.none,
                            contentPadding: const EdgeInsets.symmetric(
                              horizontal: 20,
                              vertical: 14,
                            ),
                            hintStyle: TextStyle(
                              color: Colors.grey.shade500,
                            ),
                          ),
                          style: const TextStyle(fontSize: 16),
                          maxLines: null,
                          textInputAction: TextInputAction.send,
                          onSubmitted: (value) => sendMessage(),
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    
                    // Attachment button
                    Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.grey.shade100,
                      ),
                      child: Icon(
                        Icons.attach_file,
                        color: Colors.grey.shade600,
                        size: 22,
                      ),
                    ),
                    const SizedBox(width: 8),
                    
                    // Send button
                    Container(
                      width: 48,
                      height: 48,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        gradient: LinearGradient(
                          colors: [
                            Colors.blueAccent,
                            Colors.purpleAccent.shade400,
                          ],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.blueAccent.withOpacity(0.3),
                            blurRadius: 6,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      child: IconButton(
                        icon: const Icon(Icons.send, color: Colors.white, size: 22),
                        onPressed: sendMessage,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}