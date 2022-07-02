// ignore_for_file: unnecessary_this

class Place {
  late String location;
  late String name;
  late bool status;
  late List<double> position;
  late int tile;

  Place.fromMap(Map data) {
    this.location = data['location'] ?? 'Sem Local.';
    this.name = data['name'] ?? 'Sem Nome.';
    this.status = data['status'] ?? false;
    this.position = data['position'] ?? [0, 0];
    this.tile = data['tile'] ?? 0;
  }
}
