import 'package:critijoy_note/data/models/review_model.dart';
import 'package:critijoy_note/presentation/widgets/drawer.dart';
import 'package:flutter/material.dart';
import 'package:critijoy_note/presentation/widgets/appbar_menu.dart';
import 'package:critijoy_note/presentation/widgets/listview_content.dart';
import 'package:critijoy_note/presentation/widgets/option_menu.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    final scaffoldKey = GlobalKey<ScaffoldState>();
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBarMenu(
        preferredSize: const Size(395, 60),
        child: Container(),
      ),
      body: Column(
        children: [
          OptionMenu(onOptionSelected: (bool option) {}),
          Expanded(
            child: ListView.builder(
              itemCount: reviews.length,
              itemBuilder: (context, index) {
                return ListViewContent(typeContenido: reviews[index]);
              },
            ),
          ),
        ],
      ),
      drawer: NavigationDrawerList(scaffoldKey: scaffoldKey),
    );
  }
}
