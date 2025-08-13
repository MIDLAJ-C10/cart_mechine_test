import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pokak/core/color_constant.dart';
import 'package:pokak/features/home/screen/product_details.dart';
import '../../../main.dart';
import '../controller/product_controlelr.dart';

class ProductListScreen extends StatefulWidget {
  @override
  _ProductListScreenState createState() => _ProductListScreenState();
}

class _ProductListScreenState extends State<ProductListScreen> {
  final ProductController controller = Get.find<ProductController>();
  final PageController _bannerController = PageController();
  String selectedCategory = 'All';
  int _currentBannerIndex = 0;

  @override
  void initState() {
    super.initState();
    controller.loadProducts();
    _startBannerAutoSlide();
  }

  void _startBannerAutoSlide() {
    Future.delayed(const Duration(seconds: 3), () {
      if (mounted && _bannerController.hasClients) {
        _currentBannerIndex = (_currentBannerIndex + 1) % 3;
        _bannerController.animateToPage(
          _currentBannerIndex,
          duration: const Duration(milliseconds: 500),
          curve: Curves.easeInOut,
        );
        _startBannerAutoSlide();
      }
    });
  }

  @override
  void dispose() {
    _bannerController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorConst.white,
      body: SafeArea(
        top: false,
        child: CustomScrollView(
          slivers: [
            // Modern App Bar
            _buildAppBar(context),

            // Banner Carousel
            _buildBannerCarousel(context),

            // Category Filter
            _buildCategoryFilter(context),

            // Product Grid
            _buildProductGrid(context),
          ],
        ),
      ),
    );
  }

  Widget _buildAppBar(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    return SliverAppBar(
      toolbarHeight: height * 0.09,
      expandedHeight: height * 0.22,
      floating: false,
      pinned: true,
      automaticallyImplyLeading: false,
      backgroundColor: ColorConst.primaryColor,
      elevation: 0,
      centerTitle: false,
      flexibleSpace: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          // This will let us detect if the app bar is collapsed
          final bool isCollapsed = constraints.maxHeight <= height * 0.12;

          return FlexibleSpaceBar(
            centerTitle: true,
            titlePadding: EdgeInsets.symmetric(horizontal: width * 0.04, vertical: 8),
            title: isCollapsed
                ? _buildSearchBar(width, height) // Show search bar in collapsed state
                : null,
            background: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    ColorConst.primaryColor,
                    ColorConst.primaryColor.withOpacity(0.8),
                  ],
                ),
              ),
              child: SafeArea(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: width * 0.04),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(height: height * 0.02),
                      // Header with greeting and profile
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Good Morning!",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: width * 0.04,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                                Text(
                                  "Welcome Back",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: width * 0.055,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Row(
                            children: [
                              Container(
                                padding: EdgeInsets.all(width * 0.02),
                                decoration: BoxDecoration(
                                  color: Colors.white.withOpacity(0.2),
                                  borderRadius: BorderRadius.circular(width * 0.02),
                                ),
                                child: Icon(
                                  Icons.notifications_outlined,
                                  color: Colors.white,
                                  size: width * 0.06,
                                ),
                              ),
                              SizedBox(width: width * 0.03),
                              CircleAvatar(
                                radius: width * 0.05,
                                backgroundColor: Colors.white,
                                child: Icon(
                                  Icons.person,
                                  color: ColorConst.primaryColor,
                                  size: width * 0.06,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      SizedBox(height: height * 0.02),
                      _buildSearchBar(width, height), // Search bar in expanded state
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildSearchBar(double width, double height) {
    return Container(
      height: height * 0.055,
      padding: EdgeInsets.symmetric(horizontal: width * 0.03),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(width * 0.03),
      ),
      child: Row(
        children: [
          Icon(Icons.search, color: Colors.grey, size: width * 0.05),
          SizedBox(width: width * 0.02),
          Expanded(
            child: TextField(
              decoration: InputDecoration(
                hintText: "Search...",
                border: InputBorder.none,
                isDense: true,
              ),
            ),
          ),
        ],
      ),
    );
  }


  Widget _buildBannerCarousel(BuildContext context) {
    return SliverToBoxAdapter(
      child: Container(
        margin: const EdgeInsets.all(16),
        child: Column(
          children: [
            Container(
              height: width*0.4,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(width*0.02),
                child: PageView(
                  controller: _bannerController,
                  onPageChanged: (index) {
                    setState(() {
                      _currentBannerIndex = index;
                    });
                  },
                  children: [
                    _buildBannerItem(
                      context,
                      "Special Offer!",
                      "Up to 50% OFF on Electronics",
                      Colors.blue.shade600,
                      Icons.flash_on_rounded,
                    ),
                    _buildBannerItem(
                      context,
                      "New Arrivals",
                      "Fresh Fashion Collection",
                      Colors.purple.shade600,
                      Icons.style_rounded,
                    ),
                    _buildBannerItem(
                      context,
                      "Free Shipping",
                      "On orders above \$50",
                      Colors.green.shade600,
                      Icons.local_shipping_rounded,
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: width*0.03),
            // Banner Indicators
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                3,
                    (index) => Container(
                  width: width*0.02,
                  height: width*0.02,
                  margin: const EdgeInsets.symmetric(horizontal: 4),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: _currentBannerIndex == index
                        ? Colors.black87
                        : Colors.grey,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBannerItem(BuildContext context, String title, String subtitle, Color color, IconData icon) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [color, color.withOpacity(0.8)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Padding(
        padding:  EdgeInsets.all(width*0.03),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: width*0.03,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  SizedBox(height: width*0.01),
                  Text(
                    subtitle,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: width*0.04,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(height: width*0.01),
                  SizedBox(
                    height: width*0.06,
                    width: width*0.2,
                    child: ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        foregroundColor: color,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(width*0.03),
                        ),
                        padding:  EdgeInsets.symmetric(horizontal: width*0.02, vertical: width*0.01),
                      ),
                      child: Text(
                        "Shop Now",
                        style: TextStyle(fontWeight: FontWeight.w600,fontSize: width*0.03),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Icon(
              icon,
              size: width*0.02,
              color: Colors.white.withOpacity(0.3),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCategoryFilter(BuildContext context) {
    return SliverToBoxAdapter(
      child: Obx(() {
        // Extract unique categories from products
        final categories = ['All', ...controller.products.map((p) => p.category.toString()).toSet()];

        return Container(
          margin: EdgeInsets.symmetric(horizontal: width*0.03, vertical: width*0.02),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 8),
                child: Text(
                  "Categories",
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.w700,
                    fontSize: width*0.03
                  ),
                ),
              ),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: categories.map((category) {
                    final isSelected = selectedCategory == category;
                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          selectedCategory = category;
                        });
                      },
                      child: Container(
                        margin: const EdgeInsets.only(right: 12),
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                        decoration: BoxDecoration(
                          color: isSelected
                              ? ColorConst.primaryColor
                              : Colors.grey.shade200,
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(
                            color: isSelected
                                ? ColorConst.primaryColor
                                : Colors.grey.shade300,
                          ),
                        ),
                        child: Text(
                          category.toString().capitalizeFirst ?? category,
                          style: TextStyle(
                            color: isSelected
                                ? Colors.white
                                : ColorConst.black,
                            fontWeight: FontWeight.w600,
                            fontSize: width*0.03,
                          ),
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ),
            ],
          ),
        );
      }),
    );
  }

  Widget _buildProductGrid(BuildContext context) {
    return Obx(() {
      if (controller.isLoading.value) {
        return SliverFillRemaining(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircularProgressIndicator(
                  color: Theme.of(context).colorScheme.primary,
                  strokeWidth: 3,
                ),
                const SizedBox(height: 16),
                Text(
                  "Loading amazing products...",
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.onSurface.withOpacity(0.6),
                    fontSize: width*0.03,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
        );
      }

      if (controller.errorMessage.isNotEmpty) {
        return SliverFillRemaining(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  padding: const EdgeInsets.all(24),
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.errorContainer.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Icon(
                    Icons.error_outline_rounded,
                    size: 48,
                    color: Theme.of(context).colorScheme.error,
                  ),
                ),
                const SizedBox(height: 16),
                Text(
                  "Oops! Something went wrong",
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  controller.errorMessage.value,
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.onSurface.withOpacity(0.6),
                    fontSize: 14,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 24),
                ElevatedButton.icon(
                  onPressed: () => controller.loadProducts(),
                  icon: const Icon(Icons.refresh_rounded),
                  label: const Text("Try Again"),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Theme.of(context).colorScheme.primary,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                  ),
                ),
              ],
            ),
          ),
        );
      }

      // Filter products based on selected category
      final filteredProducts = selectedCategory == 'All'
          ? controller.products
          : controller.products.where((product) => product.category.toString() == selectedCategory).toList();

      if (filteredProducts.isEmpty) {
        return SliverFillRemaining(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  padding: const EdgeInsets.all(24),
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.surfaceVariant.withOpacity(0.3),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Icon(
                    Icons.shopping_bag_outlined,
                    size: 48,
                    color: Theme.of(context).colorScheme.onSurface.withOpacity(0.5),
                  ),
                ),
                const SizedBox(height: 16),
                Text(
                  "No Products Found",
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  selectedCategory == 'All'
                      ? "We couldn't find any products at the moment.\nTry refreshing or check back later."
                      : "No products found in '$selectedCategory' category.\nTry selecting a different category.",
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.onSurface.withOpacity(0.6),
                    fontSize: 14,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 24),
                ElevatedButton.icon(
                  onPressed: selectedCategory == 'All'
                      ? () => controller.loadProducts()
                      : () => setState(() => selectedCategory = 'All'),
                  icon: Icon(selectedCategory == 'All' ? Icons.refresh_rounded : Icons.clear_all_rounded),
                  label: Text(selectedCategory == 'All' ? "Refresh" : "Show All"),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Theme.of(context).colorScheme.primary,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                  ),
                ),
              ],
            ),
          ),
        );
      }

      return SliverPadding(
        padding: const EdgeInsets.all(16),
        sliver: SliverGrid(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 16,
            mainAxisSpacing: 16,
            childAspectRatio: 0.75,
          ),
          delegate: SliverChildBuilderDelegate(
                (context, index) {
              final product = filteredProducts[index];
              return _buildProductCard(context, product, index);
            },
            childCount: filteredProducts.length,
          ),
        ),
      );
    }
    );
  }

  Widget _buildProductCard(BuildContext context, dynamic product, int index) {
    return GestureDetector(
      onTap: () {
        Get.to(
              () => ProductDetailsScreen(productId: product.id),
          transition: Transition.fadeIn,
          duration: const Duration(milliseconds: 300),
        );
      },
      child: Hero(
        tag: "product_${product.id}",
        child: Container(
          decoration: BoxDecoration(
            color: ColorConst.white,
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.08),
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
            ],
            border: Border.all(
              color: Theme.of(context).colorScheme.outline.withOpacity(0.1),
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Product Image
              Expanded(
                flex: 3,
                child: Container(
                  width: double.infinity,
                  margin: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    color: ColorConst.black.withOpacity(0.1),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(width*0.02),
                    child: Stack(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Image.network(
                            product.image,
                            width: width*0.2,
                            height: width*0.2,
                            fit: BoxFit.fill,
                            loadingBuilder: (context, child, loadingProgress) {
                              if (loadingProgress == null) return child;
                              return Center(
                                child: CircularProgressIndicator(
                                  strokeWidth: 2,
                                  color: ColorConst.primaryColor,
                                ),
                              );
                            },
                            errorBuilder: (context, error, stackTrace) {
                              return Container(
                                color: ColorConst.black.withOpacity(0.5),
                                child: Icon(
                                  Icons.image_not_supported_rounded,
                                  color: ColorConst.black.withOpacity(0.3),
                                  size: 32,
                                ),
                              );
                            },
                          ),
                        ),
                        // Favorite Button
                        Positioned(
                          top: 8,
                          right: 8,
                          child: Container(
                            padding: const EdgeInsets.all(6),
                            decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.9),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Icon(
                              Icons.favorite_border_rounded,
                              size: 16,
                              color: ColorConst.black.withOpacity(0.6),
                            ),
                          ),
                        ),
                        // Category Badge
                        Positioned(
                          bottom: 8,
                          left: 8,
                          child: Container(
                            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                            decoration: BoxDecoration(
                              color: ColorConst.primaryColor.withOpacity(0.9),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Text(
                              product.category.toString().capitalizeFirst ?? '',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: width*0.024,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),

              // Product Info
              Expanded(
                flex: 2,
                child: Padding(
                  padding:  EdgeInsets.all(width*0.03),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Product Title
                      Text(
                        product.title,
                        style: TextStyle(
                          fontSize: width*0.03,
                          fontWeight: FontWeight.w600,
                          color: ColorConst.black,
                          height: 1.2,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      SizedBox(height: width*0.01),

                      // Rating
                      Row(
                        children: [
                          Icon(
                            Icons.star_rounded,
                            size: width*0.03,
                            color: Colors.amber,
                          ),
                          SizedBox(width: width*0.01),
                          Text(
                            product.rate.toString(),
                            style: TextStyle(
                              fontSize: width*0.025,
                              color: ColorConst.black.withOpacity(0.6),
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          SizedBox(width: width*0.01),
                          Text(
                            "(${product.count})",
                            style: TextStyle(
                              fontSize: width*0.025,
                              color: ColorConst.black.withOpacity(0.4),
                            ),
                          ),
                        ],
                      ),

                      SizedBox(width: width*0.03),

                      // Price
                      Row(
                        children: [
                          Text(
                            "\$${product.price}",
                            style: TextStyle(
                              fontSize: width*0.033,
                              fontWeight: FontWeight.w700,
                              color: ColorConst.primaryColor,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}