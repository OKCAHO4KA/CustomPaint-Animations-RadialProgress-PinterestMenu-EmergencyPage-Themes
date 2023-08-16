import 'package:custom_painters/routes/routes.dart';
import 'package:custom_painters/src/models/layout_model.dart';
import 'package:custom_painters/theme/theme_changer.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

class LauncherTabletPage extends StatelessWidget {
  const LauncherTabletPage({super.key});

  @override
  Widget build(BuildContext context) {
    final appTheme = Provider.of<ThemeChanger>(context).currentTheme;
    final themeChanger = Provider.of<ThemeChanger>(context);
    final layoutModel = Provider.of<LayoutModel>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Diseños en Flutter-Tablet'),
        backgroundColor: appTheme.indicatorColor,
      ),
      body: Row(
        children: [
          const SizedBox(
            width: 300,
            height: double.infinity,
            child: _ListaOpciones(),
          ),
          Container(
              width: 1,
              height: double.infinity,
              color: themeChanger.darkTheme
                  ? Colors.grey
                  : appTheme.indicatorColor),
          Expanded(child: layoutModel.currentPage)
        ],
      ),
      //  const _ListaOpciones(),
      drawer: const _MenuPrincipal(),
    );
  }
}

class _ListaOpciones extends StatelessWidget {
  const _ListaOpciones();

  @override
  Widget build(BuildContext context) {
    final appTheme = Provider.of<ThemeChanger>(context).currentTheme;
    return ListView.separated(
      physics: const BouncingScrollPhysics(),
      separatorBuilder: (context, i) =>
          Divider(color: appTheme.primaryColorLight),
      itemCount: pageRoute.length,
      itemBuilder: (context, i) => ListTile(
        leading: FaIcon(pageRoute[i].icon, color: appTheme.indicatorColor),
        title: Text(pageRoute[i].titulo),
        trailing:
            Icon(Icons.chevron_right_sharp, color: appTheme.indicatorColor),
        onTap: () {
          // Navigator.push(context,
          //     MaterialPageRoute(builder: (context) => pageRoute[i].page));
          Provider.of<LayoutModel>(context, listen: false).currentPage =
              pageRoute[i].page;
        },
      ),
    );
  }
}

class _MenuPrincipal extends StatelessWidget {
  const _MenuPrincipal();

  @override
  Widget build(BuildContext context) {
    final themeChanger = Provider.of<ThemeChanger>(context);
    return Drawer(
      child: Container(
        child: Column(
          children: [
            SafeArea(
              child: SizedBox(
                height: 200,
                width: double.infinity,
                child: CircleAvatar(
                  backgroundColor: themeChanger.currentTheme.indicatorColor,
                  child: const Text('OL',
                      style: TextStyle(
                          fontSize: 70,
                          color: Colors.white,
                          fontWeight: FontWeight.bold)),
                ),
              ),
            ),
            const Expanded(child: _ListaOpciones()),
            ListTile(
              leading: Icon(Icons.lightbulb_outline,
                  color: themeChanger.currentTheme.indicatorColor),
              title: const Text('Dark Mode'),
              trailing: Switch.adaptive(
                  activeColor: themeChanger.currentTheme.indicatorColor,
                  value: themeChanger.darkTheme,
                  onChanged: (value) {
                    themeChanger.darkTheme = value;
                  }),
            ),
            SafeArea(
              bottom: true,
              left: false,
              right: false,
              top: false,
              child: ListTile(
                leading: Icon(Icons.add_to_home_screen,
                    color: themeChanger.currentTheme.indicatorColor),
                title: const Text('Custom Theme'),
                trailing: Switch.adaptive(
                    activeColor: themeChanger.currentTheme.indicatorColor,
                    value: themeChanger.customTheme,
                    onChanged: (value) {
                      themeChanger.customTheme = value;
                    }),
              ),
            ),
          ],
        ),
      ),
    );
  }
}