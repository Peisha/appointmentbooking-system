// Scaffold(
//       appBar: AppBar(
//         title: Text('Profile'),
//       ),
//       body: SafeArea(
//         child: Padding(
//           padding: const EdgeInsets.all(8.0),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Center(
//                 child: Stack(
//                   children: [
//                     _image != null
//                         ? CircleAvatar(
//                             radius: 64,
//                             backgroundImage: MemoryImage(_image!),
//                             backgroundColor: Colors.red,
//                           )
//                         : CircleAvatar(
//                             radius: 64,
//                             backgroundImage: NetworkImage(userData['pic']),
//                             backgroundColor: Colors.white,
//                           ),
//                     Positioned(
//                       bottom: -10,
//                       left: 80,
//                       child: IconButton(
//                         onPressed: selectImage,
//                         icon: const Icon(Icons.add_a_photo),
//                       ),
//                     )
//                   ],
//                 ),
//               ),
//               Center(
//                 child: Text(
//                   userData['name'],
//                   textAlign: TextAlign.center,
//                   style: TextStyle(
//                     fontWeight: FontWeight.bold,
//                     fontSize: 25,
//                   ),
//                 ),
//               ),
//               Row(
//                 crossAxisAlignment: CrossAxisAlignment.center,
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   InkWell(
//                     onTap: () {/* Do something */},
//                     child: Container(
//                       padding: EdgeInsets.all(10.0),
//                       child: Row(
//                         children: <Widget>[
//                           Icon(Icons.emoji_people),
//                           Text("22", style: TextStyle(fontSize: 22)),
//                         ],
//                       ),
//                     ),
//                   ),
//                   InkWell(
//                     onTap: () {/* Do something */},
//                     child: Container(
//                       padding: EdgeInsets.all(10.0),
//                       child: Row(
//                         children: <Widget>[
//                           Icon(
//                             Icons.bloodtype,
//                             color: Colors.red,
//                           ),
//                           Text(
//                             "A+",
//                             style: TextStyle(fontSize: 22),
//                           ),
//                         ],
//                       ),
//                     ),
//                   ),
//                   InkWell(
//                     onTap: () {/* Do something */},
//                     child: Container(
//                       padding: EdgeInsets.all(10.0),
//                       child: Row(
//                         children: <Widget>[
//                           Icon(
//                             Icons.type_specimen,
//                             color: Colors.blue,
//                           ),
//                           Text("Male", style: TextStyle(fontSize: 22)),
//                         ],
//                       ),
//                     ),
//                   )
//                 ],
//               ),
//               SizedBox(
//                 height: 20,
//               ),
//               Text(
//                 'About John',
//                 textAlign: TextAlign.start,
//                 style: TextStyle(
//                   fontWeight: FontWeight.bold,
//                   fontSize: 25,
//                 ),
//               ),
//               SizedBox(
//                 height: 20,
//               ),
//               Text(
//                 'In Flutter, you can create a button with text and an icon by using the FlatButton.icon constructor or the RaisedButton.icon constructor. These constructors take in an Icon widget and a String for the button text as arguments. Here is an example of how you can use these constructors to create a button with a text and an icon:',
//                 style: TextStyle(color: Colors.black54),
//               ),
//               Center(
//                   child: Container(
//                 width: 200,
//                 child: ElevatedButton(
//                   onPressed: () {},
//                   child: Text('logout'),
//                 ),
//               ))
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }