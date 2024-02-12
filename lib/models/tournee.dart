class Tournee {
   String? mois;
   int? annee;
   int? realises;
   List<TourneeDate>? dates;

  Tournee({
    required this.mois,
    required this.annee,
    required this.realises,
    required this.dates,
  });

  factory Tournee.fromJson(Map<String, dynamic> json) {
    final mois = json['mois'] as String;
    final annee = json['annee'] as int;
    final realises = json['realises'] as int;
    final List<dynamic> datesJson = json['dates'];
    final dates = datesJson.map((dateJson) => TourneeDate.fromJson(dateJson)).toList();

    return Tournee(
      mois: mois,
      annee: annee,
      realises: realises,
      dates: dates,
    );
  }

  Map<String, dynamic> toJson() {
    final List<Map<String, dynamic>> datesJson = dates!.map((date) => date.toJson()).toList();

    return {
      'mois': mois,
      'annee': annee,
      'realises': realises,
      'dates': datesJson,
    };
  }
}

class TourneeDate {
  int? jour;
  int? realises;

  TourneeDate({
    required this.jour,
    required this.realises,
  });

  factory TourneeDate.fromJson(Map<String, dynamic> json) {
    final jour = json['jour'] as int;
    final realises = json['realises'] as int;

    return TourneeDate(
      jour: jour,
      realises: realises,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'jour': jour,
      'realises': realises,
    };
  }
}