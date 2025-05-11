import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:new_flutter_app/common/widgets/custom_widgets/app_bar/custom_app_bar.dart';
import 'package:new_flutter_app/features/shop/controllers/article_controller.dart';
import 'package:new_flutter_app/utils/constants/sizes_constants.dart';

class WriteArticleScreen extends StatelessWidget {
  const WriteArticleScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ArticleController());

    return Scaffold(
      appBar: CustomAppBar(showBackArrow: true,title: const Text('Write Article')),
      body: Obx(() {
        return SingleChildScrollView(
          padding: const EdgeInsets.all(SizeConstants.defaultSpace),
          child: Form(
            key: controller.formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Title
                TextFormField(
                  controller: controller.titleController,
                  decoration: const InputDecoration(labelText: 'Title'),
                  validator: (value) =>
                      value!.isEmpty ? 'Title is required' : null,
                ),
                const SizedBox(height: 16),

                // Category
                CustomDropdown(
                  label: 'Category',
                  items: controller.categories,
                  value: controller.selectedCategory.value,
                  onChanged: controller.selectCategory,
                ),
                const SizedBox(height: 16),

                // Thumbnail Upload
                controller.thumbnailUrl.value.isEmpty
                    ? OutlinedButton.icon(
                        icon: const Icon(Icons.image),
                        style: OutlinedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                        ),
                        label: const Text('Upload Thumbnail'),
                        onPressed: controller.uploadThumbnail,
                      )
                    : Column(
                      children: [
                        Image.network(
                            controller.thumbnailUrl.value,
                            height: 150,
                          ),
                        TextButton(onPressed: controller.uploadThumbnail, child: Text("Change Thumbnail",)),
                      ],
                    ),
                const SizedBox(height: 16),

                // Markdown Editor / Preview Tabs
                ToggleButtons(
                  isSelected: controller.tabSelection,
                  onPressed: controller.changeTab,
                  children: const [
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      child: Text("Editor"),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      child: Text("Preview"),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                controller.tabSelection[0]
                    ? Column(
  crossAxisAlignment: CrossAxisAlignment.start,
  children: [
    Wrap(
      spacing: 8,
      runSpacing: 8,
      children: [
        CustomMarkdownButton(label: "H1", onTap: () => controller.insertMarkdown("# ")),
        CustomMarkdownButton(label: "H2", onTap: () => controller.insertMarkdown("## ")),
        CustomMarkdownButton(label: "H3", onTap: () => controller.insertMarkdown("### ")),
        CustomMarkdownButton(label: "H4", onTap: () => controller.insertMarkdown("#### ")),
        CustomMarkdownButton(label: "H5", onTap: () => controller.insertMarkdown("##### ")),
        CustomMarkdownButton(label: "H6", onTap: () => controller.insertMarkdown("####### ")),
        CustomMarkdownButton(label: "Bold", onTap: () => controller.insertMarkdown(" **bold** ")),
        CustomMarkdownButton(label: "Italic", onTap: () => controller.insertMarkdown(" _italic_ ")),
        CustomMarkdownButton(label: "Bullet", onTap: () => controller.insertMarkdown("- ")),
        CustomMarkdownButton(label: "Number", onTap: () => controller.insertMarkdown("1. ")),
        CustomMarkdownButton(label: "Line", onTap: () => controller.insertMarkdown("---")),
        CustomMarkdownButton(
          label: "Image",
          onTap: () async {
            final imageUrl = await controller.uploadImageForContent();
            if (imageUrl != null) {
              controller.insertMarkdown("![alt text]($imageUrl)");
            }
          },
        ),
      ],
    ),
    const SizedBox(height: 8),
    TextFormField(
      controller: controller.contentController,
      maxLines: 20,
      decoration: const InputDecoration(
        hintText: "Write content...",
        border: OutlineInputBorder(),
      ),
      validator: (value) => value!.isEmpty ? 'Content cannot be empty' : null,
    ),
  ],
)

                    : Container(
                        height: 300,
                        padding: const EdgeInsets.all(8.0),
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey),
                        ),
                        child: SingleChildScrollView(
                          child: MarkdownBody(
                            data: controller.contentController.text,
                          ),
                        ),
                      ),
                const SizedBox(height: 24),

                // Submit Button
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: controller.submitArticle,
                    child: const Text('Publish Article'),
                  ),
                ),
              ],
            ),
          ),
        );
      }),
    );
  }
}

class CustomDropdown extends StatelessWidget {
  final String label;
  final List<String> items;
  final String value;
  final void Function(String?) onChanged;

  const CustomDropdown({
    super.key,
    required this.label,
    required this.items,
    required this.value,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<String>(
      value: value.isEmpty ? null : value,
      decoration: InputDecoration(
        labelText: label,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
      ),
      items: items.map((category) {
        return DropdownMenuItem<String>(
          value: category,
          child: Text(category),
        );
      }).toList(),
      onChanged: onChanged,
      validator: (val) => val == null || val.isEmpty ? 'Please select a category' : null,
    );
  }
}
class CustomMarkdownButton extends StatelessWidget {
  final String label;
  final VoidCallback onTap;

  const CustomMarkdownButton(
    {super.key, 
    required this.label,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onTap,
      style: TextButton.styleFrom(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        textStyle: const TextStyle(fontSize: 14),
      ),
      child: Text(label),
    );
  }
}
