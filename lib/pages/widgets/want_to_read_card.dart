import 'dart:io';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../models/book.dart';
import '../book_detail_page.dart';
import '../../../theme.dart';
import '../../../providers/book_provider.dart';

class WantToReadCard extends StatelessWidget {
  final Book book;

  const WantToReadCard({super.key, required this.book});

  @override
  Widget build(BuildContext context) {
    final provider = context.read<BookProvider>();
    return GestureDetector(
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(builder: (_) => DetailPage(book: book)),
      ),
      child: Container(
        width: 150,
        padding: const EdgeInsets.all(12),
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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: _buildCover(book.coverUrl),
            ),
            const SizedBox(height: 10),
            Text(
              book.title,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w700,
                color: AppTheme.textDark,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              book.author,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(fontSize: 12, color: AppTheme.subtitle),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  icon: const Icon(Icons.check),
                  onPressed: () {
                    book.category = "read";
                    provider.updateBook(book);
                  },
                ),
                IconButton(
                  icon: const Icon(Icons.delete),
                  onPressed: () {
                    provider.deleteBook(book.id!);
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // ---------- Safe cover loader ----------
  Widget _buildCover(String coverUrl) {
    // Flutter Web 上不能使用 File
    if (!kIsWeb && coverUrl.isNotEmpty && !coverUrl.startsWith('http')) {
      try {
        final file = File(coverUrl);
        if (file.existsSync()) {
          return Image.file(file, height: 110, width: 75, fit: BoxFit.cover);
        }
      } catch (_) {
        // ignore errors
      }
    }

    if (coverUrl.startsWith('http')) {
      return Image.network(
        coverUrl,
        height: 110,
        width: 75,
        fit: BoxFit.cover,
        errorBuilder: (context, error, stackTrace) => _placeholder(),
      );
    }

    return _placeholder();
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
