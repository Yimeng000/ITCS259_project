import 'dart:io';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:image_picker/image_picker.dart';

import '../models/book.dart';
import '../providers/book_provider.dart';

class AddBookPage extends StatefulWidget {
  const AddBookPage({super.key});

  @override
  State<AddBookPage> createState() => _AddBookPageState();
}

class _AddBookPageState extends State<AddBookPage> {
  final idController = TextEditingController();
  final titleController = TextEditingController();
  final authorController = TextEditingController();
  final coverUrlController = TextEditingController();
  final descController = TextEditingController();
  final pagesController = TextEditingController();
  String category = "want";

  File? _localImageFile; 
  final ImagePicker _picker = ImagePicker();

  @override
  Widget build(BuildContext context) {
    final provider = context.read<BookProvider>();

    return Scaffold(
      appBar: AppBar(title: const Text("Add Book")),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(18),
        child: Column(
          children: [
            //  Cover preview (prefer local, then URL)
            _buildCoverPreview(),
            const SizedBox(height: 10),
            // Local selection button
            ElevatedButton.icon(
              onPressed: () async {
                final XFile? picked =
                    await _picker.pickImage(source: ImageSource.gallery);
                if (picked != null) {
                  setState(() {
                    _localImageFile = File(picked.path);
                  });
                }
              },
              icon: const Icon(Icons.image),
              label: const Text("Choose Local Image"),
            ),

            const SizedBox(height: 20),

            _input("ID", idController),
            _input("Title", titleController),
            _input("Author", authorController),

            // input URL 
            _input(
              "Cover Image URL",
              coverUrlController,
              onChanged: (_) => setState(() {}),
            ),

            _input("Description", descController, maxLines: 4),
            _input("Current Pages", pagesController),
            _input("Total Pages", pagesController),

            const SizedBox(height: 20),

            DropdownButton<String>(
              value: category,
              isExpanded: true,
              items: const [
                DropdownMenuItem(value: "want", child: Text("Want to Read")),
                DropdownMenuItem(value: "reading", child: Text("Reading")),
                DropdownMenuItem(value: "read", child: Text("Finished")),
              ],
              onChanged: (v) => setState(() => category = v!),
            ),

            const SizedBox(height: 20),

            ElevatedButton(
              onPressed: () async {
                if (idController.text.isEmpty ||
                    titleController.text.isEmpty ||
                    authorController.text.isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text("ID, Title, and Author are required."),
                    ),
                  );
                  return;
                }

                final savedCover = _localImageFile?.path.isNotEmpty == true
                    ? _localImageFile!.path
                    : coverUrlController.text;

                final book = Book(
                  id: int.tryParse(idController.text),
                  title: titleController.text,
                  author: authorController.text,
                  coverUrl: savedCover,
                  description: descController.text,
                  category: category,
                  currentPage: 0,
                  totalPages: int.tryParse(pagesController.text) ?? 0,
                  rating: 0.0,
                );

                await provider.addBook(book);
                Navigator.pop(context);
              },
              child: const Text("Save Book"),
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

  //  Cover display logic: Local > URL > None
  Widget _buildCoverPreview() {
    if (_localImageFile != null) {
      return ClipRRect(
        borderRadius: BorderRadius.circular(8),
        child: Image.file(
          _localImageFile!,
          height: 200,
          width: double.infinity,
          fit: BoxFit.cover,
        ),
      );
    }

    if (coverUrlController.text.isNotEmpty) {
      return ClipRRect(
        borderRadius: BorderRadius.circular(8),
        child: Image.network(
          coverUrlController.text,
          height: 200,
          width: double.infinity,
          fit: BoxFit.cover,
          errorBuilder: (context, error, stackTrace) {
            return Container(
              height: 200,
              color: Colors.grey[300],
              child: const Icon(Icons.error, color: Colors.red),
            );
          },
        ),
      );
    }

    return Container(
      height: 200,
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.grey[300],
        borderRadius: BorderRadius.circular(8),
      ),
      child: const Center(
        child: Text("No Image Selected"),
      ),
    );
  }

  Widget _input(
    String label,
    TextEditingController c, {
    int maxLines = 1,
    Function(String)? onChanged,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: TextField(
        controller: c,
        maxLines: maxLines,
        onChanged: onChanged,
        decoration: InputDecoration(
          border: const OutlineInputBorder(),
          labelText: label,
        ),
      ),
    );
  }
}
