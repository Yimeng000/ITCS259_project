import 'dart:io';
import 'package:flutter/material.dart';
import '../../../models/book.dart';
import '../../../theme.dart';
import '../book_detail_page.dart';

class CurrentlyReadingCard extends StatelessWidget {
  final Book book;
  const CurrentlyReadingCard({super.key, required this.book});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(builder: (_) => DetailPage(book: book)),
      ),
      child: Container(
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(14),
          boxShadow: const [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 6,
              offset: Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: _buildCover(book.coverUrl),
            ),
            const SizedBox(width: 15),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    book.title,
                    style: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w700,
                      color: AppTheme.textDark,
                    ),
                  ),
                  const SizedBox(height: 3),
                  Text(
                    book.author,
                    style: const TextStyle(
                      fontSize: 13,
                      color: AppTheme.subtitle,
                    ),
                  ),
                  const SizedBox(height: 12),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: LinearProgressIndicator(
                      value: book.progress,
                      minHeight: 7,
                      backgroundColor: Colors.grey[200],
                      color: AppTheme.primaryColor,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    "${(book.progress * 100).toStringAsFixed(0)}% complete",
                    style: const TextStyle(
                      fontSize: 12,
                      color: AppTheme.subtitle,
                    ),
                  ),
                  const SizedBox(height: 10),
                  SizedBox(
                    width: 150,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppTheme.primaryColor,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(25),
                        ),
                      ),
                      onPressed: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => DetailPage(book: book),
                        ),
                      ),
                      child: const Text(
                        "Continue reading",
                        style: TextStyle(fontSize: 13),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ---------------- Safe image loader ----------------
  Widget _buildCover(String coverUrl) {
    try {
      if (coverUrl.startsWith('http')) {
        // 网络图片
        return Image.network(
          coverUrl,
          height: 110,
          width: 75,
          fit: BoxFit.cover,
          errorBuilder: (context, error, stackTrace) => _placeholder(),
        );
      } else if (coverUrl.isNotEmpty) {
        // 本地图片
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
