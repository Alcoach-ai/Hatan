

class Team {
  // 1
  final int id;
  // 2023-02-18T11:07:45.000000Z
  final String createdAt;
  // 2023-02-18T11:07:45.000000Z
  final String updatedAt;

  late String name;

  Team({
    this.id = 0,
    this.createdAt = "",
    this.updatedAt = "",
  }){
    name = 'الفريق $id';
  }

  factory Team.fromJson(Map<String, dynamic> json) => Team(
    id: json['id'],
    createdAt: json['created_at'],
    updatedAt: json['updated_at'],
  );

  Map<String, dynamic> toJson() => {
    'id': id,
    'created_at': createdAt,
    'updated_at': updatedAt,
  };
}

