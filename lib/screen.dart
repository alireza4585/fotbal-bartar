import 'package:flutter/material.dart';
import 'package:score_souccer/data/model/LeagueStandings.dart';
import 'package:score_souccer/data/model/team.dart';
import 'package:score_souccer/leage/Leage.dart';

// ignore: must_be_immutable
class Screen extends StatefulWidget {
  List<team>? teams;
  List<score>? scors;
  Screen({Key? key, this.scors, this.teams}) : super(key: key);

  @override
  State<Screen> createState() => _ScreenState();
}

class _ScreenState extends State<Screen> {
  ThemeData a = ThemeData.dark();
  List<team>? getteams;
  List<score>? getscors;
  @override
  void initState() {
    super.initState();
    getscors = widget.scors!;
    getteams = widget.teams!;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: a,
      debugShowCheckedModeBanner: false,
      home: DefaultTabController(
        initialIndex: 0,
        length: 4,
        child: Scaffold(
          appBar: AppBar(
            backgroundColor:
                a == ThemeData.light() ? Colors.green : Colors.grey[800],
            actions: [
              if (a == ThemeData.light())
                IconButton(
                    onPressed: () {
                      setState(() {
                        a = ThemeData.dark();
                      });
                    },
                    icon: Icon(Icons.mode_night_outlined)),
              if (a == ThemeData.dark())
                IconButton(
                    onPressed: () {
                      setState(() {
                        a = ThemeData.light();
                      });
                    },
                    icon: Icon(Icons.sunny)),
            ],
            title: Text('fotball bartar'),
            bottom: TabBar(
              isScrollable: true,
              indicatorColor: Colors.white,
              tabs: [
                Tab(
                  text: 'Persian Gulf',
                ),
                Tab(
                  text: 'Laliga',
                ),
                Tab(
                  text: 'Premier League',
                ),
                Tab(
                  text: 'Premier League',
                ),
              ],
            ),
          ),
          body: TabBarView(
            children: [
              Scoreborde(
                scors: getscors,
                teams: getteams,
                country: 59,
                seson: 2780,
                a: a,
              ),
              Scoreborde(
                scors: getscors,
                teams: getteams,
                country: 113, //113
                seson: 2029,
                a: a,
              ),
              Scoreborde(
                scors: getscors,
                teams: getteams,
                country: 42, //42
                seson: 1980,
                a: a,
              ),
              Scoreborde(
                scors: getscors,
                teams: getteams,
                country: 48, //42
                seson: 2020,
                a: a,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
