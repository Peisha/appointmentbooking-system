import 'package:chatapp/cells/category_cell.dart';
import 'package:chatapp/components/CategoryCard.dart';
import 'package:chatapp/screens/AddCategory.dart';
import 'package:flutter/material.dart';
import 'package:chatapp/resources/storage_methods.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AllCategory extends StatefulWidget {
  static const String id = 'allcategory';
  const AllCategory({Key? key});

  @override
  State<AllCategory> createState() => _AllCategoryState();
}

class _AllCategoryState extends State<AllCategory> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage("assets/images/bg.png"), fit: BoxFit.cover)),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(title: Text('All Category'), actions: <Widget>[
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              // Perform action
              Navigator.pushNamed(context, AddCategory.id);
            },
          ),
        ]),
        body: SafeArea(
          child: StreamBuilder(
            stream:
                FirebaseFirestore.instance.collection('category').snapshots(),
            builder: (context,
                AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
              return GridView.builder(
                itemCount: snapshot.data!.docs.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3),
                itemBuilder: (ctx, index) => Container(
                  child:
                      CategoryCell(category: snapshot.data!.docs[index].data()),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
