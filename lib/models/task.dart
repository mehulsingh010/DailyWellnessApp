class Task {
  final String id;
  final String name;
  final String notes;
  final DateTime createdAt;
  bool isCompleted;

  Task({
    required this.id,
    required this.name,
    this.notes = '',
    required this.createdAt,
    this.isCompleted = false,
  });

  factory Task.fromMap(Map<String, dynamic> map) {
    return Task(
      id: map['id'],
      name: map['name'],
      notes: map['notes'] ?? '',
      createdAt: DateTime.parse(map['createdAt']),
      isCompleted: map['isCompleted'] ?? false,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'notes': notes,
      'createdAt': createdAt.toIso8601String(),
      'isCompleted': isCompleted,
    };
  }
}
