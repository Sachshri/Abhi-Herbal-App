import 'package:new_flutter_app/features/shop/models/banner_model.dart';
import 'package:new_flutter_app/features/shop/models/brand_model.dart';
import 'package:new_flutter_app/features/shop/models/category_model.dart';
import 'package:new_flutter_app/features/shop/models/product_attribute_model.dart';
import 'package:new_flutter_app/features/shop/models/product_model.dart';
import 'package:new_flutter_app/features/shop/models/product_variation_model.dart';
import 'package:new_flutter_app/utils/constants/image_strings.dart';
import 'package:new_flutter_app/routes/routes.dart';
import 'package:new_flutter_app/utils/data/article_data.dart';

class CustomDummyData {
  CustomDummyData._();
  //Banners
  static final List<BannerModel> banners = [
    BannerModel(
      imageUrl: ImageStringsConstants.banner1,
      targetScreen: CustomRoutes.search,
      active: false,
    ),
    // BannerModel(
    //   imageUrl: ImageStringsConstants.banner1,
    //   targetScreen: CustomRoutes.userAddress,
    //   active: false,
    // ),
    // BannerModel(
    //   imageUrl: ImageStringsConstants.banner2,
    //   targetScreen: CustomRoutes.favourites,
    //   active: false,
    // ),
    BannerModel(
      imageUrl: ImageStringsConstants.banner2,
      targetScreen: CustomRoutes.search,
      active: false,
    ),
    // BannerModel(
    //   imageUrl: ImageStringsConstants.banner2,
    //   targetScreen: CustomRoutes.settings,
    //   active: false,
    // ),
    BannerModel(
      imageUrl: ImageStringsConstants.banner3,
      targetScreen: CustomRoutes.search,
      active: false,
    ),
    // BannerModel(
    //   imageUrl: ImageStringsConstants.banner3,
    //   targetScreen: CustomRoutes.checkout,
    //   active: false,
    // ),
  ];

  //Categories
  static List<CategoryModel> categories = [
    CategoryModel(
      name: "Herbs",
      isFeatured: true,
      image: ImageStringsConstants.banner2,
      id: "1",
    ),
    CategoryModel(
      name: "Healthy Stomach",
      isFeatured: true,
      image: ImageStringsConstants.banner1,
      id: "2",
    ),
    CategoryModel(
      name: "Glowing Face",
      isFeatured: true,
      image: ImageStringsConstants.banner3,
      id: "3",
    ),
    // CategoryModel(
    //   name: "Energy Drinks",
    //   isFeatured: true,
    //   image: ImageStringsConstants.logo,
    //   id: "2",
    // ),
    // CategoryModel(
    //   name: "Mind Freshers",
    //   isFeatured: true,
    //   image: ImageStringsConstants.logo,
    //   id: "3",
    // ),

    // //Sub Categories
    CategoryModel(
      name: "Ginseng",
      isFeatured: false,
      image: ImageStringsConstants.logo,
      id: "5",
      parentId: '1',
    ),
    CategoryModel(
      name: "Guarana",
      isFeatured: false,
      image: ImageStringsConstants.logo,
      id: "7",
      parentId: '1',
    ),
    // CategoryModel(
    //   name: "Salvia",
    //   isFeatured: false,
    //   image: ImageStringsConstants.logo,
    //   id: "8",
    //   parentId: '2',
    // ),
    // //Clean Face
    // CategoryModel(
    //   name: "Alovera Juice",
    //   isFeatured: false,
    //   image: ImageStringsConstants.logo,
    //   id: "9",
    //   parentId: '4',
    // ),
    // CategoryModel(
    //   name: "Mosambi Juice",
    //   isFeatured: false,
    //   image: ImageStringsConstants.logo,
    //   id: "11",
    //   parentId: '4',
    // ),
    // CategoryModel(
    //   name: "Cucumber Juice",
    //   isFeatured: false,
    //   image: ImageStringsConstants.logo,
    //   id: "10",
    //   parentId: '4',
    // ),

  ];

