import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import '../../../core/controllers/app_controller.dart';
import '../../../core/exceptions/app_exception.dart';
import '../../../core/widgets/loading_widget.dart';
import '../../../core/widgets/modal_bottom_sheet_widget.dart';
import '../../../core/widgets/section_widget.dart';
import '../../../core/widgets/text_field_widget.dart';
import '../../../l10n/l10n.dart';

class ChangePersonalDataPage extends StatefulWidget {
  static const String routeName = "/changePersonalData";
  final AppController appController;
  const ChangePersonalDataPage({super.key, required this.appController});

  @override
  State<ChangePersonalDataPage> createState() => _ChangePersonalDataPageState();
}

class _ChangePersonalDataPageState extends State<ChangePersonalDataPage> {
  late final TextEditingController _nameController;

  @override
  void initState() {
    _nameController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  Future<void> _editName() async {
    _nameController.text = widget.appController.user!.name;

    await ModalBottomSheetWidget.show(
      context,
      title: AppLocalizations.of(context)!.changeName,
      actions: [
        TextButton(
          onPressed: () async {
            try {
              LoadingWidget.dialog(context);

              await widget.appController.changeUserName(
                _nameController.text.trim(),
              );

              if (mounted) {
                LoadingWidget.hide(context);
                Navigator.of(context).pop();
              }
            } on AppException catch (error) {
              if (mounted) {
                LoadingWidget.hide(context);
                error.show(context);
              }
            }
          },
          child: Text(AppLocalizations.of(context)!.save),
        ),
        TextButton(
          onPressed: Navigator.of(context).pop,
          child: Text(AppLocalizations.of(context)!.cancel),
        ),
      ],
      children: [
        _nameTextField,
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.changePersonalData),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Observer(
              builder: (context) {
                return Column(
                  children: [
                    SectionWidget(
                      title: AppLocalizations.of(context)!.name,
                      actions: [
                        IconButton(
                          onPressed: _editName,
                          visualDensity: VisualDensity.compact,
                          icon: const Icon(CupertinoIcons.pen),
                        ),
                      ],
                      content: [
                        Text(
                          widget.appController.user!.name,
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                      ],
                    ),
                    const Divider(),
                    SectionWidget(
                      title: AppLocalizations.of(context)!.email,
                      content: [
                        Text(
                          widget.appController.user!.email,
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                      ],
                    ),
                    const Divider(),
                    SectionWidget(
                      title: AppLocalizations.of(context)!.password,
                      content: [
                        Text(
                          '••••••••',
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                      ],
                    ),
                    const Divider(),
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }

  Widget get _nameTextField {
    return TextFieldWidget(
      label: AppLocalizations.of(context)!.name,
      hint: AppLocalizations.of(context)!.nameHint,
      controller: _nameController,
      keyboardType: TextInputType.name,
      textCapitalization: TextCapitalization.words,
      textInputAction: TextInputAction.next,
    );
  }
}
