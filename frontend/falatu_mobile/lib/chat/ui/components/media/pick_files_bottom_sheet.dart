import "package:cross_file/cross_file.dart";
import "package:falatu_mobile/chat/core/domain/entities/message/send/send_file_message_entity.dart";
import "package:falatu_mobile/chat/ui/blocs/send_message/send_messge_bloc.dart";
import "package:falatu_mobile/chat/ui/pages/media_editor_page.dart";
import "package:falatu_mobile/commons/core/domain/services/file_picker_service/file_picker_service.dart";
import "package:falatu_mobile/commons/core/domain/services/shared_preferences_services/shared_preferences_services.dart";
import "package:falatu_mobile/commons/ui/components/falatu_bottom_sheet.dart";
import "package:falatu_mobile/commons/ui/components/falatu_button.dart";
import "package:falatu_mobile/commons/ui/components/falatu_icon.dart";
import "package:falatu_mobile/commons/ui/components/falatu_splash_effect.dart";
import "package:falatu_mobile/commons/utils/enums/file_extension_enum.dart";
import "package:falatu_mobile/commons/utils/enums/icons_enum.dart";
import "package:falatu_mobile/commons/utils/enums/media_type_enum.dart";
import "package:falatu_mobile/commons/utils/extensions/context_extensions.dart";
import "package:falatu_mobile/commons/utils/extensions/num_extensions.dart";
import "package:falatu_mobile/commons/utils/routes.dart";
import "package:flutter/material.dart";
import "package:flutter_modular/flutter_modular.dart";

class _BottomBarItem {
  final String label;
  final FalaTuIconsEnum icon;

  _BottomBarItem({required this.label, required this.icon});
}

class PickFilesBottomSheet extends StatefulWidget {
  final String chatId;

  const PickFilesBottomSheet({required this.chatId, super.key});

  PickFilesBottomSheet.show(BuildContext context,
      {required this.chatId, super.key}) {
    FalaTuBottomSheet.show(context: context, child: this);
  }

  @override
  State<PickFilesBottomSheet> createState() => _PickFilesBottomSheetState();
}

class _PickFilesBottomSheetState extends State<PickFilesBottomSheet> {
  List<_BottomBarItem> _barItems(BuildContext context) => [
        _BottomBarItem(
            label: context.i18n.gallery, icon: FalaTuIconsEnum.photoLibrary),
        _BottomBarItem(
            label: context.i18n.camera, icon: FalaTuIconsEnum.camera),
        _BottomBarItem(label: context.i18n.files, icon: FalaTuIconsEnum.folder),
      ];

  late final ValueNotifier<int> _indexNotifier = ValueNotifier(0);
  late final PageController _controller = PageController();
  late final SendMessageBloc _sendMessageBloc = Modular.get<SendMessageBloc>();

  late final FilePickerService _picker = Modular.get<FilePickerService>();
  late final String _userId =
      Modular.get<SharedPreferencesService>().getUserId()!;

