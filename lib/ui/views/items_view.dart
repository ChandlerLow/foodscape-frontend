import 'package:flutter/material.dart';
import 'package:frontend/core/models/categories.dart';
import 'package:frontend/core/models/item.dart';
import 'package:frontend/core/view_models/items_model.dart';
import 'package:frontend/core/view_models/view_state.dart';
import 'package:frontend/ui/shared/app_colors.dart';
import 'package:frontend/ui/shared/app_colors.dart' as app_colors;
import 'package:frontend/ui/widgets/items_list_item.dart';
import 'package:frontend/ui/widgets/recipe_carousel.dart';

import 'base_view.dart';

class ItemsView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BaseView<ItemsModel>(
      onModelReady: (ItemsModel model) {
        model.getBroadcast();
        model.getItems();
      },
      builder: (BuildContext context, ItemsModel model, Widget child) {
        return Scaffold(
          appBar: AppBar(
            iconTheme: const IconThemeData(
              color: Colors.white,
            ),
            automaticallyImplyLeading: false,
            backgroundColor: app_colors.backgroundColorPink,
            title: const Text('Ramsay Hall',
                style: TextStyle(color: Colors.white)),
            actions: <Widget>[
              IconButton(
                icon: const Icon(
                  Icons.filter_list,
                  color: Colors.white,
                ),
                onPressed: () async {
                  await Navigator.of(context).pushNamed('/items/filter');
                  model.getItems();
                },
              )
            ],
          ),
          backgroundColor: backgroundColor,
          body: Container(
            child: RefreshIndicator(
              child: model.state == ViewState.Idle && model.categories != null
                  ? (model.categories.isEmpty
                      ? const Center(
                          child: Text('No items match your specifications! '
                              'Why not filter fewer items?'),
                        )
                      : getCategoriesUi(model.categories, model))
                  : const Center(child: CircularProgressIndicator()),
              onRefresh: () async {
                model.getItems();
                model.getBroadcast();
              },
            ),
          ),
        );
      },
    );
  }

  Widget getCategoriesUi(Map<int, List<Item>> categories, ItemsModel model) {
    final List<int> categoryKeys = categories.keys.toList();
    final List<List<Item>> categoryValues = categories.values.toList();
    return Container(
      margin: const EdgeInsets.only(bottom: 25),
      child: ListView.builder(
        shrinkWrap: true,
        padding: const EdgeInsets.only(bottom: 50),
        itemCount: categories.length + 2,
        itemBuilder: (BuildContext context, int i) {
          if (i == 0) {
            return model.broadcast != null && model.broadcast.hasBroadcast
                ? Card(
                    margin: const EdgeInsets.only(
                      top: 10,
                      bottom: 10,
                      left: 5,
                      right: 5,
                    ),
                    child: InkWell(
                      onTap: () {
                        return showDialog<void>(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              content: Text(model.broadcast.message),
                              actions: <Widget>[
                                FlatButton(
                                  child: const Text('Close'),
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                ),
                              ],
                            );
                          },
                        );
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16.0, vertical: 10.0),
                        width: double.infinity,
                        child: Text(
                          model.broadcast.summary,
                          style: const TextStyle(fontSize: 16),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ))
                : Container();
          } else if (i == 1) {
            return ConstrainedBox(
              constraints: const BoxConstraints(minWidth: double.infinity),
              child: Container(
                margin: const EdgeInsets.only(bottom: 10.0),
                padding: const EdgeInsets.symmetric(
                  horizontal: 16.0,
                  vertical: 10.0,
                ),
                decoration: const BoxDecoration(
                  color: Colors.white,
                  boxShadow: <BoxShadow>[
                    BoxShadow(
                      color: Colors.black12,
                      blurRadius: 3.0,
                      offset: Offset(0, 2),
                    )
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    const Text(
                      'Discover recipes',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 24,
                      ),
                    ),
                    MultiRecipeCarousel(categoryValues: categoryValues),
                  ],
                ),
              ),
            );
          }

          return ConstrainedBox(
            constraints: const BoxConstraints(minWidth: double.infinity),
            child: Container(
              margin: const EdgeInsets.only(bottom: 10.0),
              padding: const EdgeInsets.symmetric(
                horizontal: 16.0,
                vertical: 10.0,
              ),
              decoration: const BoxDecoration(
                color: Colors.white,
                boxShadow: <BoxShadow>[
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 3.0,
                    offset: Offset(0, 2),
                  )
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Text(
                    defaultCategories[categoryKeys[i - 2]].name,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 24,
                    ),
                  ),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: categories[categoryKeys[i - 2]].map<Widget>(
                        (Item item) {
                          return ItemsListItem(
                            item: item,
                            onTap: () {
                              model.sendItemMetric(item.id);
                              Navigator.pushNamed(
                                context,
                                '/item',
                                arguments: item,
                              );
                            },
                          );
                        },
                      ).toList(),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
