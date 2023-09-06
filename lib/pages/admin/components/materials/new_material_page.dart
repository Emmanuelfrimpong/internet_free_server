
import 'dart:html';
import 'dart:typed_data';

import 'package:auto_route/auto_route.dart';
import 'package:file_picker/_internal/file_picker_web.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:internet_free_server/core/components/widgets/custom_button.dart';
import 'package:internet_free_server/core/components/widgets/custom_input.dart';
import 'package:internet_free_server/styles/colors.dart';

import '../../../../state/new_material_state.dart';

@RoutePage()
class NewMaterialPage extends ConsumerStatefulWidget {
  const NewMaterialPage({super.key});

  @override
  ConsumerState<NewMaterialPage> createState() => _NewMaterialPageState();
}

class _NewMaterialPageState extends ConsumerState<NewMaterialPage> {

  final _controller = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  PlatformFile? fileBytes;
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context,size) {
        return Padding(
          padding: const EdgeInsets.all(25.0),
          child: Column(
            children: [
              const SizedBox(height: 20),
              //close button
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton.icon(
                    style: TextButton.styleFrom(
                      backgroundColor: Colors.red,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8)),
                      padding:
                          const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
                    ),
                    onPressed: () {
                      AutoRouter.of(context).pop();
                    },
                    icon: const Icon(
                      Icons.close,
                      color: Colors.white,
                    ), label: const Text('Close', style: TextStyle(color: Colors.white),))
                 
                ],
              ),
              Card(
                elevation: 2,
                child: Container(
                  width: size.maxWidth*0.55,
                  padding: const EdgeInsets.all(25),
                  child: Form(
                    key: _formKey,
                    child: Column(children: [
                      Text('Upload Material'.toUpperCase(),
                          style: const TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                          )),
                          const Divider(
                            color: Colors.black,
                            thickness: 2,
                            height: 20,
                          ),
                          const SizedBox(height: 20),
                          CustomTextFields(
                            label: 'Material Title',
                            validator: (title){
                              if(title==null||title.isEmpty){
                                return 'Please enter a title';
                              }
                              return null;
                            
                            },
                            onSaved: (title){    
                               ref.read(newMaterislProvider.notifier).setTitle(title!);                          
                            },
                          ),
                          const SizedBox(height: 30),
                          CustomTextFields(
                            label: 'Material Description',
                            validator: (description){
                              if(description==null||description.isEmpty){
                                return 'Please enter a description';
                              }
                              return null;
                            
                            },
                            maxLines: 5,
                            onSaved: (description){      
                              ref.read(newMaterislProvider.notifier).setDescription(description!);                      
                            },
                          ),
                          const SizedBox(height: 30),
                          CustomTextFields(       
                            isReadOnly: true, 
                            controller: _controller,                    
                            suffixIcon: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: TextButton.icon(
                                onPressed: ()=>pickFile(),
                                icon: const Icon(Icons.upload,color: Colors.white,),
                                label: const Text('Upload',style: TextStyle(color: Colors.white),),
                                style: TextButton.styleFrom(
                                  backgroundColor: primaryColor,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8)
                                  )
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 30),
                          //submit button
                          CustomButton(text: 'Submit', onPressed: (){
                            if(_formKey.currentState!.validate()){
                              _formKey.currentState!.save();
                              ref.read(newMaterislProvider.notifier).uploadMaterial(fileBytes!,ref,_formKey,_controller);

                            }
                          })
                    ]),
                  ),
                ),
              ),
            ],
          ),
        );
      }
    );
  }
  
  pickFile()async {
    FilePickerResult? result =await FilePickerWeb.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['pdf', 'mp4'],
        allowMultiple: false,
        withReadStream:
          true,
      );
      if(result!=null){

        setState(() {
          _controller.text = result.files.first.name;
          //get file type
          ref.read(newMaterislProvider.notifier).setFileType(result.files.first.extension!);
          fileBytes = result.files.first;
        });
        
      }else{
      }
  }
}