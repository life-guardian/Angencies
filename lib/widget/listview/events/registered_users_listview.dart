// ignore_for_file: prefer_typing_uninitialized_variables, use_build_context_synchronously
import 'package:agencies_app/model/registered_users.dart';
import 'package:agencies_app/widget/errors/search_error_image.dart';
import 'package:agencies_app/widget/text/text_widget.dart';
import 'package:flutter/material.dart';

class RegisteredUsersListView extends StatelessWidget {
  const RegisteredUsersListView({
    super.key,
    required this.registeredUsersList,
  });

  final List<RegisteredUsers> registeredUsersList;

  @override
  Widget build(BuildContext context) {
    return registeredUsersList.isEmpty
        ? const SearchErrorImage(
            headingText: "No Registered Users Yet!",
            imagePath: "assets/images/animated_images/nothingfound.png",
          )
        : ListView.builder(
            itemCount: registeredUsersList.length,
            itemBuilder: (context, index) {
              final registeredUser = registeredUsersList.elementAt(index);
              return Card(
                elevation: 3,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                color: Theme.of(context).colorScheme.secondary,
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 20,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CustomTextWidget(
                              text: registeredUser.userName.toString(),
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                            const SizedBox(
                              height: 11,
                            ),
                            CustomTextWidget(
                              text:
                                  'Phone: ${registeredUser.phoneNumber.toString()}',
                              color: Colors.grey,
                              fontSize: 12,
                              textOverflow: TextOverflow.ellipsis,
                              maxLines: 1,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
  }
}
