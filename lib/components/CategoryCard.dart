import 'package:chatapp/models/category.dart';
import 'package:flutter/material.dart';

class CategoryCard extends StatefulWidget {
  final categories;
  const CategoryCard({Key? key, required this.categories}) : super(key: key);

  @override
  State<CategoryCard> createState() => _CategoryCardState();
}

class _CategoryCardState extends State<CategoryCard> {
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      child: InkWell(
        onTap: () {
          // Navigator.pushNamed(context, AllDoctor.id, arguments: 'doctor');
        },
        child: Container(
          width: 90,
          height: 90,
          padding: EdgeInsets.all(10.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              // Image.network(categories['pic']),
              // Text(
              //   categories['title'],
              //   style: TextStyle(fontSize: 15),
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
