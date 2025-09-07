import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:animations/animations.dart';

import '../category_chip.dart';
import '../product_card.dart';
import 'product_details.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;
  int _deliveryMode = 0; // 0: Delivery, 1: Pickup

  final categories = [
    {"label": "Organic", "icon": CupertinoIcons.tree},
    {"label": "Grains", "icon": CupertinoIcons.circle_grid_3x3},
    {"label": "Meats", "icon": CupertinoIcons.rosette},
    {"label": "Bakery", "icon": CupertinoIcons.capsule},
    {"label": "Fresh", "icon": CupertinoIcons.clear},
  ];

  final products = const [
    Product(
      id: 'p1',
      title: 'Farm Fresh Produce',
      price: 10.00,
      discount: 5,
      rating: 3.5,
      etaMin: 10,
      imageUrl:
      'https://images.unsplash.com/photo-1542838132-92c53300491e?q=80&w=1200&auto=format&fit=crop',
      description:
      'Enjoy farm-fresh produce, handpicked for quality, packed with nutrition, and delivered with care!',
    ),
    Product(
      id: 'p2',
      title: 'Tomatoes Basket',
      price: 12.50,
      discount: 10,
      rating: 4.0,
      etaMin: 12,
      imageUrl:
      'https://images.unsplash.com/photo-1567306226416-28f0efdc88ce?q=80&w=1200&auto=format&fit=crop',
      description:
      'Juicy, fresh red tomatoes full of flavor and nutrition. Perfect for salads and cooking.',
    ),
    Product(
      id: 'p3',
      title: 'Fresh Broccoli',
      price: 8.99,
      discount: 0,
      rating: 4.5,
      etaMin: 8,
      imageUrl:
      'https://images.unsplash.com/photo-1601004890684-d8cbf643f5f2?q=80&w=1200&auto=format&fit=crop',
      description:
      'Green, healthy broccoli packed with vitamins and perfect for stir-fry and soups.',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Scaffold(
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(20, 8, 20, 12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        const Icon(CupertinoIcons.location_solid, size: 20),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: const [
                              Text(
                                'Delivery location',
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.grey,
                                ),
                              ),
                              Text(
                                'Smart Valley Point',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                        ),
                        _roundIcon(context, CupertinoIcons.search),
                        const SizedBox(width: 10),
                        _roundIcon(context, CupertinoIcons.bell),
                      ],
                    ),
                    const SizedBox(height: 16),
                    _deliveryPickupSegment(cs),
                    const SizedBox(height: 16),
                    _categoryRow(),
                    const SizedBox(height: 18),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: const [
                        Text(
                          'Popular items',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        Text(
                          'See All',
                          style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w600,
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                  ],
                ),
              ),
            ),

            /// ✅ Vertical Product Cards
            SliverToBoxAdapter(
              child: ListView.separated(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                padding:
                const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                itemCount: products.length,
                separatorBuilder: (_, __) => const SizedBox(height: 16),
                itemBuilder: (_, i) {
                  final product = products[i];
                  return OpenContainer(
                    closedElevation: 0,
                    openElevation: 0,
                    closedShape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(22),
                    ),
                    openShape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(0),
                    ),
                    transitionType: ContainerTransitionType.fadeThrough,
                    closedBuilder: (c, open) => ProductCard(
                      product: product,
                      onTap: open,
                    ),
                    openBuilder: (c, close) =>
                        ProductDetailsScreen(product: product),
                  );
                },
              ),
            ),

            const SliverToBoxAdapter(child: SizedBox(height: 24)),
          ],
        ),
      ),
      bottomNavigationBar: _bottomNav(),
    );
  }

  static Widget _roundIcon(BuildContext context, IconData icon) {
    return Container(
      width: 38,
      height: 38,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: IconButton(
        icon: Icon(icon, size: 20),
        onPressed: () {},
        splashRadius: 22,
      ),
    );
  }

  Widget _deliveryPickupSegment(ColorScheme cs) {
    return Container(
      padding: const EdgeInsets.all(6),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Row(
        children: [
          _segmentButton(
              label: 'Delivery',
              index: 0,
              cs: cs,
              icon: CupertinoIcons.cube_box),
          _segmentButton(
              label: 'Pickup',
              index: 1,
              cs: cs,
              icon: CupertinoIcons.car_detailed),
        ],
      ),
    );
  }

  Expanded _segmentButton(
      {required String label,
        required int index,
        required ColorScheme cs,
        required IconData icon}) {
    final selected = _deliveryMode == index;
    return Expanded(
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        curve: Curves.easeOut,
        padding: const EdgeInsets.symmetric(vertical: 12),
        decoration: BoxDecoration(
          color: selected ? cs.primary.withOpacity(0.12) : Colors.transparent,
          borderRadius: BorderRadius.circular(12),
        ),
        child: InkWell(
          onTap: () => setState(() => _deliveryMode = index),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon,
                  size: 18, color: selected ? cs.primary : Colors.black87),
              const SizedBox(width: 8),
              Text(
                label,
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  color: selected ? cs.primary : Colors.black87,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _categoryRow() {
    return SizedBox(
      height: 100,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: categories.length,
        padding: const EdgeInsets.symmetric(horizontal: 20),
        separatorBuilder: (_, __) => const SizedBox(width: 20),
        itemBuilder: (_, i) {
          final c = categories[i];
          return CategoryChip(
            label: c["label"] as String,
            icon: c["icon"] as IconData,
          );
        },
      ),
    );
  }

  /// ✅ Floating Rounded Bottom Navigation
  Widget _bottomNav() {
    final cs = Theme.of(context).colorScheme;

    return Container(
      margin: const EdgeInsets.all(16), // floating look
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(30),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 12,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(30),
        child: BottomNavigationBar(
          currentIndex: _currentIndex,
          onTap: (i) => setState(() => _currentIndex = i),
          type: BottomNavigationBarType.fixed,
          backgroundColor: Colors.white,
          selectedItemColor: cs.primary,
          unselectedItemColor: Colors.grey,
          showUnselectedLabels: true,
          selectedLabelStyle: const TextStyle(fontWeight: FontWeight.w700),
          items: const [
            BottomNavigationBarItem(
              icon: Icon(CupertinoIcons.house_fill),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(CupertinoIcons.bag_fill),
              label: 'Orders',
            ),
            BottomNavigationBarItem(
              icon: Icon(CupertinoIcons.cart_fill),
              label: 'Cart',
            ),
            BottomNavigationBarItem(
              icon: Icon(CupertinoIcons.person_solid),
              label: 'Profile',
            ),
          ],
        ),
      ),
    );
  }
}

class Product {
  final String id;
  final String title;
  final double price;
  final int discount;
  final double rating;
  final int etaMin;
  final String imageUrl;
  final String description;

  const Product({
    required this.id,
    required this.title,
    required this.price,
    required this.discount,
    required this.rating,
    required this.etaMin,
    required this.imageUrl,
    required this.description,
  });
}
