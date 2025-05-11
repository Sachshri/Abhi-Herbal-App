import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:new_flutter_app/data/repositories/article/article_repository.dart';
import 'package:new_flutter_app/data/repositories/authentications/authentication_repository.dart';
import 'package:new_flutter_app/features/personalization/screens/upload_data/upload_data.dart';
import 'package:new_flutter_app/features/shop/models/article_model.dart';
import 'package:new_flutter_app/utils/constants/image_strings.dart';
import 'package:new_flutter_app/utils/helpers/network_manager.dart';
import 'package:new_flutter_app/utils/loaders/loaders.dart';
import 'package:new_flutter_app/utils/popups/full_screen_loader.dart';

class ArticleController extends GetxController {
  final formKey = GlobalKey<FormState>();

  final titleController = TextEditingController();
  final contentController = TextEditingController();

  var selectedCategory = ''.obs;
  var thumbnailUrl = ''.obs;
  final isLoading = false.obs;
  final categoryArticles = <ArticleModel>[].obs;
  final articleRepository = Get.put(ArticleRepository());
  final allArticles = <ArticleModel>[].obs;

  @override
  void onInit() {
    super.onInit();
    articleRepository.fetchCategoryArticles().then((articles) {
      allArticles.assignAll(articles);
    });
  }

  Future<void> fetchCategoryArticles(String category) async {
    try {
      isLoading.value = true;
      //Assign Product
      categoryArticles.assignAll(
        allArticles.where((article) => article.category == category).toList(),
      );
      isLoading.value = false;
      if (categoryArticles.isEmpty) {
        CustomLoaders.customToast(
          message: "No articles found in this category.",
        );
      }
    } catch (e) {
      CustomLoaders.errorSnackBar(
        title: "Something Went Wrong",
        message: e.toString(),
      );
    }
  }

  void insertMarkdown(String snippet) {
    final text = contentController.text;
    final selection = contentController.selection;

    final newText = text.replaceRange(selection.start, selection.end, snippet);

    contentController.text = newText;
    contentController.selection = TextSelection.collapsed(
      offset: selection.start + snippet.length,
    );
  }

  List<String> categories = [
    'Ayurvedic Herbs',
    'All Disease',
    'Beauty Tips',
    'Child Care',
    'Improving Memory',
    'Infertility',
    'Pain Disease',
    'Sexual Weakness',
    'Skin Care',
    'Vitamin Problems',
    'Weight Gain',
    'Weight Loss',
  ];

  var tabSelection = [true, false].obs;

  void selectCategory(String? value) {
    if (value != null) selectedCategory.value = value;
  }

  void changeTab(int index) {
    tabSelection.value = [index == 0, index == 1];
  }

  Future<void> uploadThumbnail() async {
    try {
      final image = await ImagePicker().pickImage(
        source: ImageSource.gallery,
        imageQuality: 70,
        maxHeight: 512,
        maxWidth: 512,
      );
      if (image != null) {
        final isConnected = await NetworkManager.instance.isConnected();
        if (!isConnected) {
          CustomLoaders.customToast(message: "Check your internet connection.");
          return;
        }

        final url = await ArticleRepository.uploadImage(
          image,
          "Users/Images/Articles",
          'abhi_herbal_upload',
        );

        thumbnailUrl.value = url;
        CustomLoaders.successSnackBar(
          title: "Uploaded",
          message: "Thumbnail uploaded successfully",
        );
      }
    } catch (e) {
      CustomLoaders.errorSnackBar(
        title: "Upload Failed",
        message: e.toString(),
      );
    }
  }

  Future<String?> uploadImageForContent() async {
    try {
      final image = await ImagePicker().pickImage(
        source: ImageSource.gallery,
        imageQuality: 70,
        maxHeight: 512,
        maxWidth: 512,
      );
      if (image != null) {
        final isConnected = await NetworkManager.instance.isConnected();
        if (!isConnected) {
          CustomLoaders.customToast(message: "Check your internet connection.");
          return null;
        }

        final url = await ArticleRepository.uploadImage(
          image,
          "Users/Images/Articles",
          'abhi_herbal_upload',
        );

        CustomLoaders.successSnackBar(
          title: "Image Added",
          message: "Image added successfully",
        );
        return url;
      }
    } catch (e) {
      CustomLoaders.errorSnackBar(
        title: "Upload Failed",
        message: e.toString(),
      );
    }
    return null;
  }

  Future<void> submitArticle() async {
    if (!formKey.currentState!.validate()) return;
    if (thumbnailUrl.isEmpty || selectedCategory.isEmpty) {
      CustomLoaders.customToast(message: "All fields are required.");
      return;
    }

    final article = ArticleModel(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      title: titleController.text,
      category: selectedCategory.value,
      thumbnailUrl: thumbnailUrl.value,
      content: contentController.text,
      createdAt: DateTime.now(),
    );

    try {
      CustomFullScreenLoader.openLoadingDialog(
        'Uploading article',
        ImageStringsConstants.loading,
      );

      // Validate user authentication
      final user = AuthenticationRepository.instance.authUser;
      if (user == null || user.uid.isEmpty) {
        CustomLoaders.errorSnackBar(
          title: 'Error',
          message: 'User not authenticated',
        );
        return;
      }
      await ArticleRepository.createArticle(article);
      CustomLoaders.successSnackBar(
        title: "Success",
        message: "Article Published",
      );
      CustomFullScreenLoader.closeLoadingDialog();
      Get.off(()=>UploadDataScreen()); 
    } catch (e) {
      CustomLoaders.errorSnackBar(title: "Error", message: e.toString());
      CustomFullScreenLoader.closeLoadingDialog();
    }
  }
}
