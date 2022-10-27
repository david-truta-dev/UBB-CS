import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:my_albums_app/repo/profile_repo.dart';
import 'package:my_albums_app/screen/profile/contact_info/contact_info_view_model.dart';
import 'package:my_albums_app/widgets/app_bar_widget.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../model/profile.dart';
import '../../../theming/dimensions.dart';
import 'widgets/form_widget.dart';

class ContactInfoScreen extends StatefulWidget {
  final Profile? profile;

  const ContactInfoScreen({Key? key, this.profile}) : super(key: key);

  @override
  State<ContactInfoScreen> createState() => _ContactInfoScreenState();
}

class _ContactInfoScreenState extends State<ContactInfoScreen> {
  ContactInfoViewModel contactInfoViewModel = ContactInfoViewModel(
      ProfileRepo(SharedPreferences.getInstance()), Input());
  late Map<FieldKeys, MyField> _fields;

  @override
  initState() {
    _fields = {
      FieldKeys.firstName: MyField(
        key: FieldKeys.firstName,
        textInputType: TextInputType.text,
        initialValue: widget.profile?.firstName,
      ),
      FieldKeys.lastName: MyField(
          key: FieldKeys.lastName,
          textInputType: TextInputType.text,
          focusNode: FocusNode(),
          initialValue: widget.profile?.lastName),
      FieldKeys.email: MyField(
          key: FieldKeys.email,
          textInputType: TextInputType.emailAddress,
          focusNode: FocusNode(),
          initialValue: widget.profile?.email),
      FieldKeys.phone: MyField(
          key: FieldKeys.phone,
          textInputType: TextInputType.phone,
          focusNode: FocusNode(),
          initialValue: widget.profile?.phone),
      FieldKeys.street: MyField(
          key: FieldKeys.street,
          textInputType: TextInputType.streetAddress,
          focusNode: FocusNode(),
          initialValue: widget.profile?.address?.street),
      FieldKeys.city: MyField(
          key: FieldKeys.city,
          textInputType: TextInputType.text,
          focusNode: FocusNode(),
          initialValue: widget.profile?.address?.city),
      FieldKeys.country: MyField(
          key: FieldKeys.country,
          textInputType: TextInputType.text,
          focusNode: FocusNode(),
          initialValue: widget.profile?.address?.country),
      FieldKeys.zipCode: MyField(
          key: FieldKeys.zipCode,
          textInputType: TextInputType.number,
          focusNode: FocusNode(),
          initialValue: widget.profile?.address?.zipCode),
    };
    contactInfoViewModel.output.changesSucceeded.listen((value) {
      if (value) {
        Navigator.of(context).pop();
      }
    });
    super.initState();
  }

  void _setTitlesAndToFocus(BuildContext context) {
    _fields[FieldKeys.firstName]?.title =
        AppLocalizations.of(context)!.firstName.toUpperCase();
    _fields[FieldKeys.firstName]?.toFocus =
        _fields[FieldKeys.lastName]?.focusNode;
    _fields[FieldKeys.lastName]?.title =
        AppLocalizations.of(context)!.lastName.toUpperCase();
    _fields[FieldKeys.lastName]?.toFocus = _fields[FieldKeys.email]?.focusNode;
    _fields[FieldKeys.email]?.title =
        AppLocalizations.of(context)!.emailAddress.toUpperCase();
    _fields[FieldKeys.email]?.toFocus = _fields[FieldKeys.phone]?.focusNode;
    _fields[FieldKeys.phone]?.title =
        AppLocalizations.of(context)!.phoneNumber.toUpperCase();
    _fields[FieldKeys.phone]?.toFocus = _fields[FieldKeys.street]?.focusNode;
    _fields[FieldKeys.street]?.title =
        AppLocalizations.of(context)!.streetAddress.toUpperCase();
    _fields[FieldKeys.street]?.toFocus = _fields[FieldKeys.city]?.focusNode;
    _fields[FieldKeys.city]?.title =
        AppLocalizations.of(context)!.city.toUpperCase();
    _fields[FieldKeys.city]?.toFocus = _fields[FieldKeys.country]?.focusNode;
    _fields[FieldKeys.country]?.title =
        AppLocalizations.of(context)!.country.toUpperCase();
    _fields[FieldKeys.country]?.toFocus = _fields[FieldKeys.zipCode]?.focusNode;
    _fields[FieldKeys.zipCode]?.title =
        AppLocalizations.of(context)!.zipCode.toUpperCase();
  }

  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return AppBarWidget(
      title: Text(AppLocalizations.of(context)!.contactInfo,
          style: Theme.of(context).textTheme.headlineSmall),
      automaticallyImplyLeading: false,
      leading: TextButton(
        onPressed: () {
          Navigator.of(context).pop();
        },
        child: Text(AppLocalizations.of(context)!.back),
      ),
      actions: [
        TextButton(
          onPressed: () {
            contactInfoViewModel.input.applyChanges.add(_fields);
          },
          child: Text(AppLocalizations.of(context)!.apply),
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    _setTitlesAndToFocus(context);
    return Scaffold(
      appBar: _buildAppBar(context),
      body: ListView(
        padding: albumListPadding,
        children: [
          normalVerticalDistance,
          StreamBuilder(
              stream: contactInfoViewModel.output.changesApplied,
              builder: (context, _) {
                return FormWidget(
                  contactInfoViewModel: contactInfoViewModel,
                  fields: _fields,
                );
              }),
          largeVerticalDistance,
          Align(
              child: ElevatedButton(
            style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0),
                ),
                visualDensity: VisualDensity.compact),
            onPressed: () {
              setState(() {
                contactInfoViewModel.input.fetchLocation.add(true);
              });
            },
            child: Text(
              AppLocalizations.of(context)!.useMyLocation,
            ),
          )),
        ],
      ),
    );
  }
}
