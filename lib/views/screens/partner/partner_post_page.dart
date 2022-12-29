import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pedo/constant/themes.dart';
import 'package:pedo/constant/variable.dart';
import 'package:pedo/core/controller/image_controller.dart';
import 'package:pedo/core/models/animal_breed_model.dart';
import 'package:pedo/core/models/animal_type_model.dart';
import 'package:pedo/core/providers/partner_post_provider.dart';
import 'package:pedo/utils/validation.dart';
import 'package:pedo/views/widgets/button.dart';
import 'package:pedo/views/widgets/input_container.dart';
import 'package:pedo/views/widgets/input_validation.dart';
import 'package:pedo/views/widgets/loading_button.dart';
import 'package:provider/provider.dart';

class PartnerPostPage extends StatefulWidget {
  static String route = '/partner-post';
  const PartnerPostPage({Key? key}) : super(key: key);

  @override
  State<PartnerPostPage> createState() => _PartnerPostPageState();
}

class _PartnerPostPageState extends State<PartnerPostPage> {
  final TextEditingController _nameController = TextEditingController(),
      _descriptionController = TextEditingController(),
      _priceController = TextEditingController();
  List<File> _images = [];
  String? selectedGender,
      selectedType,
      selectedBreed,
      selectedColorPrimary,
      selectedColorSecondary;
  bool isPaid = false;

  bool isLoading = false, validator = false;
  Map<String, dynamic> validatorMessage = {
    'images': '',
    'name': '',
    'description': '',
    'type': '',
    'breed': '',
    'gender': '',
    'colorPrimary': '',
    'colorSecondary': '',
    'price': '',
  };

