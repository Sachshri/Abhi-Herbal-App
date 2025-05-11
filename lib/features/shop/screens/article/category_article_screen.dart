import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:new_flutter_app/common/widgets/custom_widgets/app_bar/custom_app_bar.dart';
import 'package:new_flutter_app/common/widgets/image_widgets/custom_rounded_image.dart';
import 'package:new_flutter_app/features/shop/controllers/article_controller.dart';
import 'package:new_flutter_app/features/shop/screens/article/article_details_screen.dart';
import 'package:new_flutter_app/utils/constants/sizes_constants.dart';
import 'package:new_flutter_app/utils/data/article_data.dart';

class CategoryArticleScreen extends StatelessWidget {
  const CategoryArticleScreen({super.key, required this.articleCategory});
  final ArticleCategoryData articleCategory;

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ArticleController());
    return Scaffold(
      appBar: CustomAppBar(
        showBackArrow: true,
        title: Text(articleCategory.title),
      ),
      body: Padding(
        padding: const EdgeInsets.all(SizeConstants.defaultSpace),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomRoundedImage(
              height: 200,
              width: double.infinity,
              imageUrl: articleCategory.imageUrl,
              isNetworkImage: false,
            ),
            const SizedBox(height: 16),
            Text(
              articleCategory.description,
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            Obx(() {
              if (controller.isLoading.value) {
                return const Center(child: CircularProgressIndicator());
              }
              if (controller.categoryArticles.isEmpty) {
               return Container(
                margin: const EdgeInsets.only(top: 32),
                        
                 child: Text(
                   "Articles are not available but coming soon",
                   style: Theme.of(context).textTheme.bodyMedium,
                 ),
               );
              }
              return ListView.separated(
                separatorBuilder: (context, index) => const SizedBox(height: 16),
                padding: const EdgeInsets.only(top: 16),
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: controller.categoryArticles.length,
                itemBuilder: (context, index) {
                  final article = controller.categoryArticles[index];
                  return InkWell(
                    onTap: () => Get.to(() => ArticleDetailsScreen(article: article)),
                    child: Container(
                      padding: const EdgeInsets.all(SizeConstants.md),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(SizeConstants.md),
                        color: Theme.of(context).cardColor,
                      ),
                      child: ListTile(
                        title: Text(article.title,
                            style: Theme.of(context).textTheme.titleMedium),
                        subtitle: Text(
                          article.content,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: Theme.of(context).textTheme.bodySmall,
                        ),
                        leading: CustomRoundedImage(
                          imageUrl: article.thumbnailUrl,
                          isNetworkImage: true,
                        ),
                      ),
                    ),
                  );
                },
              );
            }),
          ],
        ),
      ),
    );
  }
}
