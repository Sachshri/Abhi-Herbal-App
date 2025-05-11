import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:new_flutter_app/common/widgets/custom_widgets/app_bar/custom_app_bar.dart';
import 'package:new_flutter_app/common/widgets/image_widgets/custom_rounded_image.dart';
import 'package:new_flutter_app/features/shop/models/article_model.dart';
import 'package:new_flutter_app/utils/constants/sizes_constants.dart';

class ArticleDetailsScreen extends StatelessWidget {
  const ArticleDetailsScreen({super.key, required this.article});
  final ArticleModel article;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: Text(article.title),
        showBackArrow: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(SizeConstants.defaultSpace),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Article Title
            Text(
              article.title,
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            const SizedBox(height: 16),
            // Article Thumbnail
            article.thumbnailUrl.isNotEmpty
                ? CustomRoundedImage(
                  imageUrl: article.thumbnailUrl,
                  width: double.infinity,
                  height: 200,
                  isNetworkImage: true,)
                : const SizedBox.shrink(),
            const SizedBox(height: 16),
            // Article Content
            Expanded(
              child: SingleChildScrollView(
                child: MarkdownBody(
                  data: article.content,
              ),
            ),
            )
          ],
        ),
      ),
    );
  }
}