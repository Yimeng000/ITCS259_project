import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import '../providers/book_provider.dart';
import '../theme.dart';
import 'widgets/currently_reading_card.dart';
import 'widgets/want_to_read_card.dart';
import 'widgets/read_card.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<BookProvider>();

    final reading = provider.reading;
    final want = provider.want;
    final read = provider.read;

    return Scaffold(
      appBar: AppBar(centerTitle: true, title: const Text("Readify"),
      actions: [
        IconButton(
          icon: const Icon(Icons.add),
          onPressed: () {
            context.go('/add'); 
          },
        ),
      ],
      ),
      body: provider.books.isEmpty
          ? const Center(child: Text("No books yet"))
          : SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // CURRENTLY READING
                  const Text(
                    "Currently reading",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                      color: AppTheme.textDark,
                    ),
                  ),
                  const SizedBox(height: 10),

                  if (reading.isNotEmpty)
                    CurrentlyReadingCard(book: reading.first)
                  else
                    const Text("You haven't started reading any book."),

                  const SizedBox(height: 25),

                  // WANT TO READ
                  const Text(
                    "Want to read",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                      color: AppTheme.textDark,
                    ),
                  ),
                  const SizedBox(height: 10),

                  SizedBox(
                    height: 220,
                    child: want.isEmpty
                        ? const Text("Your want-to-read list is empty.")
                        : ListView.separated(
                            scrollDirection: Axis.vertical,
                            itemBuilder: (context, index) =>
                                WantToReadCard(book: want[index]),
                            separatorBuilder: (_, __) =>
                                const SizedBox(width: 15),
                            itemCount: want.length,
                          ),
                  ),

                  const SizedBox(height: 25),

                  // READ
                  const Text(
                    "Read",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                      color: AppTheme.textDark,
                    ),
                  ),
                  const SizedBox(height: 10),

                  if (read.isEmpty)
                    const Text("You have not finished a book yet.")
                  else
                    ReadSection(books: read),
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
