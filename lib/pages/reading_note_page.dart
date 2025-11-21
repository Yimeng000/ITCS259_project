import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import '../models/book.dart';
import '../providers/book_provider.dart';
import '../theme.dart';

class ReadingNotePage extends StatefulWidget {
  final Book book;

  const ReadingNotePage({super.key, required this.book});

  @override
  State<ReadingNotePage> createState() => _ReadingNotePageState();
}

class _ReadingNotePageState extends State<ReadingNotePage> {
  late TextEditingController noteController;

  @override
  void initState() {
    super.initState();
    noteController = TextEditingController(text: widget.book.notes);
  }

  @override
  void dispose() {
    noteController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.read<BookProvider>();

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          widget.book.title,
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w700,
            color: AppTheme.textDark,
          ),
        ),
        centerTitle: true,
      ),

      body: Padding(
        padding: const EdgeInsets.all(18),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Notes",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w700,
                color: AppTheme.textDark,
              ),
            ),

            const SizedBox(height: 15),

            Expanded(
              child: Container(
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(14),
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.black12,
                      blurRadius: 6,
                      offset: Offset(0, 3),
                    ),
                  ],
                ),
                child: TextField(
                  controller: noteController,
                  expands: true,
                  maxLines: null,
                  style: const TextStyle(fontSize: 15, height: 1.6),
                  decoration: const InputDecoration(
                    hintText: "Start writing your notes...",
                    hintStyle: TextStyle(
                      fontSize: 14,
                      color: AppTheme.subtitle,
                    ),
                    border: InputBorder.none,
                  ),
                ),
              ),
            ),

            const SizedBox(height: 20),

            // SAVE BUTTON
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppTheme.primaryColor,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25),
                  ),
                ),
                onPressed: () async {
                  widget.book.notes = noteController.text;

                  await provider.updateBook(widget.book); 

                  Navigator.pop(context); // 返回
                },
                child: const Text(
                  "Save",
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.book), label: 'Details'),
          BottomNavigationBarItem(icon: Icon(Icons.note), label: 'Notes'),
        ],
        onTap: (index) {
          final bookProvider = context.read<BookProvider>();
          switch (index) {
            case 0:
              context.go('/');
              break;
            case 1:
              if (bookProvider.books.isNotEmpty) {
                context.go('/details', extra: bookProvider.books.first);
              }
              break;
            case 2:
              if (bookProvider.books.isNotEmpty) {
                context.go('/notes', extra: bookProvider.books.first);
              }
              break;
          }
        },
      ),
    );
  }
}
