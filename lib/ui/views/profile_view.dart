import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:frontend/core/models/user.dart';
import 'package:frontend/core/view_models/register_model.dart';
import 'package:frontend/core/view_models/view_state.dart';
import 'package:provider/provider.dart';



class ProfileView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final bool showFab = MediaQuery.of(context).viewInsets.bottom == 0.0;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(Provider.of<User>(context).name, style: const TextStyle(fontSize: 24)),
      ),

      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: showFab
          ? FloatingActionButton(
        heroTag: 'main-fab',
        backgroundColor: Colors.grey,
        elevation: 2.0,
        child: const Icon(Icons.edit),
        onPressed: () {
          Navigator.pushNamed(context, '/');
        },
      )
          : null,
      bottomNavigationBar: BottomAppBar(
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            IconButton(icon: Icon(Icons.home), color: Colors.white, iconSize: 40,
              onPressed: () {Navigator.pushNamed(context, '/');},),
            IconButton(icon: Icon(Icons.exit_to_app), color: Colors.white, iconSize: 40, onPressed: () {
            },),
          ],
        ),
        color: Colors.grey,
        shape: CircularNotchedRectangle(),
      ),
    );
  }

}
