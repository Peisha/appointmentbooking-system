import 'package:chatapp/cells/category_cell.dart';
import 'package:chatapp/cells/category_cells.dart';
import 'package:chatapp/components/CategoryCard.dart';
import 'package:chatapp/screens/AddCategory.dart';
import 'package:flutter/material.dart';

import 'package:cloud_firestore/cloud_firestore.dart';

class ListofCat extends StatefulWidget {
  static const String id = 'ListofCat';
  const ListofCat({Key? key});

  @override
  State<ListofCat> createState() => _ListofCatState();
}

class _ListofCatState extends State<ListofCat> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage("assets/images/bg.png"), fit: BoxFit.cover)),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          title: Text('Choose Category'),
        ),
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
                  child: CategoryCells(
                      category: snapshot.data!.docs[index].data()),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
