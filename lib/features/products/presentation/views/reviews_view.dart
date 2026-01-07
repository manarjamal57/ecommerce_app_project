import 'package:flutter/material.dart';

class ReviewsView extends StatelessWidget {
  const ReviewsView({
    super.key,
    this.productName,
  });

  /// اختياري: لو بدك تظهري اسم المنتج فوق (مش لازم)
  final String? productName;
static const routeName = '/reviews';
  @override
  Widget build(BuildContext context) {
    final reviews = _dummyReviews;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        foregroundColor: Colors.black,
        title: Text(productName == null ? 'Reviews' : 'Reviews • $productName'),
      ),
      body: ListView.separated(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        itemCount: reviews.length,
        separatorBuilder: (_, __) => const SizedBox(height: 15),
        itemBuilder: (context, index) {
          return ReviewCard(review: reviews[index]);
        },
      ),
    );
  }
}

/// ======================
/// Review Model (Dummy)
/// ======================
class ReviewModel {
  final String name;
  final String dateText;
  final int rating; // 1..5
  final String comment;

  const ReviewModel({
    required this.name,
    required this.dateText,
    required this.rating,
    required this.comment,
  });
}

/// 3 Reviews ثابتين (زي ما طلبتي)
const List<ReviewModel> _dummyReviews = [
  ReviewModel(
    name: 'Sarah Ali',
    dateText: '12 Dec 2025',
    rating: 5,
    comment: 'Amazing product, exceeded my expectations.',
  ),
  ReviewModel(
    name: 'Ahmed Noor',
    dateText: '02 Dec 2025',
    rating: 4,
    comment: 'Good quality and fast delivery. Very satisfied.',
  ),
  ReviewModel(
    name: 'Lina Hassan',
    dateText: '25 Nov 2025',
    rating: 4,
    comment: 'Nice design, comfortable to use. Would recommend it.',
  ),
];

/// ======================
/// Review Card UI
/// ======================
class ReviewCard extends StatelessWidget {
  const ReviewCard({super.key, required this.review});

  final ReviewModel review;

  @override
  Widget build(BuildContext context) {
    return Container(
    padding: const EdgeInsets.symmetric(
    horizontal: 20,
    vertical: 24, // كبّريها
  ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: Colors.black12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header row: avatar + name/date
          Row(
            children: [
              CircleAvatar(
                radius: 30,
                backgroundColor: Colors.black12,
                child: Text(
                  _initials(review.name),
                  style: const TextStyle(
                    color: Colors.black87,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      review.name,
                      style: const TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w800,
                        color: Colors.black,
                      ),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      review.dateText,
                      style: const TextStyle(
                        fontSize: 12,
                        color: Colors.black54,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
              _StarRow(rating: review.rating),
            ],
          ),

          const SizedBox(height: 15),

          // Comment
          Text(
            review.comment,
            style: const TextStyle(
              fontSize: 14,
              height: 1.35,
              color: Colors.black87,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  String _initials(String name) {
    final parts = name.trim().split(RegExp(r'\s+'));
    if (parts.isEmpty) return '';
    if (parts.length == 1) return parts.first.characters.take(1).toString();
    return (parts[0].characters.take(1).toString() +
        parts[1].characters.take(1).toString());
  }
}

/// نجوم بسيطة
class _StarRow extends StatelessWidget {
  const _StarRow({required this.rating});

  final int rating; // 1..5

  @override
  Widget build(BuildContext context) {
    final r = rating.clamp(0, 5);
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(5, (i) {
        final filled = i < r;
        return Icon(
          filled ? Icons.star_rounded : Icons.star_border_rounded,
          size: 18,
          color: filled ? Colors.amber : Colors.black26,
        );
      }),
    );
  }
}
