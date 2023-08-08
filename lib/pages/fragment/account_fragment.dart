import 'dart:convert';
import 'dart:typed_data';

import 'package:d_info/d_info.dart';
import 'package:d_view/d_view.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:image_picker/image_picker.dart';
import '../../config/api.dart';
import '../../config/app_format.dart';
import '../../config/app_route.dart';
import '../../config/session.dart';
import '../../controllers/c_account.dart';
import '../../controllers/c_home.dart';
import '../../controllers/c_user.dart';
import '../../models/user.dart';
import '../../sources/user_source.dart';

class AccountFragment extends StatelessWidget {
  const AccountFragment({super.key});

  logout(BuildContext context) {
    DInfo.dialogConfirmation(
      context,
      'Logout',
      'tap yes to logout',
    ).then((yes) {
      if (yes ?? false) {
        Session.clearUser().then((success) {
          if (success) {
            context.read<CUser>().data = null;
            context.read<CHome>().indexMenu = 0;
            context.go(AppRoute.login);
          }
        });
      }
    });
  }

  updateImage(BuildContext context) {
    ImagePicker().pickImage(source: ImageSource.gallery).then((image) {
      if (image != null) {
        String idUser = context.read<CUser>().data!.id;
        String oldImage = context.read<CUser>().data!.image;
        DInfo.dialogConfirmation(context, 'Update IMage', 'yes to update')
            .then((yes) async {
          if (yes ?? false) {
            String name = image.name;
            Uint8List byte = await image.readAsBytes();
            UserSource.updateImage(
              idUser,
              oldImage,
              name,
              base64Encode(byte),
            ).then((success) {
              if (success) {
                Users? newUser = context.read<CUser>().data!..image = name;
                context.read<CUser>().data = newUser;
                Session.setUser(newUser);
                DInfo.snackBarSuccess(context, 'Update Image Success');
              } else {
                DInfo.snackBarError(context, 'update image failed');
              }
            });
          }
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    var cUser = context.read<CUser>();
    var cAccount = context.read<CAccount>();
    if (cUser.data == null) {
      return DView.empty();
    }
    cAccount.setStat(cUser.data!.id);

    double widthBoxImage = MediaQuery.of(context).size.width * 0.5;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        DView.spaceHeight(),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: DView.textTitle('Account', size: 24),
        ),
        DView.spaceHeight(30),
        Center(
          child: SizedBox(
            width: widthBoxImage,
            height: widthBoxImage,
            child: Stack(
              children: [
                Container(
                  width: widthBoxImage,
                  height: widthBoxImage,
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.white10,
                    border: Border.all(
                      width: 4,
                      color: Theme.of(context).primaryColor,
                    ),
                    shape: BoxShape.circle,
                    boxShadow: const [
                      BoxShadow(
                        color: Colors.black38,
                        blurRadius: 6,
                        offset: Offset(2, 3),
                      ),
                    ],
                  ),
                ),
                Align(
                  alignment: Alignment.center,
                  child: Material(
                    elevation: 8,
                    borderRadius: BorderRadius.circular(90),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(90),
                      child: Consumer<CUser>(
                          builder: (contextConsumerUser, _, child) {
                        return Image.network(
                          '${Api.imageUser}/${_.data!.image}',
                          fit: BoxFit.fill,
                          width: widthBoxImage - 20,
                          height: widthBoxImage - 20,
                        );
                      }),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        DView.spaceHeight(13),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: 30,
              width: 100,
              padding: const EdgeInsets.symmetric(
                horizontal: 8,
              ),
              decoration: BoxDecoration(
                color: Colors.grey.withOpacity(0.7),
                borderRadius: BorderRadius.circular(4),
              ),
              alignment: Alignment.center,
              child: DView.textTitle(
                context.watch<CUser>().data!.username,
                color: Colors.white,
              ),
            ),
            DView.spaceWidth(),
            SizedBox(
              height: 30,
              width: 100,
              child: ElevatedButton.icon(
                onPressed: () => updateImage(context),
                icon: const Icon(
                  Icons.edit,
                  size: 14,
                ),
                label: const Text('Image'),
              ),
            ),
          ],
        ),
        Consumer<CAccount>(
          builder: (contextConsumer, _, child) {
            return Padding(
              padding: const EdgeInsets.all(26),
              child: Material(
                elevation: 8,
                color: Colors.white,
                borderRadius: BorderRadius.circular(4),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      Expanded(
                        child: itemStat('Topic', _.stat['topic']),
                      ),
                      Container(
                        color: Colors.grey,
                        height: 30,
                        width: 0.5,
                      ),
                      Expanded(
                        child: itemStat('Follower', _.stat['follower']),
                      ),
                      Container(
                        color: Colors.grey,
                        height: 30,
                        width: 0.5,
                      ),
                      Expanded(
                        child: itemStat('Following', _.stat['following']),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
        DView.spaceHeight(8),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          width: double.infinity,
          child: ElevatedButton(
              onPressed: () => logout(context), child: const Text('Logout')),
        )
      ],
    );
  }
}

Widget itemStat(String title, num value) {
  return Column(
    children: [
      Text(title),
      DView.spaceHeight(4),
      DView.textTitle(AppFormat.infoNumber(value.toDouble())),
    ],
  );
}
