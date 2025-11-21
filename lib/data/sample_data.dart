import 'package:flutter/material.dart';
import '../models/book.dart';

List<Book> sampleBooks = [
  Book(
    id: 1,
    title: "The 7 Habits of Highly Effective People",
    author: "Stephen R. Covey",
    coverUrl:
        "flutter_application_1/assets/images/The 7 Habits of Highly Effective People.jpg", 
    description:
        "*New York Times bestseller—over 40 million copies sold**The #1 Most Influential Business Book of the Twentieth Century*",
    rating: 4.8,
    totalPages: 300,
    currentPage: 0,
  ),
  Book(
    id: 2,
    title: "Cognitive Awakening (Unlock The Power Of Your Mind)",
    author: "Zhou Ling",
    coverUrl:
        "flutter_application_1/assets/images/Cognitive Awakening (Unlock The Power Of Your Mind).jpg", 
    description:
        "To break free from existing habits, the best method is not to rely on willpower, but on knowledge. The fundamental difference between people lies in cognitive ability, because cognition affects choices, and choices change destiny.",
    rating: 4.7,
    totalPages: 300,
    currentPage: 0,
  ),
  Book(
    id: 3,
    title: "Thinking, Fast And Slow",
    author: "Stephen R. Covey",
    coverUrl:
        "flutter_application_1/assets/images/Thinking,_Fast_and_Slow.jpg", 
    description:
        "*Major New York Times Bestseller*More than 2.6 million copies sold",
    rating: 4.6,
    totalPages: 300,
    currentPage: 0,
  ),
  Book(
    id: 4,
    title: "To Kill A Mockingbird",
    author: "Harper Lee",
    coverUrl:
        "flutter_application_1/assets/images/To Kill A Mockingbird.jpg", 
    description:
        "Look for The Land of Sweet Forever, a posthumous collection of newly discovered short stories and previously published essays and magazine pieces by Harper Lee, coming October 21, 2025.",
    rating: 4.7,
    totalPages: 784,
    currentPage: 395,
  ),
  Book(
    id: 5,
    title: "The Laws of Human Nature",
    author: "Robert Greene",
    coverUrl:
        "flutter_application_1/assets/images/The Laws of Human Nature.webp", 
    description: "This is a sample description.",
    rating: 4.5,
    totalPages: 300,
    currentPage: 0,
  ),
  Book(
    id: 6,
    title: "The Power of Now",
    author: "Eckhart Tolle",
    coverUrl:
        "flutter_application_1/assets/images/The Power of Now.jpg", 
    description: "This is a sample description.",
    rating: 4.5,
    totalPages: 300,
    currentPage: 0,
  ),
];
