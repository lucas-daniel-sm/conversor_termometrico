class Scale {
  final String name;
  final double melting;
  final double boiling;
  final bool degree;

  Scale({
    required this.name,
    required this.melting,
    required this.boiling,
    required this.degree,
  });

  Scale.fromJson(Map<String, dynamic> json)
      : name = json['name'],
        melting = json['melting'],
        boiling = json['boiling'],
        degree = json['degree'];

  Map<String, dynamic> toJson() {
    return {
      'name': this.name,
      'melting': this.melting,
      'boiling': this.boiling,
      'degree': this.degree,
    };
  }
}
