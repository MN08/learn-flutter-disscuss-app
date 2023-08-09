import 'package:d_button/d_button.dart';
import 'package:d_input/d_input.dart';
import 'package:d_view/d_view.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:learn_flutter_discuss_app/controllers/c_add_topic.dart';
import 'package:provider/provider.dart';

class AddTopic extends StatelessWidget {
  AddTopic({super.key});

  final controllerTItle = TextEditingController();
  final controllerDescription = TextEditingController();

  addNewTopic(BuildContext context) {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: DView.appBarLeft('Add Topic'),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16),
        child: DButtonElevation(
          onClick: () => addNewTopic(context),
          height: 40,
          mainColor: Theme.of(context).primaryColor,
          child: const Text(
            'Add New Topic',
            style: TextStyle(
              color: Colors.white,
            ),
          ),
        ),
      ),
      body: ListView(
        children: [
          DView.spaceHeight(),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: DInput(
              controller: controllerTItle,
              title: 'Title',
            ),
          ),
          DView.spaceHeight(),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: DInput(
              controller: controllerDescription,
              title: 'Description',
              minLine: 1,
              maxLine: 5,
            ),
          ),
          DView.spaceHeight(),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              children: [
                ElevatedButton.icon(
                  onPressed: () {
                    context.read<CAddTopic>().pickImage(ImageSource.gallery);
                  },
                  icon: const Icon(Icons.image),
                  label: const Text('Gallery'),
                ),
                DView.spaceWidth(),
                ElevatedButton.icon(
                  onPressed: () {
                    context.read<CAddTopic>().pickImage(ImageSource.camera);
                  },
                  icon: const Icon(Icons.photo_camera),
                  label: const Text('Camera'),
                ),
              ],
            ),
          ),
          Consumer<CAddTopic>(builder: (contextConsumer, _, child) {
            if (_.imageNames.isEmpty) {
              return DView.empty();
            } else {
              return SizedBox(
                height: 150,
                child: ListView.builder(
                  itemCount: _.imageNames.length,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: EdgeInsets.fromLTRB(
                        index == 0 ? 16 : 8,
                        8,
                        index == _.imageNames.length - 1 ? 16 : 8,
                        8,
                      ),
                      child: AspectRatio(
                        aspectRatio: 16 / 9,
                        child: Container(
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: Colors.grey,
                            ),
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: Stack(
                            children: [
                              Center(
                                child: Padding(
                                  padding: const EdgeInsets.all(8),
                                  child: Image.memory(
                                    _.imageBytes[index],
                                    fit: BoxFit.contain,
                                  ),
                                ),
                              ),
                              Align(
                                alignment: Alignment.topRight,
                                child: DButtonElevation(
                                  onClick: () {
                                    _.removeImage(index);
                                  },
                                  width: 40,
                                  height: 40,
                                  mainColor: Colors.red.shade200,
                                  child: Icon(
                                    Icons.delete,
                                    color: Colors.red.shade800,
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
              );
            }
          })
        ],
      ),
    );
  }
}