  void _handleFiles(List<XFile> files, MediaTypeEnum type) {
    final params =
        MediaEditorPageParams(medias: files, type: type, chatId: widget.chatId);
    Modular.to.pushNamed(Routes.chats + Routes.mediaEditor, arguments: params);
  }

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    return ValueListenableBuilder(
        valueListenable: _indexNotifier,
        builder: (context, selectedIndex, _) {
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              _Header(title: _handleTitle(context, selectedIndex)),
              AnimatedContainer(
                duration: const Duration(milliseconds: 100),
                curve: Curves.easeIn,
                height: _handleHeight(selectedIndex),
                child: PageView(
                  controller: _controller,
                  onPageChanged: (value) => _indexNotifier.value = value,
                  children: [
                    _PageCard(items: [
                      _PageItem(
                        label: "Selecione fotos",
                        icon: FalaTuIconsEnum.image,
                        onTap: () async {
                          final files =
                              await _picker.multipleImagesFromGallery();
                          if (files.isNotEmpty) {
                            _handleFiles(files, MediaTypeEnum.image);
                          }
                        },
                      ),
                      _PageItem(
                        label: "Selecione um video",
                        icon: FalaTuIconsEnum.videoCamera,
                        onTap: () async {
                          final file = await _picker.videoFromGallery();
                          if (file != null) {
                            _handleFiles([file], MediaTypeEnum.video);
                          }
                        },
                      ),
                    ]),
                    _PageCard(items: [
                      _PageItem(
                        label: "Tire uma foto",
                        icon: FalaTuIconsEnum.image,
                        onTap: () async {
                          final file = await _picker.imageFromCamera();
                          if (file != null) {
                            _handleFiles([file], MediaTypeEnum.image);
                          }
                        },
                      ),
                      _PageItem(
                        label: "Grave um video",
                        icon: FalaTuIconsEnum.videoCamera,
                        onTap: () async {
                          final file = await _picker.videoFromCamera();
                          if (file != null) {
                            _handleFiles([file], MediaTypeEnum.video);
                          }
                        },
                      ),
                    ]),
                    _PageCard(items: [
                      _PageItem(
                          label: "Envie um arquivo",
                          icon: FalaTuIconsEnum.uploadFile,
                          onTap: () async {
                            final file = await _picker.document(
                                allowedExtensions:
                                    FileExtensionsEnum.allToName());
                            if (file != null) {
                              final message = SendFileMessageEntity(
                                  mediaFile: file, senderId: _userId);
                              _sendMessageBloc.call(widget.chatId, message);
                              if (context.mounted) {
                                Modular.to.pop(context);
                              }
                            }
                          }),
                    ]),
                  ],
                ),
              ),
              Theme(
                data: Theme.of(context).copyWith(
                  splashColor: Colors.transparent,
                  highlightColor: Colors.transparent,
                ),
                child: BottomNavigationBar(
                  onTap: (value) {
                    _controller.animateToPage(value,
                        duration: const Duration(milliseconds: 150),
                        curve: Curves.easeIn);
                  },
                  selectedItemColor: colors.primary,
                  currentIndex: selectedIndex,
                  items: List.generate(3, (index) {
                    final e = _barItems(context)[index];
                    return BottomNavigationBarItem(
                      label: e.label,
                      icon: FalaTuIcon(
                        icon: e.icon,
                        color: index == selectedIndex
                            ? colors.primary
                            : colors.onSurface,
                        size: _handleIconSize(
                            index: index, selectedIndex: selectedIndex),
                      ),
                    );
                  }),
                ),
              ),
            ],
          );
        });
  }

  double _handleIconSize({required int index, required int selectedIndex}) {
    if (index == selectedIndex) {
      return 34;
    }
    return 26;
  }

  String _handleTitle(BuildContext context, int index) {
    switch (index) {
      case 0:
        return context.i18n.gallery;
      case 1:
        return context.i18n.camera;
      case 2:
        return context.i18n.files;
      default:
        return "";
    }
  }

  double _handleHeight(int index) {
    switch (index) {
      case 0:
        return 140;
      case 1:
        return 140;
      case 2:
        return 70;
      default:
        return 140;
    }
  }
}

class _PageItem {
  final String label;
  final FalaTuIconsEnum icon;
  final void Function() onTap;

  _PageItem({required this.label, required this.icon, required this.onTap});
}

class _PageCard extends StatefulWidget {
  final List<_PageItem> items;

  const _PageCard({required this.items});

  @override
  State<_PageCard> createState() => _PageCardState();
}

class _PageCardState extends State<_PageCard> {
  final double _dividerHeight = 8;
  final double _buttonHeight = 50;

  double _handleHeight() {
    if (widget.items.length == 1) {
      return _buttonHeight;
    }
    return (_buttonHeight * widget.items.length) +
        (_dividerHeight * (widget.items.length - 1));
  }

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    final typography = Theme.of(context).textTheme;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: SingleChildScrollView(
        physics: const NeverScrollableScrollPhysics(),
        child: Column(
          children: [
            Container(
              height: _handleHeight(),
              decoration: BoxDecoration(
                color: colors.surfaceContainerLow,
                borderRadius: BorderRadius.circular(8),
              ),
              child: ListView.separated(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: widget.items.length,
                  separatorBuilder: (context, index) => Divider(
                        height: 8,
                        color: colors.onSurface.withValues(alpha: 0.4),
                        indent: 8,
                        endIndent: 8,
                      ),
                  itemBuilder: (context, index) {
                    final item = widget.items[index];
                    return SizedBox(
                      height: 50,
                      child: FalaTuSplashEffect(
                        onTap: item.onTap,
                        borderRadius: BorderRadius.circular(8),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            FalaTuIcon(icon: item.icon, color: colors.primary),
                            8.pw,
                            Expanded(
                              child: Text(
                                item.label,
                                style: typography.titleMedium!
                                    .copyWith(color: colors.primary),
                              ),
                            )
                          ],
                        ),
                      ),
                    );
                  }),
            ),
          ],
        ),
      ),
    );
  }
}

class _Header extends StatelessWidget {
  final String title;

  const _Header({required this.title});

  @override
  Widget build(BuildContext context) {
    final typography = Theme.of(context).textTheme;
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: FalaTuButton(
              label: context.i18n.cancel,
              type: ButtonType.text,
              onTap: () => Modular.to.pop(),
            ),
          ),
          Expanded(
            flex: 2,
            child: Text(title,
                textAlign: TextAlign.center,
                style: typography.titleMedium!.copyWith(
                  fontWeight: FontWeight.w700,
                )),
          ),
          const Spacer(),
        ],
      ),
    );
  }
}
