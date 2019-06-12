import 'package:flutter/material.dart';
import 'package:frontend/core/models/categories.dart';
import 'package:frontend/core/models/category.dart';
import 'package:frontend/locator.dart';
import 'package:frontend/ui/shared/app_colors.dart' as app_colors;
import 'package:frontend/ui/views/AnalyticsScreen.dart';

class FilterView extends StatefulWidget {
  @override
  _FilterViewState createState() => _FilterViewState();
}

class _FilterViewState extends State<FilterView> with AnalyticsScreen{
  final UserCategories userCategories = locator<UserCategories>();
  final Map<int, Category> categories =
      locator<UserCategories>().getCategories();

  @override
  get screenName => 'filter_item';

  @override
  Widget build(BuildContext context) {
    logEvent();
    final List<int> categoryIds = categories.keys.toList();

    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(
          color: Colors.white,
        ),
        backgroundColor: app_colors.backgroundColorPink,
        centerTitle: false,
        title: const Text('Filter Categories',
          style: TextStyle(color: Colors.white),),
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
                boxShadow: categories[categoryIds[index]].isSelected
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
                    onPressed: () async {
                      final bool isSelected =
                          !categories[categoryIds[index]].isSelected;
                      setState(() {
                        categories[categoryIds[index]].isSelected = isSelected;
                      });

                      await userCategories.persistCategorySelected(
                          categoryIds[index], isSelected);
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
                                      categories[categoryIds[index]].icon,
                                      size: 48,
                                      color:
                                          categories[categoryIds[index]].color,
                                    ),
                                    padding: const EdgeInsets.symmetric(
                                      vertical: 7,
                                    ),
                                  ),
                                  Text(categories[categoryIds[index]].name),
                                ],
                              ),
                            ],
                          ),
                        ),
                        Align(
                          alignment: Alignment.topRight,
                          child: categories[categoryIds[index]].isSelected
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
