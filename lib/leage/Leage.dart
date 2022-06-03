import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:score_souccer/home.dart';
import 'package:dio/dio.dart';
import '../data/model/LeagueStandings.dart';
import '../data/model/team.dart';

// ignore: must_be_immutable
class Scoreborde extends StatefulWidget {
  ThemeData? a;
  List<team>? teams;
  List<score>? scors;
  int? country;
  int? seson;
  Scoreborde(
      {Key? key, this.scors, this.teams, this.country, this.seson, this.a})
      : super(key: key);

  @override
  State<Scoreborde> createState() => _ScorebordeState();
}

class _ScorebordeState extends State<Scoreborde> {
  bool isvis = false;
  List<team>? getteams;
  List<score>? getscors;
  @override
  void initState() {
    super.initState();
    getscors = widget.scors!;
    getteams = widget.teams!;
    setState(() {
      isvis = true;
    });
    refresh();
  }

  Widget build(BuildContext context) {
    return MaterialApp(
      theme: widget.a,
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: [
              Visibility(
                visible: isvis,
                child: Center(
                  child: SizedBox(
                    height: 600,
                    child: SpinKitRing(
                      color: Colors.green,
                      size: 50,
                    ),
                  ),
                ),
              ),
              if (!isvis)
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: SingleChildScrollView(
                    child: DataTable(
                      columnSpacing: 27,
                      columns: [
                        DataColumn(
                          label: Text(''),
                        ),
                        DataColumn(
                          label: Text(''),
                        ),
                        DataColumn(
                          label: Text(''),
                        ),
                        DataColumn(
                          label: Text('game'),
                        ),
                        DataColumn(
                          label: Text('win'),
                        ),
                        DataColumn(
                          label: Text('draw'),
                        ),
                        DataColumn(
                          label: Text('lost'),
                        ),
                        // DataColumn(
                        //   label: Text('point'),
                        // ),
                      ],
                      rows: [
                        ...List.generate(
                          getscors!.length,
                          (index) => DataRow(
                            cells: [
                              DataCell(
                                  Text(getscors![index].position.toString())),
                              DataCell(
                                Center(
                                  child: Image.network(
                                    getteams![
                                            findteam(getscors![index].team_id!)]
                                        .logo!,
                                    height: 25,
                                    alignment: Alignment.center,
                                  ),
                                ),
                              ),
                              DataCell(
                                Center(
                                  child: Text(getteams![
                                          findteam(getscors![index].team_id!)]
                                      .short_code!),
                                ),
                              ),
                              DataCell(Center(
                                  child:
                                      Text(getscors![index].game.toString()))),
                              DataCell(Center(
                                  child:
                                      Text(getscors![index].won.toString()))),
                              DataCell(Center(
                                  child:
                                      Text(getscors![index].draw.toString()))),
                              DataCell(Center(
                                  child:
                                      Text(getscors![index].lost.toString()))),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }

  int findteam(int teamid) {
    int count = 0;
    int end = 0;
    while (getteams!.length > count) {
      if (getteams![count].team_id == teamid) {
        end = count;
      }
      count++;
    }
    return end;
  }

  Future<List<team>> _refresh_team() async {
    var response = await Dio().get(
        'https://app.sportdataapi.com/api/v1/soccer/teams?apikey=f8794f20-e278-11ec-8dfb-1da5a3df623d&country_id=${widget.country.toString()}');
    List<team> team_inf = response.data['data']
        .map<team>((object) => team.geter(object))
        .toList();
    return team_inf;
  }

  Future<List<score>> _refresh_legescor() async {
    var respons2 = await Dio().get(
        'https://app.sportdataapi.com/api/v1/soccer/standings?apikey=f8794f20-e278-11ec-8dfb-1da5a3df623d&season_id=${widget.seson.toString()}');
    List<score> legescor = respons2.data['data']['standings']
        .map<score>((objects) => score.geter(objects))
        .toList();
    return legescor;
  }

  void refresh() async {
    List<team> teamIn = await _refresh_team();
    List<score> scoree = await _refresh_legescor();
    setState(() {
      getscors = scoree;
      getteams = teamIn;
      isvis = false;
    });
  }
}
// ${widget.seson.toString()}