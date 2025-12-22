class CrtypeModel {
  const CrtypeModel({
    this.id,
    this.crname,
  });

  /// Create from JSON
  factory CrtypeModel.fromJson(Map<String, dynamic> json) {
    return CrtypeModel(
      id: json['id'] as int?,
      crname: json['crname'] as String?,
    );
  }

  final int? id;
  final String? crname;

  /// Convert to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'crname': crname,
    };
  }

  /// Copy with new values (immutability)
  CrtypeModel copyWith({
    int? id,
    String? crname,
  }) {
    return CrtypeModel(
      id: id ?? this.id,
      crname: crname ?? this.crname,
    );
  }

  @override
  String toString() => 'CrtypeModel(id: $id, crname: $crname)';
}