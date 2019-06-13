import 'package:flutter/material.dart';
import 'package:frontend/constants.dart';
import 'package:frontend/core/models/categories.dart';
import 'package:frontend/core/models/item.dart';
import 'package:frontend/ui/shared/ui_helpers.dart';
import 'package:shimmer/shimmer.dart';

class UserListItem extends StatelessWidget {
  const UserListItem({this.item, this.onTap});

  final Item item;
  final Function onTap;

  @override
  Widget build(BuildContext context) {
    return Card(
      semanticContainer: true,
      clipBehavior: Clip.antiAliasWithSaveLayer,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: InkWell(
        onTap: onTap,
        child: Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Hero(
                tag: 'item-photo-${item.id}',
                child: Container(
                  child: item.photo == null || item.photo == ''
                      ? Container(
                          child: Icon(
                            defaultCategories[item.categoryId].icon,
                            size: 50,
                            color: Colors.black,
                          ),
                          alignment: Alignment.center,
                          height: 150,
                          width: MediaQuery.of(context).size.width,
                          decoration: const BoxDecoration(
                            color: Color(0xFFFABBC5),
                          ),
                        )
                      : Container(
                          child: Stack(
                            children: <Widget>[
                              Shimmer.fromColors(
                                baseColor: Colors.grey[300],
                                highlightColor: Colors.grey[100],
                                child: Container(
                                  height: 150,
                                  width: MediaQuery.of(context).size.width,
                                  color: Colors.white,
                                ),
                              ),
                              FadeInImage.assetNetwork(
                                placeholder: 'assets/1x1.png',
                                image: '$SPACES_BASE_URL/${item.photo}',
                                fit: BoxFit.cover,
                                height: 150,
                                width: MediaQuery.of(context).size.width,
                              ),
                            ],
                          ),
                          alignment: Alignment.center,
                        ),
                ),
              ),
              UIHelper.verticalSpaceSmall(),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 15.0),
                width: 275,
                child: Text(
                  item.name,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 26,
                  ),
                ),
              ),
              const Padding(padding: EdgeInsets.only(top: 5.0)),
              item.isCollected
                  ? Container(
                      padding: const EdgeInsets.symmetric(horizontal: 15.0),
                      width: 275,
                      child: Row(
                        children: <Widget>[
                          Container(
                            margin: const EdgeInsets.only(right: 4),
                            child: const Icon(Icons.check, size: 16),
                          ),
                          const Text(
                            'Collected',
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),
                    )
                  : (isExpired(item.expiryDate)
                      ? Container(
                          padding: const EdgeInsets.symmetric(horizontal: 15.0),
                          child: Row(
                            children: <Widget>[
                              Container(
                                margin: const EdgeInsets.only(right: 4),
                                child: const Icon(Icons.timer_off, size: 16),
                              ),
                              const Text(
                                'Expired',
                                style: TextStyle(
                                  fontSize: 16,
                                ),
                              ),
                            ],
                          ),
                        )
                      : isToday(item.expiryDate)
                          ? Container(
                              padding: const EdgeInsets.symmetric(horizontal: 15.0),
                              child: Row(
                                children: <Widget>[
                                  Container(
                                    margin: const EdgeInsets.only(right: 4),
                                    child: const Icon(Icons.alarm, size: 16),
                                  ),
                                  const Text(
                                    'Expires Today',
                                    style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 16,
                                    ),
                                  ),
                                ],
                              ),
                            )
                          : Container(
                          padding: const EdgeInsets.symmetric(horizontal: 15.0),
                          child: Row(
                            children: <Widget>[
                              Container(
                                margin: const EdgeInsets.only(right: 4),
                                child: const Icon(Icons.alarm, size: 16),
                              ),
                              const Text(
                                'Expires in ',
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  fontSize: 16,
                                ),
                              ),
                              Text(
                                '${getDaysLeft(item.expiryDate).toString()}',
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 16,
                                ),
                              ),
                              Text(
                                getDaysLeft(item.expiryDate) <= 1
                                    ? ' day and still listed'
                                    : ' days and still listed',
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(fontSize: 16),
                              ),
                            ],
                          ),
                        )),
              UIHelper.verticalSpaceSmall(),
            ],
          ),
        ),
      ),
      margin: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
    );
  }

  bool isToday(DateTime expiryDate) {
    return expiryDate.difference(DateTime.now()).inDays == 0;
  }

  bool isExpired(DateTime expiryDate) {
    return expiryDate.isBefore(DateTime.now());
  }

  int getDaysLeft(DateTime expiryDate) {
    return expiryDate.difference(DateTime.now()).inDays;
  }
}
