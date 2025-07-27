class MouseData {
  String id;
  String strain;
  String treatment;
  String sex;
  String procedure;
  String researcher;
  String dob;
  String status;
  String cage;
  String? litterDob;
  String? litterWeanDate;
  String? litterSexCount;
  String timestamp;

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

  factory MouseData.fromMap(Map<String, dynamic> data) {
    return MouseData(
      id: data['id'] ?? '',
      strain: data['strain'] ?? '',
      treatment: data['treatment'] ?? '',
      sex: data['sex'] ?? '',
      procedure: data['procedure'] ?? '',
      researcher: data['researcher'] ?? '',
      dob: data['dob'] ?? '',
      status: data['status'] ?? '',
      cage: data['cage'] ?? '',
      timestamp: data['timestamp'] ?? '',
      litterDob: data['litterDob'],
      litterWeanDate: data['litterWeanDate'],
      litterSexCount: data['litterSexCount'],
    );
  }

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
}
