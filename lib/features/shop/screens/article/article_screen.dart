import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:new_flutter_app/common/widgets/custom_shapes/containers/custom_rounded_container.dart';
import 'package:new_flutter_app/common/widgets/image_widgets/custom_rounded_image.dart';
import 'package:new_flutter_app/common/widgets/layouts/grid_layout.dart';
import 'package:new_flutter_app/features/shop/controllers/article_controller.dart';
import 'package:new_flutter_app/features/shop/screens/article/category_article_screen.dart';
import 'package:new_flutter_app/utils/constants/color_constants.dart';
import 'package:new_flutter_app/utils/constants/sizes_constants.dart';
import 'package:new_flutter_app/utils/data/dummy_data.dart';

class ArticleScreen extends StatelessWidget {
  const ArticleScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final dark = Theme.of(context).brightness == Brightness.dark;
    final controller = Get.put(ArticleController());
    return Scaffold(
      appBar: AppBar(title: const Text('Articles')),
      body: SingleChildScrollView(
        child: Container(
          margin: const EdgeInsets.all(16),
          child: CustomGridLayout(itemCount: CustomDummyData.articleCategoryList.length, itemBuilder: (_,index){
          final articleCategory = CustomDummyData.articleCategoryList[index];
             return GestureDetector(
              onTap: (){
                // Navigate to the category article screen
                controller.fetchCategoryArticles(articleCategory.title);
                Get.to(()=>CategoryArticleScreen(articleCategory: articleCategory));},
               child: Card(
                           child: Column(
                children: [
                  CustomRoundedContainer(
                  height: 180,
                  width: 180,
                  padding: const EdgeInsets.all(SizeConstants.sm),
                  backgroundColor:
                      dark
                          ? ColorConstants.dark
                          : const Color.fromARGB(144, 188, 186, 186),
                  child: Center(
                    child: CustomRoundedImage(
                      imageUrl: articleCategory.imageUrl,
                      isApplyImageRadius: true,
                      isNetworkImage: false,
                    ),
                  ))
                      ,
                  const SizedBox(height: 8),
                  Text(articleCategory.title,
                      style: Theme.of(context).textTheme.titleMedium),
                  const SizedBox(height: 4),
                  Container(
                    margin: const EdgeInsets.all(8.0),
                    child: Text(articleCategory.description,style: Theme.of(context).textTheme.bodyMedium,maxLines: 2,overflow: TextOverflow.ellipsis,),
                  )
                ],
                           ),
                         ),
             );}
        ),
            ),
      ));
  }
}
