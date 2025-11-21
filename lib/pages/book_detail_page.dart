import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import '../models/book.dart';
import '../providers/book_provider.dart';
import '../theme.dart';
import 'reading_note_page.dart';

class DetailPage extends StatelessWidget {
  final Book book;

  const DetailPage({super.key, required this.book});

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<BookProvider>();

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios_new_rounded,
            color: AppTheme.textDark,
          ),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text("Readify"),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.person, color: AppTheme.textDark),
            onPressed: () {},
          ),
        ],
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Book Cover
            Center(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(14),
                child: Image.network(
                  book.coverUrl,
                  height: 260,
                  width: 180,
                  fit: BoxFit.cover,
                ),
              ),
            ),

            const SizedBox(height: 15),

            // Title + Author
            Text(
              book.title,
              style: const TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.w700,
                color: AppTheme.textDark,
              ),
            ),
            const SizedBox(height: 6),

            Text(
              book.author,
              style: const TextStyle(fontSize: 16, color: AppTheme.subtitle),
            ),

            const SizedBox(height: 10),

            // Rating
            Row(
              children: [
                const Icon(Icons.star, color: Colors.orange, size: 20),
                const SizedBox(width: 4),
                Text(
                  book.rating.toStringAsFixed(1),
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                    color: AppTheme.textDark,
                  ),
                ),
                const SizedBox(width: 4),
                const Text(
                  "/ 10",
                  style: TextStyle(fontSize: 13, color: AppTheme.subtitle),
                ),
              ],
            ),

            const SizedBox(height: 20),

            // BUTTON（根据 category 动态切换）
            _buildDynamicButton(context),

            const SizedBox(height: 20),

            // Description
            const Text(
              "Description",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w700,
                color: AppTheme.textDark,
              ),
            ),

            const SizedBox(height: 8),

            Text(
              book.description,
              style: const TextStyle(fontSize: 14, height: 1.5),
            ),

            const SizedBox(height: 20),

            // Reviews Section
            const Text(
              "Reviews",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w700,
                color: AppTheme.textDark,
              ),
            ),
            const SizedBox(height: 10),

            _buildReviewCard(
              avatar: "A",
              name: "Apple",
              stars: 5,
              text:
                  "Excellent book! Should be read by every human being that wants to understand others.",
            ),

            const SizedBox(height: 15),

            _buildReviewCard(
              avatar: "C",
              name: "Cindy",
              stars: 4,
              text:
                  "I believe that everyone can improve themselves by reading this book. Great insights!",
            ),
            Text(
              "Edit Notes",
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: AppTheme.primaryColor,
              ),
            ),
            const SizedBox(height: 30),
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

  Widget _buildDynamicButton(BuildContext context) {
    final provider = context.read<BookProvider>();

    String text = "";
    Function() onPressed;

    if (book.category == "want") {
      text = "Add to bookshelf";
      onPressed = () {
        book.category = "reading"; 
        provider.updateBook(book);
      };
    } else if (book.category == "reading") {
      text = "Continue reading";
      onPressed = () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => ReadingNotePage(book: book)),
        );
      };
    } else {
      text = "Read again";
      onPressed = () {
        book.currentPage = 0;
        book.category = "reading";
        provider.updateBook(book);
      };
    }

    return SizedBox(
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
        onPressed: onPressed,
        child: Text(
          text,
          style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
        ),
      ),
    );
  }

  Widget _buildReviewCard({
    required String avatar,
    required String name,
    required int stars,
    required String text,
  }) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              CircleAvatar(
                radius: 18,
                backgroundColor: AppTheme.primaryColor.withOpacity(0.2),
                child: Text(
                  avatar,
                  style: const TextStyle(
                    color: AppTheme.primaryColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(width: 10),
              Text(
                name,
                style: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w700,
                  color: AppTheme.textDark,
                ),
              ),
              const SizedBox(width: 10),
              Row(
                children: List.generate(
                  stars,
                  (_) => const Icon(Icons.star, color: Colors.orange, size: 18),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Text(text, style: const TextStyle(fontSize: 14, height: 1.5)),
        ],
      ),
    );
  }
}
