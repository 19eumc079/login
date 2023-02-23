class Lead {
  final String leadNumber;
  final String name;

  Lead({required this.leadNumber, required this.name});

  factory Lead.fromJson(Map<String, dynamic> json) {
    return Lead(
      leadNumber: json['documentNumber']['leadNumber'] as String,
      name: json['currentStage']['name'] as String,
    );
  }
}
