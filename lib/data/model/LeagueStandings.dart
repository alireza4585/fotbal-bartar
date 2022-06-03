class score {
  int? team_id;
  int? position;
  int? points;
  int? won;
  int? draw;
  int? lost;
  int? game;

  score(this.team_id, this.position, this.points, this.won, this.draw,
      this.lost, this.game);

  factory score.geter(Map<String, dynamic> jsonobject) {
    return score(
      jsonobject['team_id'],
      jsonobject['position'],
      jsonobject['points'],
      jsonobject['overall']['won'],
      jsonobject['overall']['draw'],
      jsonobject['overall']['lost'],
      jsonobject['overall']['games_played'],
    );
  }
}
