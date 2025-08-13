import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pokak/core/color_constant.dart';
import 'package:pokak/main.dart';

import '../controller/product_controlelr.dart';

class ProductDetailsScreen extends StatefulWidget {
  final int productId;
  const ProductDetailsScreen({super.key, required this.productId});

  @override
  _ProductDetailsScreenState createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends State<ProductDetailsScreen>
    with TickerProviderStateMixin {
  final ProductController controller = Get.find<ProductController>();
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;
  int _selectedImageIndex = 0;
  int _quantity = 1;
  bool _isFavorite = false;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );
    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
    );

    // Delay API call until after widget is built
    Future.microtask(() {
      controller.loadProductDetails(widget.productId);
      _animationController.forward();
    });
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorConst.white,
      body: Obx(() {
        if (controller.isLoading.value) {
          return _buildLoadingState();
        }

        if (controller.errorMessage.isNotEmpty) {
          return _buildErrorState();
        }

        final product = controller.selectedProduct.value;
        if (product == null) {
          return _buildNotFoundState();
        }

        return FadeTransition(
          opacity: _fadeAnimation,
          child: CustomScrollView(
            slivers: [
              _buildAppBar(context, product),
              SliverToBoxAdapter(
                child: Column(
                  children: [
                    _buildImageSection(context, product),
                    _buildProductInfo(context, product),
                    _buildDescription(context, product),
                    _buildBottomSection(context),
                  ],
                ),
              ),
            ],
          ),
        );
      }),
    );
  }

  Widget _buildAppBar(BuildContext context, dynamic product) {
    return SliverAppBar(
      expandedHeight: 60,
      floating: true,
      pinned: true,
      elevation: 0,
      backgroundColor: Colors.white,
      surfaceTintColor: ColorConst.white,
      foregroundColor: ColorConst.black,
      leading: Container(
        margin: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: ColorConst.black.withOpacity(0.1),
          borderRadius: BorderRadius.circular(12),
        ),
        child: IconButton(
          icon: Icon(Icons.arrow_back_ios_rounded, size: 20),
          onPressed: () => Get.back(),
        ),
      ),
      actions: [
        Container(
          margin: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: ColorConst.highliteShimmerDark.withOpacity(0.1),
            borderRadius: BorderRadius.circular(12),
          ),
          child: IconButton(
            icon: Icon(
              _isFavorite ? Icons.favorite_rounded : Icons.favorite_border_rounded,
              color: _isFavorite ? Colors.red : null,
              size: 20,
            ),
            onPressed: () {
              setState(() {
                _isFavorite = !_isFavorite;
              });
            },
          ),
        ),
        Container(
          margin: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color:  ColorConst.highliteShimmerDark.withOpacity(0.1),
            borderRadius: BorderRadius.circular(12),
          ),
          child: IconButton(
            icon: Icon(Icons.share_rounded, size: 20),
            onPressed: () {
              // Add share functionality
            },
          ),
        ),
        const SizedBox(width: 8),
      ],
    );
  }

  Widget _buildImageSection(BuildContext context, dynamic product) {
    return Container(
      height: width*0.7,
      width: double.infinity,
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: ColorConst.white.withOpacity(0.3),
        borderRadius: BorderRadius.circular(24),
      ),
      child: Stack(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(24),
            child: Hero(
              tag: "product_${product.id}",
              child: Image.network(
                product.image,
                width: double.infinity,
                height: double.infinity,
                fit: BoxFit.contain,
                loadingBuilder: (context, child, loadingProgress) {
                  if (loadingProgress == null) return child;
                  return Center(
                    child: CircularProgressIndicator(
                      strokeWidth: 3,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                  );
                },
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    color: Theme.of(context).colorScheme.surfaceVariant.withOpacity(0.5),
                    child: Icon(
                      Icons.image_not_supported_rounded,
                      color: Theme.of(context).colorScheme.onSurface.withOpacity(0.3),
                      size: 64,
                    ),
                  );
                },
              ),
            ),
          ),
          // Zoom indicator
          Positioned(
            bottom: 16,
            right: 16,
            child: Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.6),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(
                Icons.zoom_in_rounded,
                color: Colors.white,
                size: 16,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProductInfo(BuildContext context, dynamic product) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: ColorConst.highliteShimmerDark.withOpacity(0.0),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Category Badge
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: ColorConst.primaryColor.withOpacity(0.1),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text(
              product.category.toString().toUpperCase(),
              style: TextStyle(
                fontSize: width*0.035,
                fontWeight: FontWeight.w600,
                color: ColorConst.primaryColor,
                letterSpacing: 0.5,
              ),
            ),
          ),
          SizedBox(height: width*0.03),

          // Product Title
          Text(
            product.title,
            style:TextStyle(
              fontWeight: FontWeight.w700,
              fontSize: width*0.065,
              height: 1.2,
            ),
          ),
          SizedBox(height: width*0.03),

          // Rating Row
          Row(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: Colors.amber.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.star_rounded, color: Colors.amber, size: 16),
                    const SizedBox(width: 4),
                    Text(
                      product.rate.toString(),
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: width*0.04,
                        color: Colors.amber[700],
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(width: width*0.03),
              Text(
                "(${product.count} reviews)",
                style: TextStyle(
                  color: ColorConst.black.withOpacity(0.6),
                  fontSize: width*0.04,
                ),
              ),
              const Spacer(),
              Icon(
                Icons.local_shipping_outlined,
                size: width*0.045,
                color: ColorConst.primaryColor,
              ),
              const SizedBox(width: 4),
              Text(
                "Free Delivery",
                style: TextStyle(
                  color: ColorConst.primaryColor,
                  fontSize: width*0.035,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
          SizedBox(height: width*0.04),

          // Price Row
          Row(
            children: [
              Text(
                "\$${product.price}",
                style: TextStyle(
                  fontWeight: FontWeight.w800,
                  fontSize: width*0.06,
                  color:ColorConst.primaryColor,
                ),
              ),
              SizedBox(width: width*0.02),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: Colors.green.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Text(
                  "20% OFF",
                  style: TextStyle(
                    fontSize: width*0.03,
                    fontWeight: FontWeight.w600,
                    color: Colors.green[700],
                  ),
                ),
              ),
              const Spacer(),
              _buildQuantitySelector(context),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildQuantitySelector(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: ColorConst.highliteShimmerDark.withOpacity(0.0),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          IconButton(
            onPressed: _quantity > 1 ? () => setState(() => _quantity--) : null,
            icon: Icon(Icons.remove_rounded, size: 18),
            constraints: const BoxConstraints(minWidth: 36, minHeight: 36),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: Text(
              _quantity.toString(),
              style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 16,
              ),
            ),
          ),
          IconButton(
            onPressed: () => setState(() => _quantity++),
            icon: Icon(Icons.add_rounded, size: 18),
            constraints: const BoxConstraints(minWidth: 36, minHeight: 36),
          ),
        ],
      ),
    );
  }

  Widget _buildDescription(BuildContext context, dynamic product) {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.symmetric(horizontal: width*0.05),
      padding:  EdgeInsets.all(width*0.05),
      decoration: BoxDecoration(
        color: ColorConst.highliteShimmerDark.withOpacity(0.0),
        borderRadius: BorderRadius.circular(width*0.03),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Description",
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
              fontWeight: FontWeight.w700,
            ),
          ),
          SizedBox(height: width*0.03),
          Text(
            product.description,
            style: TextStyle(
              height: 1.6,
              fontSize: width*0.04,
              color: ColorConst.black.withOpacity(0.8),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBottomSection(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      child: Row(
        children: [
          Expanded(
            child: OutlinedButton.icon(
              onPressed: () {
                _showAddedToCartSnackbar();
              },
              icon: Icon(Icons.shopping_cart_outlined,color: ColorConst.primaryColor,),
              label: Text("Add to Cart",style: TextStyle(
                color: ColorConst.primaryColor,
                fontSize: width*0.03
              ),),
              style: OutlinedButton.styleFrom(
                padding: EdgeInsets.symmetric(vertical: width*0.02),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                side: BorderSide(
                  color: ColorConst.primaryColor,
                  width: 2,
                ),
              ),
            ),
          ),
          SizedBox(width: width*0.02),
          Expanded(
            child: ElevatedButton.icon(
              onPressed: () {
                // Buy now functionality
                _showBuyNowDialog();
              },
              icon: Icon(Icons.flash_on_rounded,color: ColorConst.white,),
              label: Text("Buy Now",style: TextStyle(
                fontSize: width*0.03,
              ),),
              style: ElevatedButton.styleFrom(
                backgroundColor: ColorConst.primaryColor,
                foregroundColor: Colors.white,
                padding: EdgeInsets.symmetric(vertical: width*0.02),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                elevation: 0,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLoadingState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircularProgressIndicator(
            color: ColorConst.primaryColor,
            strokeWidth: 3,
          ),
          const SizedBox(height: 16),
          Text(
            "Loading product details...",
            style: TextStyle(
              color: ColorConst.black.withOpacity(0.6),
              fontSize: width*0.03,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildErrorState() {
    return Center(
      child: Padding(
        padding:  EdgeInsets.all(width*0.03),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: ColorConst.errorColor.withOpacity(0.1),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Icon(
                Icons.error_outline_rounded,
                size: 48,
                color: ColorConst.errorColor,
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
                color: ColorConst.black.withOpacity(0.6),
                fontSize: 14,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 24),
            ElevatedButton.icon(
              onPressed: () => controller.loadProductDetails(widget.productId),
              icon: const Icon(Icons.refresh_rounded),
              label: const Text("Try Again"),
              style: ElevatedButton.styleFrom(
                backgroundColor: ColorConst.primaryColor,
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

  Widget _buildNotFoundState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              color: ColorConst.black.withOpacity(0.3),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Icon(
              Icons.search_off_rounded,
              size: width*0.05,
              color: ColorConst.black.withOpacity(0.5),
            ),
          ),
          const SizedBox(height: 16),
          Text(
            "Product Not Found",
            style:TextStyle(
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            "The product you're looking for doesn't exist or has been removed.",
            style: TextStyle(
              color: ColorConst.black.withOpacity(0.6),
              fontSize: 14,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 24),
          ElevatedButton.icon(
            onPressed: () => Get.back(),
            icon: const Icon(Icons.arrow_back_rounded),
            label: const Text("Go Back"),
            style: ElevatedButton.styleFrom(
              backgroundColor: ColorConst.primaryColor,
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
            ),
          ),
        ],
      ),
    );
  }

  void _showAddedToCartSnackbar() {
    Get.snackbar(
      "Added to Cart",
      "Product has been added to your cart",
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Colors.green,
      colorText: Colors.white,
      duration: const Duration(seconds: 2),
      margin: const EdgeInsets.all(16),
      borderRadius: 12,
      icon: const Icon(Icons.check_circle, color: Colors.white),
    );
  }

  void _showBuyNowDialog() {
    Get.dialog(
      AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: Text("Proceed to Checkout"),
        content: Text("Ready to purchase this item?"),
        actions: [
          TextButton(
            onPressed: () => Get.back(),
            child: Text("Cancel"),
          ),
          ElevatedButton(
            onPressed: () {
              Get.back();
              Get.snackbar(
                "Order Placed",
                "Your order has been placed successfully!",
                snackPosition: SnackPosition.BOTTOM,
                backgroundColor: Theme.of(context).colorScheme.primary,
                colorText: Colors.white,
                duration: const Duration(seconds: 3),
                margin: const EdgeInsets.all(16),
                borderRadius: 12,
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Theme.of(context).colorScheme.primary,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            child: Text("Confirm", style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
  }
}