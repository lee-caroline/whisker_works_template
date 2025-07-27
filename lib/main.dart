import 'package:flutter/material.dart';
import 'mouse_model.dart';
import 'dart:convert';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:csv/csv.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(MouseColonyApp());
}

class MouseColonyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Whisker Works',
      theme: ThemeData(primarySwatch: Colors.indigo),
      home: MouseDashboard(),
    );
  }
}

class MouseDashboard extends StatefulWidget {
  @override
  _MouseDashboardState createState() => _MouseDashboardState();
}

class _MouseDashboardState extends State<MouseDashboard> {
  List<MouseData> mice = [];
  int mouseCounter = 1;

@override
void initState() {
  super.initState();
  _loadMiceFromPrefs();
  RawKeyboard.instance.addListener(_handleKey); // 🔑 Add this line
}
  Future<void> _saveMiceToPrefs() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> miceJson = mice.map((m) => jsonEncode(m.toMap())).toList();
    await prefs.setStringList('mice', miceJson);
  }
void _handleKey(RawKeyEvent event) {
  if (event is RawKeyDownEvent && !event.repeat) {
    debugPrint('Key pressed: ${event.logicalKey.debugName}');
    // You can add actions based on keys here if you want
  }
}
@override
void dispose() {
  RawKeyboard.instance.removeListener(_handleKey);
  super.dispose();
}
  Future<void> _loadMiceFromPrefs() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String>? miceJson = prefs.getStringList('mice');
    if (miceJson != null) {
      setState(() {
        mice = miceJson.map((m) => MouseData.fromMap(jsonDecode(m))).toList();
        mouseCounter = mice.length + 1;
      });
    }
  }

  Future<void> _exportCSV() async {
    List<List<String>> rows = [
      ['ID', 'Strain', 'Treatment', 'Sex', 'Procedure', 'DOB', 'Researcher', 'Status', 'Cage', 'Timestamp', 'Litter DOB', 'Wean Date', 'Sex Count'],
      ...mice.map((m) => [
            m.id,
            m.strain,
            m.treatment,
            m.sex,
            m.procedure,
            m.dob,
            m.researcher,
            m.status,
            m.cage,
            m.timestamp,
            m.litterDob ?? '',
            m.litterWeanDate ?? '',
            m.litterSexCount ?? '',
          ])
    ];

    String csvData = const ListToCsvConverter().convert(rows);
    final directory = await getApplicationDocumentsDirectory();
    final path = '${directory.path}/mouse_data.csv';
    final file = File(path);
    await file.writeAsString(csvData);

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('CSV exported to $path')),
    );
  }

  void _addMouse() {
    String strain = '';
    String treatment = '';
    String sex = 'F';
    String procedure = 'Injection';
    String researcher = '';
    String dob = '';
    String status = 'Living';
    String cage = '';
    String litterDob = '';
    String litterWeanDate = '';
    String litterSexCount = '';

    List<String> strainOptions = ['C57BL/6', 'BALB/c', 'CD-1', 'Other'];
    List<String> treatmentOptions = ['Vehicle', 'Drug A', 'Drug B', 'Other'];
    List<String> researcherOptions = ['Dr. Smith', 'Dr. Lee', 'Other'];
    List<String> cageOptions = ['A1', 'B2', 'C3', 'Other'];

    showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setState) => AlertDialog(
            title: Text('Add Mouse Record'),
            content: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  DropdownButtonFormField<String>(
                    value: strainOptions.contains(strain) ? strain : 'Other',
                    decoration: InputDecoration(labelText: 'Strain'),
                    items: strainOptions.map((s) => DropdownMenuItem(value: s, child: Text(s))).toList(),
                    onChanged: (value) => setState(() => strain = value == 'Other' ? '' : value!),
                  ),
                  if (strain.isEmpty)
                    TextField(
                      decoration: InputDecoration(labelText: 'Enter custom strain'),
                      onChanged: (value) => strain = value,
                    ),

                  DropdownButtonFormField<String>(
                    value: treatmentOptions.contains(treatment) ? treatment : 'Other',
                    decoration: InputDecoration(labelText: 'Treatment'),
                    items: treatmentOptions.map((t) => DropdownMenuItem(value: t, child: Text(t))).toList(),
                    onChanged: (value) => setState(() => treatment = value == 'Other' ? '' : value!),
                  ),
                  if (treatment.isEmpty)
                    TextField(
                      decoration: InputDecoration(labelText: 'Enter custom treatment'),
                      onChanged: (value) => treatment = value,
                    ),

                  TextField(
                    decoration: InputDecoration(labelText: 'DOB (YYYY-MM-DD)'),
                    onChanged: (value) => dob = value,
                  ),

                  DropdownButtonFormField<String>(
                    value: researcherOptions.contains(researcher) ? researcher : 'Other',
                    decoration: InputDecoration(labelText: 'Researcher'),
                    items: researcherOptions.map((r) => DropdownMenuItem(value: r, child: Text(r))).toList(),
                    onChanged: (value) => setState(() => researcher = value == 'Other' ? '' : value!),
                  ),
                  if (researcher.isEmpty)
                    TextField(
                      decoration: InputDecoration(labelText: 'Enter custom researcher'),
                      onChanged: (value) => researcher = value,
                    ),

                  DropdownButtonFormField<String>(
                    value: cageOptions.contains(cage) ? cage : 'Other',
                    decoration: InputDecoration(labelText: 'Cage'),
                    items: cageOptions.map((c) => DropdownMenuItem(value: c, child: Text(c))).toList(),
                    onChanged: (value) => setState(() => cage = value == 'Other' ? '' : value!),
                  ),
                  if (cage.isEmpty)
                    TextField(
                      decoration: InputDecoration(labelText: 'Enter custom cage'),
                      onChanged: (value) => cage = value,
                    ),

                  DropdownButton<String>(
                    value: sex,
                    onChanged: (value) => setState(() => sex = value!),
                    items: ['F', 'M'].map((s) => DropdownMenuItem(value: s, child: Text('Sex: $s'))).toList(),
                  ),

                  DropdownButton<String>(
                    value: procedure,
                    onChanged: (value) => setState(() => procedure = value!),
                    items: ['Injection', 'Dissection'].map((s) => DropdownMenuItem(value: s, child: Text('Procedure: $s'))).toList(),
                  ),

                  DropdownButton<String>(
                    value: status,
                    onChanged: (value) => setState(() => status = value!),
                    items: ['Living', 'Deceased: CO2', 'Deceased: Natural'].map((s) => DropdownMenuItem(value: s, child: Text('Status: $s'))).toList(),
                  ),

                  TextField(
                    decoration: InputDecoration(labelText: 'Litter DOB'),
                    onChanged: (value) => litterDob = value,
                  ),
                  TextField(
                    decoration: InputDecoration(labelText: 'Litter Wean Date'),
                    onChanged: (value) => litterWeanDate = value,
                  ),
                  TextField(
                    decoration: InputDecoration(labelText: 'Litter Sex Count (M/F)'),
                    onChanged: (value) => litterSexCount = value,
                  ),
                ],
              ),
            ),
            actions: [
              TextButton(
                onPressed: () {
                  if (strain.isNotEmpty && treatment.isNotEmpty && dob.isNotEmpty) {
                    String tag = mouseCounter.toString().padLeft(6, '0');
                    setState(() {
                      mice.add(MouseData(
                        id: tag,
                        strain: strain,
                        treatment: treatment,
                        sex: sex,
                        procedure: procedure,
                        researcher: researcher,
                        dob: dob,
                        status: status,
                        cage: cage,
                        timestamp: DateTime.now().toString().split('.')[0],
                        litterDob: litterDob.isNotEmpty ? litterDob : null,
                        litterWeanDate: litterWeanDate.isNotEmpty ? litterWeanDate : null,
                        litterSexCount: litterSexCount.isNotEmpty ? litterSexCount : null,
                      ));
                      mouseCounter++;
                    });
                    _saveMiceToPrefs();
                    Navigator.pop(context);
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Mouse $tag added successfully!')),
                    );
                  }
                },
                child: Text('Add'),
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Whisker Works'),
        actions: [
          IconButton(
            icon: Icon(Icons.download),
            onPressed: _exportCSV,
          ),
          IconButton(
            icon: Icon(Icons.add),
            onPressed: _addMouse,
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: mice.length,
        itemBuilder: (context, index) {
          final mouse = mice[index];
          return Card(
            margin: EdgeInsets.all(8),
            child: ListTile(
              title: Text('Mouse ID: ${mouse.id} - ${mouse.strain}'),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Sex: ${mouse.sex} | DOB: ${mouse.dob}'),
                  Text('Treatment: ${mouse.treatment} | Procedure: ${mouse.procedure}'),
                  Text('Researcher: ${mouse.researcher} | Cage: ${mouse.cage}'),
                  if (mouse.litterDob != null) Text('Litter DOB: ${mouse.litterDob}'),
                  if (mouse.litterWeanDate != null) Text('Wean Date: ${mouse.litterWeanDate}'),
                  if (mouse.litterSexCount != null) Text('Sex Count: ${mouse.litterSexCount}'),
                  Text('Timestamp: ${mouse.timestamp}'),
                ],
              ),
              trailing: Text(
                mouse.status,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: mouse.status == 'Living' ? Colors.green : Colors.red,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