  // List of product model
  static final List<ProductModel> products = [
    ProductModel(
      id: '002',
      title: "Green Herbs",
      stock: 15,
      price: 30,
      isFeatured: true,
      thumbnail: ImageStringsConstants.productImage,
      description: " This is description",
      brand: BrandModel(
        id: '1',
        image: ImageStringsConstants.primaryImage,
        name: 'Herbs',
        productsCount: 44,
        isFeatured: true,
      ),
      images: [ImageStringsConstants.productImage],
      salePrice: 30,
      sku: '',
      categoryId: '1',
      productAttributes: [
        ProductAttributeModel(
          name: "Size",
          values: ['Large', 'Medium', 'Small'],
        ),
      ],

      productVariations: [
        ProductVariationModel(id: '1', attributeValues:{'Size': "Large"},stock: 34,price: 30,salePrice: 20,image: ImageStringsConstants.productImage,description: "THis is product Description for llarge one",),
        ProductVariationModel(id: '1', attributeValues:{'Size': "Small"},stock: 34,price: 30,salePrice: 20,image: ImageStringsConstants.productImage,description: "THis is product Description for llarge one",),
        ProductVariationModel(id: '1', attributeValues:{'Size': "Medium"},stock: 34,price: 30,salePrice: 20,image: ImageStringsConstants.productImage,description: "THis is product Description for llarge one",),
      ],
      productType: "ProductType.variable",
    ),
    ProductModel(
      id: '002',
      title: "Green Herbs",
      stock: 15,
      price: 30,
      isFeatured: true,
      thumbnail: ImageStringsConstants.productImage,
      description: " This is description",
      brand: BrandModel(
        id: '1',
        image: ImageStringsConstants.primaryImage,
        name: 'Herbs',
        productsCount: 44,
        isFeatured: true,
      ),
      images: [ImageStringsConstants.productImage],
      salePrice: 30,
      sku: '',
      categoryId: '1',
      productAttributes: [
        ProductAttributeModel(
          name: "Size",
          values: ['Large', 'Medium', 'Small'],
        ),
      ],

      productVariations: [
        ProductVariationModel(id: '1', attributeValues:{'Size': "Large"},stock: 34,price: 30,salePrice: 20,image: ImageStringsConstants.productImage,description: "THis is product Description for llarge one",),
        ProductVariationModel(id: '3', attributeValues:{'Size': "Small"},stock: 34,price: 30,salePrice: 20,image: ImageStringsConstants.productImage,description: "THis is product Description for llarge one",),
        ProductVariationModel(id: '2', attributeValues:{'Size': "Medium"},stock: 34,price: 30,salePrice: 20,image: ImageStringsConstants.productImage,description: "THis is product Description for llarge one",),
      ],
      productType: "ProductType.variable",
    ),
  ];
  static List<ArticleCategoryData> articleCategoryList = [
  ArticleCategoryData(
    title: 'Ayurvedic Herbs',
    description: 'Discover the power of nature with detailed insights into traditional Ayurvedic herbs, their benefits, usage, and healing properties.',
    imageUrl: 'assets/article_assets/ayurvedic_herbs.png',
  ),
  ArticleCategoryData(
    title: 'All Disease',
    description: 'Explore comprehensive information on various diseases, their Ayurvedic causes, symptoms, and holistic treatment approaches.',
    imageUrl: 'assets/article_assets/diseases.png',
  ),
  ArticleCategoryData(
    title: 'Beauty Tips',
    description: 'Get natural and effective beauty tips rooted in Ayurveda to enhance skin, hair, and overall appearance without harmful chemicals.',
    imageUrl: 'assets/article_assets/beauty-treatment.png',
  ),
  ArticleCategoryData(
    title: 'Child Care',
    description: 'Learn safe, natural, and age-appropriate Ayurvedic methods for promoting the healthy growth and immunity of children.',
    imageUrl: 'assets/article_assets/child_care.png',
  ),
  ArticleCategoryData(
    title: 'Improving Memory',
    description: 'Discover Ayurvedic practices and herbs that enhance brain function, improve memory, and support mental clarity.',
    imageUrl: 'assets/article_assets/memory.png',
  ),
  ArticleCategoryData(
    title: 'Infertility',
    description: 'Understand the Ayurvedic perspective on infertility, its root causes, and natural remedies to support reproductive health.',
    imageUrl: 'assets/article_assets/infertility.png',
  ),
  ArticleCategoryData(
    title: 'Pain Disease',
    description: 'Manage chronic and acute pain naturally through Ayurvedic treatments, herbal oils, and therapeutic practices.',
    imageUrl: 'assets/article_assets/pain_relief.png',
  ),
  ArticleCategoryData(
    title: 'Sexual Weakness',
    description: 'Learn about Ayurvedic remedies and tonics that help overcome sexual weakness and boost vitality and confidence.',
    imageUrl: 'assets/article_assets/sexual_weakness.png',
  ),
  ArticleCategoryData(
    title: 'Skin Care',
    description: 'Achieve glowing, healthy skin with Ayurvedic skincare routines, natural remedies, and lifestyle tips.',
    imageUrl: 'assets/article_assets/skincare.png',
  ),
  ArticleCategoryData(
    title: 'Vitamin Problems',
    description: 'Understand vitamin deficiencies and how Ayurvedic nutrition and herbs can restore balance and vitality.',
    imageUrl: 'assets/article_assets/vitamin-problem.png',
  ),
  ArticleCategoryData(
    title: 'Weight Gain',
    description: 'Explore Ayurvedic methods, diets, and tonics designed to promote healthy and sustainable weight gain.',
    imageUrl: 'assets/article_assets/gain-weight.png',
  ),
  ArticleCategoryData(
    title: 'Weight Loss',
    description: 'Discover Ayurvedic detox, diet plans, and herbal support to lose weight naturally and effectively.',
    imageUrl: 'assets/article_assets/slim.png',
  ),
];
}
