import 'package:flutter/material.dart';
import 'package:frontend/core/models/categories.dart';
import 'package:frontend/core/models/category.dart';

class FilterView extends StatefulWidget {
  @override
  _FilterViewState createState() => _FilterViewState();
}

class _FilterViewState extends State<FilterView> {
  List<Category> categories = defaultCategories.values.toList();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: const Text('Filter Categories'),
      ),
      body: GridView.builder(
          itemCount: categories.length,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 1.75,
          ),
          itemBuilder: (BuildContext context, int index) {
            return Container(
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.black12,
                  width: 0.5,
                ),
                color: Colors.white,
                boxShadow: categories[index].isSelected
                    ? const <BoxShadow>[
                        BoxShadow(
                          color: Colors.black12,
                          blurRadius: 15.0,
                          spreadRadius: 0.5,
                          offset: Offset(
                            2.0,
                            5.0,
                          ),
                        ),
                      ]
                    : <BoxShadow>[],
              ),
              child: Center(
                child: SizedBox.expand(
                  child: FlatButton(
                    onPressed: () {
                      setState(() {
                        categories[index].isSelected =
                            !categories[index].isSelected;
                      });
                    },
                    child: Stack(
                      children: <Widget>[
                        Container(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Container(
                                    child: Icon(
                                      categories[index].icon,
                                      size: 48,
                                      color: categories[index].color,
                                    ),
                                    padding: const EdgeInsets.symmetric(
                                      vertical: 7,
                                    ),
                                  ),
                                  Text(categories[index].name),
                                ],
                              ),
                            ],
                          ),
                        ),
                        Align(
                          alignment: Alignment.topRight,
                          child: categories[index].isSelected
                              ? InkWell(
                                  child: Container(
                                    margin: const EdgeInsets.symmetric(
                                      vertical: 20,
                                      horizontal: 10,
                                    ),
                                    height: 20,
                                    width: 20,
                                    decoration: const BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: Colors.blueAccent,
                                    ),
                                    child: const Icon(
                                      Icons.check,
                                      size: 15.0,
                                      color: Colors.white,
                                    ),
                                  ),
                                )
                              : Container(),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          }),
    );
  }
}
