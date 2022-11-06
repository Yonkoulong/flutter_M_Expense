class TripConstants {
  static const String emptyString = "";
  static const int newTripId = 0;
  static const String riskDefault = "false";
}

class TripEntity {
  int? id;
  String tripName = TripConstants.emptyString;
  String destination = TripConstants.emptyString;
  String tripDate = TripConstants.emptyString;
  String riskAssessment = TripConstants.riskDefault;
  String description = TripConstants.emptyString;

  TripEntity(
    this.id,
    this.tripName,
    this.destination,
    this.tripDate,
    this.riskAssessment,
    this.description,
  );

  TripEntity.newTrip(String tripName, String destination, String tripDate,
      String riskAssessment, String description)
      : this(null, tripName, destination, tripDate, riskAssessment, description);

  TripEntity.empty();

  TripEntity.fromMap(Map<String, dynamic> map) {
    id = map['id'];
    tripName = map['tripName'];
    destination = map['destination'];
    tripDate = map['tripDate'];
    riskAssessment = map['riskAssessment'];
    description = map['description'];
  }

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      'id': id,
      'tripName': tripName,
      'destination': destination,
      'tripDate': tripDate,
      'riskAssessment': riskAssessment,
      'description': description
    };
    return map;
  }
}
