import 'package:flutter/material.dart';
import 'package:flutter_application_1/models/book.dart';
import 'package:flutter_application_1/pages/add_book_page.dart';
import 'package:flutter_application_1/pages/book_detail_page.dart';
import 'package:flutter_application_1/pages/home_page.dart';
import 'package:flutter_application_1/pages/reading_note_page.dart';
import 'package:flutter_application_1/providers/book_provider.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import '../theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final bookProvider = BookProvider();
  await bookProvider.loadBooks();

  runApp(
    ChangeNotifierProvider.value(
      value: bookProvider,
      child: const ReadifyApp(),
    ),
  );
}

class ReadifyApp extends StatelessWidget {
  const ReadifyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final GoRouter _router = GoRouter(
      routes: [
        GoRoute(path: '/', builder: (context, state) => HomePage()),
        GoRoute(path: '/add', builder: (context, state) => const AddBookPage()),
        GoRoute(
          path: '/details',
          builder: (context, state) {
            final book = state.extra as Book;
            return DetailPage(book: book);
          },
        ),
        GoRoute(
          path: '/notes',
          builder: (context, state) {
            final book = state.extra as Book; // 获取传来的 book
            return ReadingNotePage(book: book);
          },
        ),
      ],
    );
    return MaterialApp.router(routerConfig: _router);
  }
}

class BottomNavBar extends StatelessWidget {
  const BottomNavBar({super.key});

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      items: const [
        BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
        BottomNavigationBarItem(icon: Icon(Icons.book), label: 'Details'),
        BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Notes'),
      ],
      onTap: (index) {
        switch (index) {
          case 0:
            context.go('/'); 
            break;
          case 1:
            context.go('/details'); 
            break;
          case 2:
            final bookProvider = context.read<BookProvider>();
            if (bookProvider.books.isNotEmpty) {
              context.go('/notes', extra: bookProvider.books.first);
            } 
            break;
        }
      },
    );
  }
}
