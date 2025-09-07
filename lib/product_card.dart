
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../home_screen.dart';

class ProductCard extends StatelessWidget {
  final Product product;
  final VoidCallback? onTap;
  const ProductCard({super.key, required this.product, this.onTap});

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return InkWell(
      borderRadius: BorderRadius.circular(22),
      onTap: onTap,
      child: Container(
        width: 220,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(22),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.06),
              blurRadius: 14,
              offset: const Offset(0, 8),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.vertical(top: Radius.circular(22)),
              child: AspectRatio(
                aspectRatio: 16/10,
                child: Image.network(product.imageUrl, fit: BoxFit.cover),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(12, 10, 12, 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(product.title, maxLines: 1, overflow: TextOverflow.ellipsis,
                      style: const TextStyle(fontWeight: FontWeight.w800)),
                  const SizedBox(height: 6),
                  Row(
                    children: [
                      Text('\$${product.price.toStringAsFixed(2)}',
                          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w800)),
                      const Spacer(),
                      const Icon(CupertinoIcons.star_fill, size: 14, color: Color(0xFFFFC107)),
                      const SizedBox(width: 4),
                      Text('${product.rating}', style: const TextStyle(fontWeight: FontWeight.w700)),
                    ],
                  ),
                  const SizedBox(height: 6),
                  Row(
                    children: [
                      const Icon(CupertinoIcons.cube_box, size: 16),
                      const SizedBox(width: 6),
                      const Text('Delivered', style: TextStyle(fontWeight: FontWeight.w700)),
                      const Spacer(),
                      const Icon(CupertinoIcons.time, size: 16),
                      const SizedBox(width: 4),
                      Text('Time ${product.etaMin} min', style: const TextStyle(fontWeight: FontWeight.w700)),
                    ],
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
