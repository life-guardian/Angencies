// ignore_for_file: prefer_typing_uninitialized_variables, use_build_context_synchronously
import 'package:agencies_app/models/registered_users.dart';
import 'package:agencies_app/widgets/custom_images/no_data_found.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class BuildRegisteredUsersListView extends StatelessWidget {
  const BuildRegisteredUsersListView({
    super.key,
    required this.registeredUsersList,
  });

  final List<RegisteredUsers> registeredUsersList;

  @override
  Widget build(BuildContext context) {
    return registeredUsersList.isEmpty
        ? const NoDataFoundImage(
            headingText: "No Registered Users Found!",
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
                            Text(
                              registeredUser.userName.toString(),
                              style: GoogleFonts.plusJakartaSans().copyWith(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                            const SizedBox(
                              height: 11,
                            ),
                            Text(
                              'Phone: ${registeredUser.phoneNumber.toString()}',
                              style: GoogleFonts.plusJakartaSans().copyWith(
                                color: Colors.grey,
                                fontSize: 12,
                                overflow: TextOverflow.ellipsis,
                              ),
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
