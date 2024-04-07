import 'package:cached_network_image/cached_network_image.dart';
import 'package:eduflex/utils/constant/sizes.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class StudentInformationScreen extends StatefulWidget {
  const StudentInformationScreen({
    super.key,
    required this.data,
  });

  final Map<String, dynamic> data;

  @override
  State<StudentInformationScreen> createState() =>
      _StudentInformationScreenState();
}

class _StudentInformationScreenState extends State<StudentInformationScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text(
          'Information',
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(TSize.defaultSpace),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(100),
                  child: CachedNetworkImage(
                    height: 120,
                    fit: BoxFit.cover,
                    width: 120,
                    imageUrl: widget.data['image'],
                    errorWidget: (context, url, error) => const CircleAvatar(
                      child: Icon(Iconsax.people),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: TSize.spaceBtwItems / 2,
              ),
              const Divider(),
              const SizedBox(
                height: TSize.spaceBtwItems,
              ),
              Text(
                'Profile Information',
                style: Theme.of(context).textTheme.headlineSmall,
              ),
              const SizedBox(
                height: TSize.spaceBtwItems,
              ),
              LabelWithValue(
                labelName: 'Name',
                value: "${widget.data['firstName']} ${widget.data['lastName']}",
              ),
              const SizedBox(
                height: TSize.spaceBtwItems,
              ),
              LabelWithValue(
                labelName: 'Username',
                value: "${widget.data['userName']}",
              ),
              const SizedBox(
                height: TSize.spaceBtwItems,
              ),
              const Divider(),
              const SizedBox(
                height: TSize.spaceBtwItems,
              ),
              Text(
                'Profile Information',
                style: Theme.of(context).textTheme.headlineSmall,
              ),
              const SizedBox(
                height: TSize.spaceBtwItems,
              ),
              LabelWithValue(
                labelName: 'User ID',
                value: "${widget.data['id']}",
              ),
              const SizedBox(
                height: TSize.spaceBtwItems,
              ),
              LabelWithValue(
                labelName: 'E-mail',
                value: "${widget.data['email']}",
              ),
              const SizedBox(
                height: TSize.spaceBtwItems,
              ),
              LabelWithValue(
                labelName: 'Phone Number',
                value: "${widget.data['phoneNumber']}",
              ),
              const SizedBox(
                height: TSize.spaceBtwItems,
              ),
              LabelWithValue(
                labelName: 'Field',
                value: "${widget.data['fieldValue']}",
              ),
              const SizedBox(
                height: TSize.spaceBtwItems,
              ),
              LabelWithValue(
                labelName: 'Year',
                value: "${widget.data['yearValue']}",
              ),
              const SizedBox(
                height: TSize.spaceBtwItems,
              ),
              LabelWithValue(
                labelName: 'Divison',
                value: "${widget.data['div']}",
              ),
              const SizedBox(
                height: TSize.spaceBtwItems,
              ),
              LabelWithValue(
                labelName: 'Roll No',
                value: "${widget.data['rollNo']}",
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class LabelWithValue extends StatelessWidget {
  const LabelWithValue({
    super.key,
    required this.labelName,
    required this.value,
  });

  final String labelName;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Text(
            labelName,
            style: Theme.of(context).textTheme.titleLarge,
            overflow: TextOverflow.ellipsis,
          ),
        ),
        Expanded(
          child: Text(
            value,
            style: const TextStyle(
              fontSize: 16,
              color: Colors.black87,
            ),
            // style: Theme.of(context).textTheme.bodyMedium,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }
}
