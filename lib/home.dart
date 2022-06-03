import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:score_souccer/data/model/LeagueStandings.dart';
import 'package:score_souccer/data/model/team.dart';
import 'package:score_souccer/screen.dart';

// ignore: must_be_immutable
class Home extends StatefulWidget {
  int country_id;
  int season_id;
  Home({Key? key, this.country_id = 59, this.season_id = 2780})
      : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  void initState() {
    super.initState();
    getdata();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green,
      body: Center(
        child: SpinKitWave(
          color: Colors.white,
          size: 30,
        ),
      ),
    );
  }

  void getdata() async {
    var response = await Dio().get(
        'https://app.sportdataapi.com/api/v1/soccer/teams?apikey=f8794f20-e278-11ec-8dfb-1da5a3df623d&country_id=113');
    List<team> team_inf = response.data['data']
        .map<team>((object) => team.geter(object))
        .toList();
    var respons2 = await Dio().get(
        'https://app.sportdataapi.com/api/v1/soccer/standings?apikey=f8794f20-e278-11ec-8dfb-1da5a3df623d&season_id=2029');
    List<score> legescor = respons2.data['data']['standings']
        .map<score>((objects) => score.geter(objects))
        .toList();
    print('test');
    Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => Screen(
              teams: team_inf,
              scors: legescor,
            )));
  }
}
