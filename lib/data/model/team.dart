class team {
  int? team_id;
  String? name;
  String? short_code;
  String? logo;

  team(this.team_id, this.name, this.short_code, this.logo);

  factory team.geter(Map<String, dynamic> jsonobject) {
    return team(
      jsonobject['team_id'],
      jsonobject['name'],
      jsonobject['short_code'],
      jsonobject['logo'],
    );
  }
}
