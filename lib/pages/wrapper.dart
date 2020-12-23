import 'package:covidensa/models/user.dart';
import 'package:flutter/material.dart';
import 'package:covidensa/pages/local_page.dart';
import 'package:covidensa/pages/home_page.dart';

import 'package:provider/provider.dart';

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    final user = Provider.of<User>(context);
    if (user == null)
      return HomePage();
    else 
      return LocalPage();
  }
}