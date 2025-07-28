import 'package:hive/hive.dart';

part 'mouse_model.g.dart';

@HiveType(typeId: 0)
class MouseData extends HiveObject {
  @HiveField(0)
  final String id;

  @HiveField(1)
  final String strain;

  @HiveField(2)
  final String treatment;

  @HiveField(3)
  final String sex;

  @HiveField(4)
  final String procedure;

  @HiveField(5)
  final String researcher;

  @HiveField(6)
  final String dob;

  @HiveField(7)
  final String status;

  @HiveField(8)
  final String cage;

  @HiveField(9)
  final String timestamp;

  @HiveField(10)
  final String? litterDob;

  @HiveField(11)
  final String? litterWeanDate;

  @HiveField(12)
  final String? litterSexCount;

  MouseData({
    required this.id,
    required this.strain,
    required this.treatment,
    required this.sex,
    required this.procedure,
    required this.researcher,
    required this.dob,
    required this.status,
    required this.cage,
    required this.timestamp,
    this.litterDob,
    this.litterWeanDate,
    this.litterSexCount,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'strain': strain,
      'treatment': treatment,
      'sex': sex,
      'procedure': procedure,
      'researcher': researcher,
      'dob': dob,
      'status': status,
      'cage': cage,
      'timestamp': timestamp,
      if (litterDob != null) 'litterDob': litterDob,
      if (litterWeanDate != null) 'litterWeanDate': litterWeanDate,
      if (litterSexCount != null) 'litterSexCount': litterSexCount,
    };
  }

  factory MouseData.fromMap(Map<String, dynamic> map) {
    return MouseData(
      id: map['id'],
      strain: map['strain'],
      treatment: map['treatment'],
      sex: map['sex'],
      procedure: map['procedure'],
      researcher: map['researcher'],
      dob: map['dob'],
      status: map['status'],
      cage: map['cage'],
      timestamp: map['timestamp'],
      litterDob: map['litterDob'],
      litterWeanDate: map['litterWeanDate'],
      litterSexCount: map['litterSexCount'],
    );
  }
}