import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class WLMapTypeButtonWithMenu extends StatelessWidget {
  const WLMapTypeButtonWithMenu({this.elevation = 1, this.bgColor = Colors.white, required this.onSelected, required this.iconUrl, required this.size, required this.heroTag});

  final String iconUrl;
  final String heroTag;
  final double size;
  final double elevation;
  final Color bgColor;
  final Function(int) onSelected;

  // case "google_map": return "qrc:/images/map/map_type_google.png"
  // case "google_sat": return "qrc:/images/map/map_type_google_sat.png"
  // case "yandex": return "qrc:/images/map/map_type_yandex.png"

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: size,
        child: Padding(
            padding: const EdgeInsets.all(3.0),
            child: FloatingActionButton(
                heroTag: heroTag,
                elevation: elevation,
                backgroundColor: bgColor,
                onPressed: (){},
                child: PopupMenuButton<int>(
                  itemBuilder: (context) => [
                    PopupMenuItem(
                        value: 1,
                        child: ListTile(
                          leading: Image.asset("assets/images/map/map_type_google.png"),
                          title: const Text("Google Карты", style: TextStyle(color: Colors.black, fontWeight: FontWeight.normal)),
                          contentPadding: EdgeInsets.only(right: 0, left: 0),
                          minVerticalPadding: 20,
                        )),
                    PopupMenuItem(
                        value: 2,
                        child: ListTile(
                          leading: Image.asset("assets/images/map/map_type_google_sat.png"),
                          title: const Text("Google Спутник", style: TextStyle(color: Colors.black, fontWeight: FontWeight.normal)),
                          contentPadding: EdgeInsets.only(right: 0, left: 0),
                          minVerticalPadding: 20,
                        )),
                    PopupMenuItem(
                        value: 3,
                        child: ListTile(
                          leading: Image.asset("assets/images/map/map_type_yandex.png"),
                          title: const Text("Yandex Карты", style: TextStyle(color: Colors.black, fontWeight: FontWeight.normal)),
                          contentPadding: EdgeInsets.only(right: 0, left: 0),
                          minVerticalPadding: 20,
                        )),
                  ],
                  icon: SvgPicture.asset(iconUrl, semanticsLabel: 'Map Type BTN'),
                  onSelected: (value) {
                    // debugPrint("WL_MapTypeButtonWithMenu val= ${value}");
                    onSelected(value);
                  },
                ))));
  }
}
