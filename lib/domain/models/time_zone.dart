class TimeZoneModel {
  final int id;
  final String name;
  final String abbreviation;

  TimeZoneModel({
    required this.id,
    required this.name,
    required this.abbreviation,
  });

  factory TimeZoneModel.fromJson(Map<String, dynamic> json) {
    return TimeZoneModel(
      id: json['id'],
      name: json['name'],
      abbreviation: json['abbreviation'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'abbreviation': abbreviation,
    };
  }
}
