

class Section {
  // 1
  final int id;
  // ميديا
  final String name;
  // 2023-02-19T06:56:57.000000Z
  final String createdAt;
  // 2023-02-19T06:56:57.000000Z
  final String updatedAt;

  Section({
    required this.id,
    required this.name,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Section.fromJson(Map<String, dynamic> json) => Section(
    id: json['id'],
    name: json['name'],
    createdAt: json['created_at'],
    updatedAt: json['updated_at'],
  );

  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'created_at': createdAt,
    'updated_at': updatedAt,
  };
}

