import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:frontend/core/models/user.dart';
import 'package:frontend/ui/shared/app_colors.dart' as app_colors;
import 'package:frontend/ui/shared/ui_helpers.dart';
import 'package:provider/provider.dart';

class ProfileView extends StatelessWidget {
  String _extractInitials(String fullname) {
    List<String> names = fullname.split(' ');
    String initials = '';
    for (String name in names) {
      initials += name[0];
    }
    return initials;
  }

  Widget _buildProfileImage(String name) {
    return Center(
      child: Container(
        width: 130,
        height: 130,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(90.0),
          border: Border.all(
            color: Colors.white,
            width: 3.0,
          ),
        ),
        child: CircleAvatar(
          backgroundColor: Colors.pink,
          child: Text(
            _extractInitials(name),
            style: const TextStyle(fontSize: 60, color: Colors.white),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final User user = Provider.of<User>(context);
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(
          color: Colors.white,
        ),
        backgroundColor: app_colors.backgroundColorPink,
        automaticallyImplyLeading: false,
        title: const Text('Profile', style: TextStyle(color: Colors.white)),
        actions: <Widget>[
          IconButton(
            icon: const Icon(
              Icons.exit_to_app,
              color: Colors.white,
            ),
            onPressed: () async {
              await user.setLoggedOut();
              await Navigator.of(context).pushNamedAndRemoveUntil(
                '/login',
                (_) => false,
              );
            },
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Container(
              color: app_colors.backgroundColorPink,
              child: Column(
                children: <Widget>[
                  UIHelper.verticalSpaceMedium(),
                  _buildProfileImage(user.name),
                  UIHelper.verticalSpaceSmall(),
                  Align(
                    child: Text(
                      user.name,
                      style: const TextStyle(fontSize: 24, color: Colors.white),
                    ),
                    alignment: Alignment.center,
                  ),
                  UIHelper.verticalSpaceSmall(),
                  Row(
                    children: <Widget>[
                      Text(
                        user.location,
                        style:
                            const TextStyle(fontSize: 18, color: Colors.white),
                      ),
                      Text(
                        user.phoneNumber,
                        style:
                            const TextStyle(fontSize: 18, color: Colors.white),
                      ),
                    ],
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  ),
                  UIHelper.verticalSpaceMedium(),
                ],
              ),
            ),
            UIHelper.verticalSpaceSmall(),
            Column(
              children: <Widget>[
                Container(
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    boxShadow: <BoxShadow>[
                      BoxShadow(
                        color: Colors.black12,
                        blurRadius: 3.0,
                        offset: Offset(0, 1),
                      )
                    ],
                  ),
                  child: Material(
                    color: Colors.transparent,
                    child: InkWell(
                      onTap: () {
                        Navigator.pushNamed(context, '/user/items');
                      },
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: ListTile(
                          title: const Text(
                            'My Items',
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                UIHelper.verticalSpaceSmall(),
                Container(
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    boxShadow: <BoxShadow>[
                      BoxShadow(
                        color: Colors.black12,
                        blurRadius: 3.0,
                        offset: Offset(0, 1),
                      )
                    ],
                  ),
                  child: Material(
                    color: Colors.transparent,
                    child: InkWell(
                      onTap: () {
                        showAboutDialog(
                            context: context,
                            applicationName: 'FoodScape',
                            applicationLegalese:
                                'Made as part the requirements for CO271 at '
                                'Imperial College London.');
                      },
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: ListTile(
                          title: const Text(
                            'About this app',
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            UIHelper.verticalSpaceSmall(),
          ],
        ),
      ),
    );
  }
}