  @override
  void dispose() {
    super.dispose();
    _nameController.dispose();
    _descriptionController.dispose();
    _priceController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    PartnerPostProvider partnerPostProvider =
        Provider.of<PartnerPostProvider>(context);
    ImageController imageController = Provider.of<ImageController>(context);

    void onSubmitHandle() async {
      setState(() {
        isLoading = true;
        validator = false;
        validatorMessage['images'] = '';
        validatorMessage['name'] = '';
        validatorMessage['description'] = '';
        validatorMessage['type'] = '';
        validatorMessage['breed'] = '';
        validatorMessage['gender'] = '';
        validatorMessage['colorPrimary'] = '';
        validatorMessage['colorSecondary'] = '';
        validatorMessage['price'] = '';
      });

      String name = _nameController.text,
          description = _descriptionController.text,
          price = _priceController.text;

      if (_images.isEmpty) {
        setState(() {
          validator = true;
          validatorMessage['images'] = 'Gambar tidak boleh kosong';
          isLoading = false;
        });
      } else if (_images.length > 5) {
        setState(() {
          validator = true;
          validatorMessage['images'] = 'Gambar tidak boleh lebih dari 5';
          isLoading = false;
        });
      }

      if (name.isEmpty) {
        setState(() {
          validator = true;
          validatorMessage['name'] = 'Nama tidak boleh kosong';
          isLoading = false;
        });
      }

      if (description.isEmpty) {
        setState(() {
          validator = true;
          validatorMessage['description'] = 'Deskripsi tidak boleh kosong';
          isLoading = false;
        });
      }

      if (selectedType == null) {
        setState(() {
          validator = true;
          validatorMessage['type'] = 'Tipe tidak boleh kosong';
          isLoading = false;
        });
      }

      if (selectedBreed == null) {
        setState(() {
          validator = true;
          validatorMessage['breed'] = 'Breed tidak boleh kosong';
          isLoading = false;
        });
      }

      if (selectedGender == null) {
        setState(() {
          validator = true;
          validatorMessage['gender'] = 'Gender tidak boleh kosong';
          isLoading = false;
        });
      }

      if (selectedColorPrimary == null) {
        setState(() {
          validator = true;
          validatorMessage['colorPrimary'] = 'Warna tidak boleh kosong';
          isLoading = false;
        });
      }

      if (selectedColorSecondary == null) {
        setState(() {
          validator = true;
          validatorMessage['colorSecondary'] = 'Warna tidak boleh kosong';
          isLoading = false;
        });
      }

      if (isPaid) {
        if (price.isEmpty) {
          setState(() {
            validator = true;
            validatorMessage['price'] = 'Harga tidak boleh kosong';
            isLoading = false;
          });
        }
      }

      if (!validator) {
        var response = await partnerPostProvider.addAnimal(
          animalName: name,
          animalDescription: description,
          animalTypeId: selectedType!,
          animalBreedId: selectedBreed!,
          animalGender: selectedGender!,
          animalColorPrimary: selectedColorPrimary!,
          animalColorSecondary: selectedColorSecondary!,
          animalIsPaid: isPaid ? '1' : '0',
          animalPrice: Validation.isNull(price) ? '0' : price,
          animalImages: _images,
        );

        if (response['code'] == 200) {
          Navigator.pop(context);
        } else {
          setState(() {
            isLoading = false;
          });
        }
      }
    }

    Widget addImages() {
      return InkWell(
        onTap: () async {
          await imageController.pickImage();
          if (imageController.pickedImage != null) {
            setState(() {
              _images.add(imageController.takeImage());
            });
          }
        },
        child: Container(
          decoration: BoxDecoration(
            border: Border.all(
              color: colorHint,
              width: 1,
            ),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Center(
            child: Icon(
              Icons.image,
              size: 22,
              color: colorDark,
            ),
          ),
        ),
      );
    }

    Widget listOfImage(int index) {
      return Stack(
        children: [
          Container(
            width: 100,
            margin: EdgeInsets.only(
              left: index == 0 ? defaultMargin : 0,
              right: index == _images.length ? defaultMargin : 0,
            ),
            decoration: BoxDecoration(
              image: DecorationImage(
                image: FileImage(_images[index]),
                fit: BoxFit.cover,
              ),
              color: colorHint,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.black.withOpacity(0.2),
                    Colors.black.withOpacity(0.5),
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 0,
            right: 0,
            child: InkWell(
              onTap: () => setState(() {
                _images[index].delete();
                _images.removeAt(index);
              }),
              child: Container(
                height: 32,
                width: 32,
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(10),
                    bottomRight: Radius.circular(10),
                  ),
                  color: colorPrimary,
                ),
                child: Icon(
                  Icons.delete,
                  color: colorDark,
                  size: 16,
                ),
              ),
            ),
          ),
        ],
      );
    }

    Widget inputName() {
      return Container(
        margin: const EdgeInsets.only(top: 20.0),
        child: TextFormField(
          style: primaryTextStyle,
          controller: _nameController,
          maxLength: 128,
          maxLines: null,
          decoration: InputDecoration(
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 15,
              vertical: 12.5,
            ),
            hintText: "Masukkan Nama Hewan",
            hintStyle: hintTextStyle,
            filled: true,
            fillColor: backgroundInput,
            counterText: '',
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide.none,
            ),
          ),
        ),
      );
    }

    Widget inputDescription() {
      return Container(
        margin: const EdgeInsets.only(top: 10.0),
        child: TextFormField(
          style: primaryTextStyle,
          controller: _descriptionController,
          maxLength: 3000,
          maxLines: null,
          decoration: InputDecoration(
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 15,
              vertical: 12.5,
            ),
            hintText: "Masukkan Deskripsi Hewan",
            hintStyle: hintTextStyle,
            filled: true,
            fillColor: backgroundInput,
            counterText: '',
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide.none,
            ),
          ),
        ),
      );
    }

    Widget inputType() {
      return Expanded(
        child: InputContainer(
          margin: const EdgeInsets.only(top: 10.0),
          widget: DropdownButton<String>(
            hint: const Text('Tipe'),
            value: selectedType,
            isExpanded: true,
            menuMaxHeight: 250,
            underline: const SizedBox(),
            items: partnerPostProvider.animalTypes.map((AnimalTypeModel value) {
              return DropdownMenuItem<String>(
                value: value.id.toString(),
                child: Text(value.title),
              );
            }).toList(),
            onChanged: (value) {
              setState(() {
                selectedType = value!;
                selectedBreed = null;
              });
              partnerPostProvider.getAnimalBreed(value!);
            },
          ),
        ),
      );
    }

    Widget inputBreed() {
      return Expanded(
        child: InputContainer(
          margin: const EdgeInsets.only(top: 10.0),
          widget: DropdownButton<String>(
            hint: const Text('Ras'),
            value: selectedBreed,
            isExpanded: true,
            menuMaxHeight: 250,
            underline: const SizedBox(),
            items:
                partnerPostProvider.animalBreeds.map((AnimalBreedModel value) {
              return DropdownMenuItem<String>(
                value: value.id.toString(),
                child: Text(value.title),
              );
            }).toList(),
            onChanged: (value) => setState(() {
              selectedBreed = value!;
            }),
          ),
        ),
      );
    }

    Widget inputGender() {
      return InputContainer(
        margin: const EdgeInsets.only(top: 10.0),
        widget: DropdownButton<String>(
          hint: const Text('Gender'),
          value: selectedGender,
          isExpanded: true,
          menuMaxHeight: 250,
          underline: const SizedBox(),
          items: genders.map((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(value),
            );
          }).toList(),
          onChanged: (value) => setState(() {
            selectedGender = value!;
          }),
        ),
      );
    }

    Widget inputColorPrimary() {
      return Expanded(
        child: InputContainer(
          margin: const EdgeInsets.only(top: 10.0),
          widget: DropdownButton<String>(
            hint: const Text('Warna Primer'),
            value: selectedColorPrimary,
            isExpanded: true,
            menuMaxHeight: 250,
            underline: const SizedBox(),
            items: colors.map((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
            onChanged: (value) => setState(() {
              selectedColorPrimary = value!;
            }),
          ),
        ),
      );
    }

    Widget inputColorSecondary() {
      return Expanded(
        child: InputContainer(
          margin: const EdgeInsets.only(top: 10.0),
          widget: DropdownButton<String>(
            hint: const Text('Warna Sekunder'),
            value: selectedColorSecondary,
            isExpanded: true,
            menuMaxHeight: 250,
            underline: const SizedBox(),
            items: colors.map((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
            onChanged: (value) => setState(() {
              selectedColorSecondary = value!;
            }),
          ),
        ),
      );
    }

    Widget inputPrice() {
      return Container(
        margin: const EdgeInsets.only(top: 15.0),
        child: TextFormField(
          style: primaryTextStyle,
          controller: _priceController,
          maxLength: 128,
          maxLines: null,
          keyboardType: TextInputType.number,
          inputFormatters: [
            FilteringTextInputFormatter.digitsOnly,
          ],
          decoration: InputDecoration(
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 15,
              vertical: 12.5,
            ),
            hintText: "Masukkan Harga",
            hintStyle: hintTextStyle,
            filled: true,
            fillColor: backgroundInput,
            counterText: '',
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide.none,
            ),
          ),
        ),
      );
    }

    void onBackHandle() async {
      for (File image in _images) {
        await image.delete();
      }
      Navigator.pop(context);
    }

    return WillPopScope(
      onWillPop: () async {
        onBackHandle();
        return false;
      },
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: background,
          elevation: 0,
          centerTitle: true,
          title: Text(
            'Tambah Hewan',
            style: primaryTextStyle.copyWith(
              fontSize: 16,
              fontWeight: semibold,
            ),
          ),
          leading: Padding(
            padding: EdgeInsets.only(left: defaultMargin),
            child: IconButton(
              onPressed: onBackHandle,
              icon: Icon(
                Icons.arrow_back,
                color: colorDark,
              ),
            ),
          ),
        ),
        backgroundColor: background,
        body: SafeArea(
          child: ListView(
            physics: const BouncingScrollPhysics(),
            children: [
              SizedBox(
                height: 100,
                child: ListView.separated(
                  shrinkWrap: true,
                  physics: const AlwaysScrollableScrollPhysics(
                    parent: BouncingScrollPhysics(),
                  ),
                  scrollDirection: Axis.horizontal,
                  separatorBuilder: (context, index) =>
                      const SizedBox(width: 10),
                  itemCount: _images.length + 1,
                  itemBuilder: (context, index) {
                    if (_images.isNotEmpty && index != _images.length) {
                      return listOfImage(index);
                    }
                    return Container(
                      width: 100,
                      margin: EdgeInsets.only(
                        left: index == 0 ? defaultMargin : 0,
                        right: index == _images.length ? defaultMargin : 0,
                      ),
                      child: addImages(),
                    );
                  },
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: defaultMargin),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    validator && !Validation.isNull(validatorMessage['images'])
                        ? InputValidation.error(validatorMessage['images'])
                        : Container(),
                    inputName(),
                    validator && !Validation.isNull(validatorMessage['name'])
                        ? InputValidation.error(validatorMessage['name'])
                        : Container(),
                    inputDescription(),
                    validator &&
                            !Validation.isNull(validatorMessage['description'])
                        ? InputValidation.error(validatorMessage['description'])
                        : Container(),
                    Row(
                      children: [
                        inputType(),
                        const SizedBox(width: 10),
                        inputBreed(),
                      ],
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        validator &&
                                !Validation.isNull(validatorMessage['type'])
                            ? Expanded(
                                child: InputValidation.error(
                                    validatorMessage['type']),
                              )
                            : Container(),
                        validator &&
                                !Validation.isNull(validatorMessage['breed'])
                            ? Expanded(
                                child: InputValidation.error(
                                    validatorMessage['breed']),
                              )
                            : Container(),
                      ],
                    ),
                    inputGender(),
                    validator && !Validation.isNull(validatorMessage['gender'])
                        ? InputValidation.error(validatorMessage['gender'])
                        : Container(),
                    Row(
                      children: [
                        inputColorPrimary(),
                        const SizedBox(width: 10),
                        inputColorSecondary(),
                      ],
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        validator &&
                                !Validation.isNull(
                                    validatorMessage['colorPrimary'])
                            ? Expanded(
                                child: InputValidation.error(
                                    validatorMessage['colorPrimary']),
                              )
                            : Container(),
                        validator &&
                                !Validation.isNull(
                                    validatorMessage['colorSecondary'])
                            ? Expanded(
                                child: InputValidation.error(
                                    validatorMessage['colorSecondary']),
                              )
                            : Container(),
                      ],
                    ),
                    InputContainer(
                      margin: const EdgeInsets.only(top: 10.0),
                      widget: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Berbayar?',
                            style: primaryTextStyle.copyWith(
                              color: colorHint,
                              fontSize: 16,
                            ),
                          ),
                          Checkbox(
                            value: isPaid,
                            onChanged: (bool? value) {
                              setState(() {
                                isPaid = value!;
                                validatorMessage['price'] = '';
                                _priceController.clear();
                              });
                            },
                          ),
                        ],
                      ),
                    ),
                    isPaid ? inputPrice() : const SizedBox(),
                    validator && !Validation.isNull(validatorMessage['price'])
                        ? InputValidation.error(validatorMessage['price'])
                        : Container(),
                    isLoading
                        ? const LoadingButton()
                        : Container(
                            margin:
                                const EdgeInsets.only(top: 20.0, bottom: 20.0),
                            child: PrimaryButton(
                              text: 'Tambahkan',
                              onPressed: onSubmitHandle,
                            ),
                          ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
