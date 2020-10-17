import 'package:avatar_glow/avatar_glow.dart';
import 'package:fluttervpnui/screens/server_list_page.dart';
import 'package:flutter/material.dart';
import 'dart:async';

import 'package:flutter_openvpn/flutter_openvpn.dart';
import 'shared_widgets/server_list_widget.dart';

Future<String> vpnData;

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  @override
  void initState() {
    FlutterOpenvpn.init();
    Future<String> loadAsset(BuildContext context) async {
      print(await DefaultAssetBundle.of(context).loadString('assets/test.txt'));
      return await DefaultAssetBundle.of(context).loadString('assets/test.txt');
    }
    vpnData = loadAsset(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            'AvaxVPN',
            style: Theme.of(context)
                .textTheme
                .headline6
                .copyWith(fontWeight: FontWeight.w600),
          ),
//          leading: Image.asset( //TODO: HERE WE HAVE TO IMPLEMENT OUR LOGO
//            'assets/logo.png',
//            width: 35,
//            height: 35,
//          ),
        ),
        body: Stack(
          children: [
            Positioned(
                top: 50,
                child: Opacity(
                    opacity: 0.15, //TODO: BACKGROUNF ASSET LOL!
                    child: Image.asset(
                      'assets/background.png',
                      fit: BoxFit.fill,
                      height: MediaQuery.of(context).size.height / 1.5,
                      color: Colors.deepPurple,
                    ))),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: Column(
                children: [
                  SizedBox(height: 25),
                  Center(
                      child: Text(
                        'You are connected',
                        style: Theme.of(context).textTheme.bodyText1,
                      )),
                  SizedBox(height: 8),
                  Center(
                      child: Text(
                        '192.168.1.20',
                        style: Theme.of(context).textTheme.bodyText1.copyWith(
                            color: Colors.white,
                            fontWeight: FontWeight.w900),
                      )),
                  SizedBox(
                    height: 15,
                  ),
                  Center(
                    child: GestureDetector(
                      onTap: () async {
                        await FlutterOpenvpn.lunchVpn(
                          await vpnData,
                              (isProfileLoaded) => print('isProfileLoaded : $isProfileLoaded'),
                              (newVpnStatus) => print('vpnActivated : $newVpnStatus'),
                        );
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Color(0xFF2D265F),
                        ),
                        child: AvatarGlow(
                          glowColor: Color.fromRGBO(37, 112, 252, 1),
                          endRadius: 100.0,
                          duration: Duration(milliseconds: 2000),
                          repeat: true,
                          showTwoGlows: false,
                          repeatPauseDuration: Duration(milliseconds: 100),
                          shape: BoxShape.circle,
                          child: Material(
                            elevation: 2,
                            shape: CircleBorder(),
                            color: Color(0xFF272052),
                            child: SizedBox(
                              height: 180,
                              width: 180,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.power_settings_new,
                                    color: Color(0xFF80B9F8),
                                    size: 50,
                                  ),
                                  SizedBox(height: 10),
                                  Text(
                                    'Connect',
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyText2
                                        .copyWith(
                                        color: Color(0xFF80B9F8),
                                      fontWeight: FontWeight.w900
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Center(
                      child: Text(
                        '00.00.01',
                        style: Theme.of(context).textTheme.bodyText2.copyWith(
                            fontWeight: FontWeight.w700,
                            color: Color(0xFF7EC1E4)),
                      )),
                  SizedBox(
                    height: 25,
                  ),
                  ServerItemWidget( //TODO: COUNTRIES PAGE
                    flagAsset: 'assets/england.png',
                    label: 'England',
                    icon: Icons.arrow_forward_ios,
                    onTap: () {
                      Navigator.of(context)
                          .push(MaterialPageRoute(builder: (context) {
                        return ServerListPage();
                      }));
                    },
                  ),
                  Spacer(),
                  RaisedButton.icon(
                    elevation: 0,
                    padding: EdgeInsets.symmetric(
                        vertical: 15,
                        horizontal: MediaQuery.of(context).size.width / 4.5),
                    color: Color(0xFF7ab1ec),
                    onPressed: () async{
                      await FlutterOpenvpn.stopVPN();
                    },
                    icon: Icon(
                      Icons.star,
                      color: Colors.white,
                    ),
                    label: Text(
                      'Get Premium',
                      style: Theme.of(context)
                          .textTheme
                          .button
                          .copyWith(color: Colors.white),
                    ),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                  ),
                  SizedBox(height: 35),
                ],
              ),
            ),
          ],
        ));
  }
}