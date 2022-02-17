import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get_it/get_it.dart';

import 'package:latlong2/latlong.dart';
import 'package:true_flutter/main.dart';

import '../../../components/common/map_buttons/wl_map_type_button_with_menu.dart';
import '../../../components/common/map_buttons/wl_text_round_button.dart';
import '../../../domain/entities/friend_profile.dart';
import '../../../utils/common/system_log/flogger.dart';
import '../../authentication/authentication_screen.dart';
import '../../common/friends/controllers/friends_controller.dart';
import '../../common/friends/models/friends_model_state.dart';
import '../../common/user/controllers/user_controller.dart';
import '../../common/user/models/user_model_state.dart';
import '../controllers/map_screen_controller.dart';
import '../models/map_screen_model_state.dart';

class MapScreenView extends ConsumerStatefulWidget {
  const MapScreenView({Key? key}) : super(key: key);

  @override
  ConsumerState<MapScreenView> createState() => MapScreenState();
}

class MapScreenState extends ConsumerState<MapScreenView> {
  static const logTag = 'LocalMapScreenView';
  Flogger get logger => GetIt.instance.get<Flogger>();
  final mapScreenProvider =
      StateNotifierProvider<MapScreenController, MapScreenModelState>(
          (ref) => MapScreenController(ref));

  late MapScreenController controller;

  @override
  initState() {
    super.initState();
    controller = ref.read(mapScreenProvider.notifier);
    controller.syncContacts();
  }

  final double contactBtnListHeight = 55;

