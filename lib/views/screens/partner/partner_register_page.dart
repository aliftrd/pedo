import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pedo/constant/themes.dart';
import 'package:pedo/core/controller/image_controller.dart';
import 'package:pedo/core/models/city_model.dart';
import 'package:pedo/core/models/district_model.dart';
import 'package:pedo/core/models/province_model.dart';
import 'package:pedo/core/models/village_model.dart';
import 'package:pedo/core/providers/partner_register_provider.dart';
import 'package:pedo/utils/toast.dart';
import 'package:pedo/utils/validation.dart';
import 'package:pedo/views/screens/partner/partner_thankyou_page.dart';
import 'package:pedo/views/widgets/button.dart';
import 'package:pedo/views/widgets/input_container.dart';
import 'package:pedo/views/widgets/loading_button.dart';
import 'package:provider/provider.dart';

class PartnerRegisterPage extends StatefulWidget {
  static String route = '/partner-register';

  const PartnerRegisterPage({super.key});

  @override
  State<PartnerRegisterPage> createState() => _PartnerRegisterPageState();
}

class _PartnerRegisterPageState extends State<PartnerRegisterPage> {
  final TextEditingController _phoneController = TextEditingController();
  String? province, city, district, village;
  File? imageOne, imageTwo, imageThree;
  bool isLoading = false, validator = false;
  Map<String, dynamic> validatorMessage = {
    'phone': '',
    'province': '',
    'city': '',
    'district': '',
    'village': '',
    'image': '',
  };

