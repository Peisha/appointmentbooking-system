import 'package:chatapp/models/category.dart';
import 'package:chatapp/screens/AddDoctor.dart';
import 'package:chatapp/screens/AddScedule.dart';
import 'package:chatapp/utils/he_color.dart';
import 'package:flutter/material.dart';

class CategoryCells extends StatelessWidget {
  final category;

  const CategoryCells({Key? key, required this.category}) : super(key: key);

  /// **********************************************
  /// LIFE CYCLE METHODS
  /// **********************************************

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100,
      height: 100,
      clipBehavior: Clip.hardEdge,
      padding: EdgeInsets.only(top: 14),
      decoration: BoxDecoration(
        color: HexColor('#EDFDFA'),
        borderRadius: BorderRadius.circular(16),
      ),
      child: GestureDetector(
        onTap: () {
          Navigator.pushNamed(context, AddScedule.id, arguments: category);
        },
        child: Card(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    child: Image.network(
                      category['pic'],
                      width: 50,
                      height: 50,
                      fit: BoxFit.cover,
                    ),
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  Center(
                    child: Text(
                      category['title'],
                      style: TextStyle(
                        color: HexColor('#010101'),
                        fontWeight: FontWeight.w700,
                        fontSize: 14,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
