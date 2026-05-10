import 'package:flutter/material.dart';
import 'table_screen.dart';
import 'models/study_item.dart';

class ListScreen extends StatefulWidget {
  const ListScreen({super.key});

  @override
  State<ListScreen> createState() => _ListScreenState();
}

class _ListScreenState extends State<ListScreen> {
  final TextEditingController _subjectController = TextEditingController();
  final TextEditingController _roomController = TextEditingController();
  bool _showList = false;

  final List<StudyItem> _studyItems = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("المهام والمدخلات"),
        centerTitle: true,
        backgroundColor: Colors.blue.shade800,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Input Fields Card
            Card(
              elevation: 4,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  children: [
                    TextField(
                      controller: _subjectController,
                      textAlign: TextAlign.right,
                      decoration: InputDecoration(
                        labelText: "اسم المادة",
                        alignLabelWithHint: true,
                        prefixIcon: const Icon(Icons.book),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                    const SizedBox(height: 15),
                    TextField(
                      controller: _roomController,
                      textAlign: TextAlign.right,
                      decoration: InputDecoration(
                        labelText: "رقم القاعة أو وقت المحاضرة",
                        alignLabelWithHint: true,
                        prefixIcon: const Icon(Icons.meeting_room),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    ElevatedButton.icon(
                      onPressed: () {
                        if (_subjectController.text.isNotEmpty &&
                            _roomController.text.isNotEmpty) {
                          setState(() {
                            _studyItems.add(
                              StudyItem(
                                name: _subjectController.text,
                                room: _roomController.text,
                                date:
                                    "${DateTime.now().day}/${DateTime.now().month}", // Simple date for now
                              ),
                            );
                            _subjectController.clear();
                            _roomController.clear();
                            _showList = true;
                          });
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text("يرجى ملء جميع الحقول"),
                            ),
                          );
                        }
                      },
                      icon: const Icon(Icons.add),
                      label: const Text("إضافة مادة"),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue.shade800,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(
                          vertical: 12,
                          horizontal: 100,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),

            // List View Section
            if (_showList) ...[
              const Text(
                "المواد الدراسية الحالية:",
                textAlign: TextAlign.right,
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: _studyItems.length,
                itemBuilder: (context, index) {
                  final item = _studyItems[index];
                  return Card(
                    margin: const EdgeInsets.only(bottom: 10),
                    child: ListTile(
                      trailing: const Icon(Icons.arrow_back_ios, size: 16),
                      title: Text(
                        item.name,
                        textAlign: TextAlign.right,
                        style: const TextStyle(fontWeight: FontWeight.w500),
                      ),
                      subtitle: Text(
                        "القاعة: ${item.room}",
                        textAlign: TextAlign.right,
                      ),
                      leading: CircleAvatar(
                        backgroundColor: Colors.blue.shade100,
                        child: Text("${index + 1}"),
                      ),
                    ),
                  );
                },
              ),
            ],

            const SizedBox(height: 30),

            // Table Button
            OutlinedButton.icon(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => TableScreen(studyItems: _studyItems),
                  ),
                );
              },
              icon: const Icon(Icons.table_chart),
              label: const Text("View Table"),
              style: OutlinedButton.styleFrom(
                foregroundColor: Colors.blue.shade800,
                side: BorderSide(color: Colors.blue.shade800),
                padding: const EdgeInsets.symmetric(vertical: 15),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