  @override
  Widget build(BuildContext context) {
    final friendsMmodelState = ref.watch(friendsProvider);
    final mapScreenModelState = ref.watch(mapScreenProvider);
    final networkRequestState = mapScreenModelState.networkRequestState;
    final userModelState = ref.watch(userProvider);

    return Scaffold(
        appBar: AppBar(
          systemOverlayStyle: const SystemUiOverlayStyle(
            statusBarColor: Color(0xFF02B69D),
            statusBarIconBrightness:
                Brightness.light, // For Android (dark icons)
            statusBarBrightness: Brightness.light, // For iOS (dark icons)
          ),

          title: const Text('MAPS'),
          backgroundColor: Color(0x55ffffff),
          elevation: 0,
          // toolbarOpacity: 0,
          bottomOpacity: 1.0,
        ),
        extendBodyBehindAppBar: true,
        drawer: Drawer(
          child: Column(
            children: <Widget>[
              // SizedBox(
              //   height: 30,
              // ),
              DrawerHeader(
                child: Stack(children: <Widget>[
                  Container(
                      height: 142,
                      width: MediaQuery.of(context).size.width,
                      child: Image.asset("assets/images/drawer_bg.png",
                          fit: BoxFit.fitWidth)),
                  Align(
                      alignment: Alignment.bottomLeft,
                      child: Padding(
                        padding: const EdgeInsets.only(
                            right: 10, left: 1, bottom: 2),
                        child: GestureDetector(
                          onTap: () {},
                          child: Text(
                            'Мой Профиль',
                            style: TextStyle(
                                // fontFamily: 'Avenir',
                                fontSize: 20,
                                fontWeight: FontWeight.normal,
                                color: Color(0xFF02B69D)),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      )),
                ]),
                // decoration: BoxDecoration(
                //   color: Colors.blue,
                // ),
              ),

              ListTile(
                leading: SvgPicture.asset("assets/icons/select_map_type.svg"),
                title: const Text('Пункт 1'),
                minVerticalPadding: 20,
                onTap: () {},
              ),
              ListTile(
                leading: SvgPicture.asset("assets/icons/select_map_type.svg"),
                title: const Text('Пункт 2'),
                minVerticalPadding: 20,
                onTap: () {},
              ),
              Divider(thickness: 1),
              ListTile(
                leading: SvgPicture.asset("assets/icons/select_map_type.svg"),
                title: const Text('Пункт 3'),
                minVerticalPadding: 20,
                onTap: () {},
              ),
              ListTile(
                leading: SvgPicture.asset("assets/icons/select_map_type.svg"),
                title: const Text('Sign In'),
                minVerticalPadding: 20,
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (BuildContext context) =>
                          const AuthenticationScreen()));
                },
              ),
              Divider(thickness: 1),

              Expanded(
                  child: Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  height: 45,
                  width: MediaQuery.of(context).size.width,
                  color: Color(0xFF02B69D),
                  child: const Center(
                    child: Text(
                      'v1.0.1',
                      style: TextStyle(
                        fontFamily: 'Avenir',
                        fontSize: 14,
                        color: Color(0xffffffff),
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ))
            ],
          ),
        ),
        body: Stack(children: <Widget>[
          Container(
              alignment: Alignment.center,
              child: FlutterMap(
                // children: [ElevatedButton(onPressed: () {}, child: Text("xzxz"))],
                options: MapOptions(
                  center: LatLng(userModelState.user?.getLocation?.latitude ?? 51.5, userModelState.user?.getLocation?.longitude ?? -0.09),
                  zoom: 13.0,
                  interactiveFlags:
                      InteractiveFlag.pinchZoom | InteractiveFlag.drag,
                ),
                layers: [
                  // TileLayerOptions(urlTemplate: "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png", subdomains: ['a', 'b', 'c']),
                  TileLayerOptions(
                      urlTemplate:
                          "http://mts{s}.google.com/vt/hl=x-local&lyrs=m,h&x={x}&y={y}&z={z}",
                      subdomains: ['0', '1', '2', '3']),
                  TileLayerOptions(
                      urlTemplate:
                          "http://mts{s}.google.com/vt/hl=x-local&lyrs=s,h&x={x}&y={y}&z={z}",
                      subdomains: ['0', '1', '2', '3']),
                  // TileLayerOptions(urlTemplate: "https://0{s}.core-renderer-tiles.maps.yandex.net/tiles?l=map&x={x}&y={y}&z={z}", subdomains: ['1', '2', '3', '4']),

                  MarkerLayerOptions(
                    markers: [
                      Marker(
                        width: 60.0,
                        height: 60.0,
                        point: LatLng(userModelState.user?.getLocation?.latitude ?? 51.5,
                            userModelState.user?.getLocation?.longitude ?? -0.09),
                        builder: (ctx) => Container(
                          alignment: Alignment.bottomCenter,
                          child: SvgPicture.asset(
                              "assets/icons/marker_green.svg",
                              color: Colors.green,
                              alignment: Alignment.bottomCenter),
                        ),
                      ),
                      for (FriendProfile friend in friendsMmodelState.friends ?? []) ...[
                        Marker(
                          width: 60.0,
                          height: 60.0,
                          point: LatLng(friend.getLocation?.latitude ?? 51.5,
                              friend.getLocation?.longitude ?? -0.09),
                          builder: (ctx) => Container(
                            alignment: Alignment.bottomCenter,
                            child: SvgPicture.asset(
                                "assets/icons/marker_green.svg",
                                color: Colors.green,
                                alignment: Alignment.bottomCenter),
                          ),
                        ),
                      ],
                    ],
                  ),
                ],
              )),
          Align(
              alignment: Alignment.centerRight,
              child: Padding(
                padding: const EdgeInsets.only(right: 8, bottom: 200),
                child: WLMapTypeButtonWithMenu(
                    heroTag: "mapType",
                    iconUrl: "assets/icons/select_map_type.svg",
                    size: 50,
                    onSelected: (int value) {
                      debugPrint("MapScreen val= ${value}");
                    }),
              )),
          Align(
              alignment: Alignment.centerRight,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: FloatingActionButton(
                    heroTag: "sos",
                    elevation: 2,
                    child: const Text('SOS',
                        style: TextStyle(
                          fontSize: 20,
                          color: Color(0xFF02B69D),
                        )),
                    backgroundColor: Colors.white,
                    onPressed: () {}),
              )),
          Align(
              alignment: Alignment.bottomLeft,
              child: Padding(
                padding: const EdgeInsets.only(left: 5, right: 5, bottom: 30),
                child: SizedBox(
                    height: contactBtnListHeight,
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      children: <Widget>[
                        WLTextRoundButton(
                            text: "A1",
                            size: contactBtnListHeight,
                            bgColor: Colors.blue,
                            textColor: Colors.white,
                            onPressed: () {}),
                        WLTextRoundButton(
                            text: "B1",
                            size: contactBtnListHeight,
                            bgColor: Colors.red,
                            textColor: Colors.white,
                            onPressed: () {}),
                        WLTextRoundButton(
                            text: "C1",
                            size: contactBtnListHeight,
                            bgColor: Colors.brown,
                            textColor: Colors.white,
                            onPressed: () {}),
                        WLTextRoundButton(
                            text: "D1",
                            size: contactBtnListHeight,
                            bgColor: Colors.green,
                            textColor: Colors.white,
                            onPressed: () {}),
                        WLTextRoundButton(
                            text: "E1",
                            size: contactBtnListHeight,
                            bgColor: Colors.cyan,
                            textColor: Colors.white,
                            onPressed: () {}),
                        WLTextRoundButton(
                            text: "A2",
                            size: contactBtnListHeight,
                            bgColor: Colors.blue,
                            textColor: Colors.white,
                            onPressed: () {}),
                        WLTextRoundButton(
                            text: "B2",
                            size: contactBtnListHeight,
                            bgColor: Colors.red,
                            textColor: Colors.white,
                            onPressed: () {}),
                        WLTextRoundButton(
                            text: "C2",
                            size: contactBtnListHeight,
                            bgColor: Colors.brown,
                            textColor: Colors.white,
                            onPressed: () {}),
                        WLTextRoundButton(
                            text: "D2",
                            size: contactBtnListHeight,
                            bgColor: Colors.green,
                            textColor: Colors.white,
                            onPressed: () {}),
                        WLTextRoundButton(
                            text: "E2",
                            size: contactBtnListHeight,
                            bgColor: Colors.cyan,
                            textColor: Colors.white,
                            onPressed: () {})
                      ],
                    )),
              ))
        ]));
  }
}
