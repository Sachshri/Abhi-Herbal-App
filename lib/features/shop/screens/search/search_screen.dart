import 'package:flutter/material.dart';
import 'package:new_flutter_app/common/widgets/custom_widgets/app_bar/custom_app_bar.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title:  const Text('Search'),
        showBackArrow: true,
      ),
      body:  Center(
        child: Text(
          'Search Functionality is Not available yet',
          style: Theme.of(context).textTheme.headlineSmall,
        ),
      ),
    );
  }
}