  @override
  void dispose() {
    _phoneController;
    imageOne?.delete();
    imageTwo?.delete();
    imageThree?.delete();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    PartnerRegisterProvider partnerRegisterProvider =
        Provider.of<PartnerRegisterProvider>(context);
    ImageController imageController = Provider.of<ImageController>(context);

    void partnerRegisterHandle() async {
      setState(() {
        isLoading = true;
        validator = false;
        validatorMessage['phone'] = '';
        validatorMessage['province'] = '';
        validatorMessage['city'] = '';
        validatorMessage['district'] = '';
        validatorMessage['village'] = '';
        validatorMessage['image'] = '';
      });

      String phone = _phoneController.text;
      if (phone.isEmpty) {
        setState(() {
          validator = true;
          validatorMessage['phone'] = 'Nomor HP tidak boleh kosong';
          isLoading = false;
        });
      } else {
        bool? isValid = await Validation.phoneValidate(phone);
        if (!isValid!) {
          setState(() {
            validator = true;
            validatorMessage['phone'] = 'Nomor HP tidak valid';
            isLoading = false;
          });
        }
      }

      if (province == null) {
        setState(() {
          validator = true;
          validatorMessage['province'] = 'Provinsi tidak boleh kosong';
          isLoading = false;
        });
      }

      if (city == null) {
        setState(() {
          validator = true;
          validatorMessage['city'] = 'Kota tidak boleh kosong';
          isLoading = false;
        });
      }

      if (district == null) {
        setState(() {
          validator = true;
          validatorMessage['district'] = 'Kecamatan tidak boleh kosong';
          isLoading = false;
        });
      }

      if (village == null) {
        setState(() {
          validator = true;
          validatorMessage['village'] = 'Desa tidak boleh kosong';
          isLoading = false;
        });
      }

      if (imageOne == null || imageTwo == null || imageThree == null) {
        setState(() {
          validator = true;
          validatorMessage['image'] = 'Gambar tidak boleh kosong';
          isLoading = false;
        });
      }

      if (!validator) {
        var response = await partnerRegisterProvider.registerPartner(
          phone: phone,
          village: village!,
          imageOne: imageOne!,
          imageTwo: imageTwo!,
          imageThree: imageThree!,
        );

        if (response['code'] == 201) {
          Navigator.pop(context);
          Navigator.pushNamed(context, PartnerThankyouPage.route);
        } else {
          Toast.showError(context, response['message']);

          setState(() {
            isLoading = false;
          });
        }
      }
    }

    return Scaffold(
      backgroundColor: background,
      body: SafeArea(
        child: CustomScrollView(
          physics: const BouncingScrollPhysics(),
          slivers: [
            SliverAppBar(
              floating: true,
              backgroundColor: background,
              elevation: 0,
              centerTitle: true,
              title: Text(
                'Selamat Datang Di PEDO',
                style: primaryTextStyle.copyWith(
                  fontSize: 16,
                  fontWeight: semibold,
                ),
              ),
              leading: Padding(
                padding: EdgeInsets.only(left: defaultMargin),
                child: IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: Icon(
                    Icons.arrow_back,
                    color: colorDark,
                  ),
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: defaultMargin),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        InputContainer(
                          icons: Icon(Icons.phone, color: colorPrimary),
                          label: "Nomor HP",
                          widget: TextFormField(
                            style: primaryTextStyle,
                            controller: _phoneController,
                            keyboardType: TextInputType.phone,
                            inputFormatters: [
                              FilteringTextInputFormatter.digitsOnly,
                            ],
                            decoration: InputDecoration.collapsed(
                              hintText: "Masukkan Nomor HP",
                              hintStyle: hintTextStyle,
                            ),
                          ),
                        ),
                        validator && validatorMessage['phone'] != ''
                            ? Padding(
                                padding: const EdgeInsets.only(top: 10),
                                child: Text(
                                  validatorMessage['phone'],
                                  style: primaryTextStyle.copyWith(
                                      color: colorDanger),
                                ),
                              )
                            : Container(),
                        InputContainer(
                          label: "Alamat",
                          margin: const EdgeInsets.only(top: 15),
                          widget: DropdownButton(
                            hint: const Text('Pilih Provinsi'),
                            value: province,
                            isExpanded: true,
                            menuMaxHeight: 250,
                            underline: const SizedBox(),
                            items: partnerRegisterProvider.provinces.map(
                              (ProvinceModel value) {
                                return DropdownMenuItem(
                                  value: value.id.toString(),
                                  child: Text(value.name),
                                );
                              },
                            ).toList(),
                            onChanged: (String? value) {
                              setState(() {
                                province = value!;
                                city = null;
                                district = null;
                                village = null;
                              });
                              partnerRegisterProvider.getCityList(province!);
                            },
                          ),
                        ),
                        validator && validatorMessage['province'] != ''
                            ? Padding(
                                padding: const EdgeInsets.only(top: 10),
                                child: Text(
                                  validatorMessage['province'],
                                  style: primaryTextStyle.copyWith(
                                      color: colorDanger),
                                ),
                              )
                            : Container(),
                        InputContainer(
                          backgroundInputColor:
                              province != null ? null : disableBackgroundInput,
                          margin: const EdgeInsets.only(top: 15),
                          widget: DropdownButton<String>(
                            hint: const Text('Pilih Kota'),
                            value: city,
                            isExpanded: true,
                            menuMaxHeight: 250,
                            underline: const SizedBox(),
                            items: partnerRegisterProvider.cities.map(
                              (CityModel value) {
                                return DropdownMenuItem(
                                  value: value.id.toString(),
                                  child: Text(value.name),
                                );
                              },
                            ).toList(),
                            onChanged: province != null
                                ? (String? value) {
                                    setState(() {
                                      city = value!;
                                      district = null;
                                      village = null;
                                    });
                                    partnerRegisterProvider
                                        .getDistrictList(city!);
                                  }
                                : null,
                          ),
                        ),
                        validator && validatorMessage['city'] != ''
                            ? Padding(
                                padding: const EdgeInsets.only(top: 10),
                                child: Text(
                                  validatorMessage['city'],
                                  style: primaryTextStyle.copyWith(
                                      color: colorDanger),
                                ),
                              )
                            : Container(),
                        InputContainer(
                          backgroundInputColor:
                              city != null ? null : disableBackgroundInput,
                          margin: const EdgeInsets.only(top: 15),
                          widget: DropdownButton<String>(
                            hint: const Text('Pilih Kecamatan'),
                            value: district,
                            isExpanded: true,
                            menuMaxHeight: 250,
                            underline: const SizedBox(),
                            items: partnerRegisterProvider.districts.map(
                              (DistrictModel value) {
                                return DropdownMenuItem(
                                  value: value.id.toString(),
                                  child: Text(value.name),
                                );
                              },
                            ).toList(),
                            onChanged: city != null
                                ? (String? value) {
                                    setState(() {
                                      district = value!;
                                      village = null;
                                    });
                                    partnerRegisterProvider
                                        .getVillageList(district!);
                                  }
                                : null,
                          ),
                        ),
                        validator && validatorMessage['district'] != ''
                            ? Padding(
                                padding: const EdgeInsets.only(top: 10),
                                child: Text(
                                  validatorMessage['district'],
                                  style: primaryTextStyle.copyWith(
                                      color: colorDanger),
                                ),
                              )
                            : Container(),
                        InputContainer(
                          backgroundInputColor:
                              district != null ? null : disableBackgroundInput,
                          margin: const EdgeInsets.only(top: 15),
                          widget: DropdownButton<String>(
                            hint: const Text('Pilih Desa'),
                            value: village,
                            isExpanded: true,
                            menuMaxHeight: 250,
                            underline: const SizedBox(),
                            items: partnerRegisterProvider.villages.map(
                              (VillageModel value) {
                                return DropdownMenuItem(
                                  value: value.id.toString(),
                                  child: Text(value.name),
                                );
                              },
                            ).toList(),
                            onChanged: district != null
                                ? (String? value) =>
                                    setState(() => village = value!)
                                : null,
                          ),
                        ),
                        validator && validatorMessage['village'] != ''
                            ? Padding(
                                padding: const EdgeInsets.only(top: 10),
                                child: Text(
                                  validatorMessage['village'],
                                  style: primaryTextStyle.copyWith(
                                      color: colorDanger),
                                ),
                              )
                            : Container(),
                        const SizedBox(height: 20),
                        Text(
                          'Gambar',
                          style: primaryTextStyle.copyWith(
                            fontSize: 16,
                          ),
                        ),
                        Text(
                          '*Contoh : Gambar peliharaan, kandang, sertifikat',
                          style: subtitleTextStyle.copyWith(
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 129,
                    child: ListView(
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      physics: const BouncingScrollPhysics(),
                      children: [
                        SizedBox(width: defaultMargin),
                        InkWell(
                          onTap: () async {
                            await imageController.pickImage();
                            if (imageController.pickedImage != null) {
                              setState(() {
                                imageOne = imageController.takeImage();
                              });
                            }
                          },
                          child: Container(
                            width: 129,
                            margin: const EdgeInsets.only(top: 10),
                            decoration: BoxDecoration(
                              image: imageOne == null
                                  ? null
                                  : DecorationImage(
                                      image: FileImage(imageOne!),
                                      fit: BoxFit.cover,
                                    ),
                              color: colorHint,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: imageOne == null
                                ? Center(
                                    child: Icon(
                                      Icons.image,
                                      size: 44,
                                      color: colorDark,
                                    ),
                                  )
                                : null,
                          ),
                        ),
                        const SizedBox(width: 10),
                        InkWell(
                          onTap: () async {
                            await imageController.pickImage();
                            if (imageController.pickedImage != null) {
                              setState(() {
                                imageTwo = imageController.takeImage();
                              });
                            }
                          },
                          child: Container(
                            width: 129,
                            margin: const EdgeInsets.only(top: 10),
                            decoration: BoxDecoration(
                              image: imageTwo == null
                                  ? null
                                  : DecorationImage(
                                      image: FileImage(imageTwo!),
                                      fit: BoxFit.cover,
                                    ),
                              color: colorHint,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: imageTwo == null
                                ? Center(
                                    child: Icon(
                                      Icons.image,
                                      size: 44,
                                      color: colorDark,
                                    ),
                                  )
                                : null,
                          ),
                        ),
                        const SizedBox(width: 10),
                        InkWell(
                          onTap: () async {
                            await imageController.pickImage();
                            if (imageController.pickedImage != null) {
                              setState(() {
                                imageThree = imageController.takeImage();
                              });
                            }
                          },
                          child: Container(
                            width: 129,
                            margin: const EdgeInsets.only(top: 10),
                            decoration: BoxDecoration(
                              image: imageThree == null
                                  ? null
                                  : DecorationImage(
                                      image: FileImage(imageThree!),
                                      fit: BoxFit.cover,
                                    ),
                              color: colorHint,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: imageThree == null
                                ? Center(
                                    child: Icon(
                                      Icons.image,
                                      size: 44,
                                      color: colorDark,
                                    ),
                                  )
                                : null,
                          ),
                        ),
                        SizedBox(width: defaultMargin),
                      ],
                    ),
                  ),
                  validator && validatorMessage['image'] != ''
                      ? Padding(
                          padding: EdgeInsets.only(
                            top: 10,
                            left: defaultMargin,
                            right: defaultMargin,
                          ),
                          child: Text(
                            validatorMessage['image'],
                            style:
                                primaryTextStyle.copyWith(color: colorDanger),
                          ),
                        )
                      : Container(),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: defaultMargin),
                    child: isLoading
                        ? const LoadingButton()
                        : PrimaryButton(
                            margin: const EdgeInsets.only(top: 20),
                            text: 'Kirim Permintaan',
                            onPressed: partnerRegisterHandle,
                          ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
