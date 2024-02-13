class Tournee {
  int annee;
  int realises;
  List<MonthData> months;

  Tournee({
    required this.annee,
    required this.realises,
    required this.months,
  });

  factory Tournee.fromJson(Map<String, dynamic> json) {
    return Tournee(
      annee: json['annee'],
      realises: json['realises'],
      months: List<MonthData>.from(
        json['months'].map((month) => MonthData.fromJson(month)),
      ),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'annee': annee,
      'realises': realises,
      'months': months.map((month) => month.toJson()).toList(),
    };
  }
}

class MonthData {
  String mois;
  int realises;
  List<TourneeDate> dates;

  MonthData({
    required this.mois,
    required this.realises,
    required this.dates,
  });

  factory MonthData.fromJson(Map<String, dynamic> json) {
    return MonthData(
      mois: json['mois'],
      realises: json['realises'],
      dates: List<TourneeDate>.from(
        json['dates'].map((date) => TourneeDate.fromJson(date)),
      ),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'mois': mois,
      'realises': realises,
      'dates': dates.map((date) => date.toJson()).toList(),
    };
  }
}

class TourneeDate {
  int jour;
  int realises;

  TourneeDate({
    required this.jour,
    required this.realises,
  });

  factory TourneeDate.fromJson(Map<String, dynamic> json) {
    return TourneeDate(
      jour: json['jour'],
      realises: json['realises'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'jour': jour,
      'realises': realises,
    };
  }
}
