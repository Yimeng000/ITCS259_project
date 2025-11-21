import 'dart:io';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../models/book.dart';
import '../../../theme.dart';
import '../book_detail_page.dart';
import '../../../providers/book_provider.dart';

class ReadSection extends StatelessWidget {
  final List<Book> books;
  const ReadSection({super.key, required this.books});

  @override
  Widget build(BuildContext context) {
    final provider = context.read<BookProvider>();
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: AppTheme.lightGray,
        borderRadius: BorderRadius.circular(14),
      ),
      child: Column(
        children: books.isEmpty
            ? [
                const Center(
                  child: Text("You have not finished any books yet."),
                ),
              ]
            : books.map((book) => _buildBookRow(context, book, provider)).toList(),
      ),
    );
  }

  Widget _buildBookRow(BuildContext context, Book book, BookProvider provider) {
    return GestureDetector(
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => DetailPage(book: book),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: _buildCover(book.coverUrl),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Text(
                book.title,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: AppTheme.textDark,
                ),
              ),
            ),
            IconButton(
              icon: const Icon(Icons.delete),
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: const Text("Delete"),
                    content: const Text("Are you sure you want to delete this book?"),
                    actions: [
                      TextButton(
                        onPressed: () => Navigator.pop(context),
                        child: const Text("Cancel"),
                      ),
                      TextButton(
                        onPressed: () {
                          provider.deleteBook(book.id!);
                          Navigator.pop(context);
                        },
                        child: const Text("Delete"),
                      ),
                    ],
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  // ---------- Safe image loader ----------
  Widget _buildCover(String coverUrl) {
    try {
      if (coverUrl.startsWith('http')) {
        return Image.network(
          coverUrl,
          height: 110,
          width: 75,
          fit: BoxFit.cover,
          errorBuilder: (context, error, stackTrace) => _placeholder(),
        );
      } else if (coverUrl.isNotEmpty) {
        final file = File(coverUrl);
        if (file.existsSync()) {
          return Image.file(file, height: 110, width: 75, fit: BoxFit.cover);
        } else {
          return _placeholder();
        }
      } else {
        return _placeholder();
      }
    } catch (e) {
      return _placeholder();
    }
  }

  Widget _placeholder() {
    return Container(
      height: 110,
      width: 75,
      color: Colors.grey[300],
      child: const Icon(Icons.book, color: Colors.white),
    );
  }
}
