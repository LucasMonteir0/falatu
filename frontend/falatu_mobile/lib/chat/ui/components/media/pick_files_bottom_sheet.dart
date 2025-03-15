import "package:falatu_mobile/chat/core/domain/entities/message/send/send_file_message_entity.dart";
import "package:falatu_mobile/chat/ui/blocs/send_message/send_messge_bloc.dart";
import "package:falatu_mobile/commons/core/domain/services/file_picker_service/file_picker_service.dart";
import "package:falatu_mobile/commons/core/domain/services/shared_preferences_services/shared_preferences_services.dart";
import "package:falatu_mobile/commons/ui/components/falatu_bottom_sheet.dart";
import "package:falatu_mobile/commons/ui/components/falatu_icon.dart";
import "package:falatu_mobile/commons/ui/components/falatu_splash_effect.dart";
import "package:falatu_mobile/commons/utils/enums/icons_enum.dart";
import "package:falatu_mobile/commons/utils/extensions/context_extensions.dart";
import "package:falatu_mobile/commons/utils/extensions/num_extensions.dart";
import "package:falatu_mobile/commons/utils/states/base_state.dart";
import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:flutter_modular/flutter_modular.dart";

class PickFilesBottomSheet extends StatefulWidget {
  final String chatId;

  PickFilesBottomSheet.show(
    BuildContext context, {
    required this.chatId,
    super.key,
  }) {
    FalaTuBottomSheet.show(context: context, child: this);
  }

  @override
  State<PickFilesBottomSheet> createState() => _PickFilesBottomSheetState();
}

class _PickFilesBottomSheetState extends State<PickFilesBottomSheet> {
  late final SendMessageBloc _sendMessageBloc = Modular.get<SendMessageBloc>();

  late final FilePickerService _picker = Modular.get<FilePickerService>();
  late final String _userId =
      Modular.get<SharedPreferencesService>().getUserId()!;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _SheetItem(
              icon: FalaTuIconsEnum.image,
              text: context.i18n.gallery,
              color: colors.primaryContainer,
              onTap: () => FalaTuBottomSheet.show(
                context: context,
                child: SafeArea(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        _SheetItem(
                          color: colors.primaryContainer,
                          icon: FalaTuIconsEnum.image,
                          text: context.i18n.photos,
                          onTap: () async {
                            final files =
                                await _picker.multipleImagesFromGallery();
                            if (files.isNotEmpty) {
                              // Modular.to.pushNamed(
                              //   ResigoRoutes.chatModule +
                              //       ResigoRoutes.mediaEditingPage,
                              //   arguments: MediaEditingPageParams(
                              //     medias: files,
                              //     type: FileTypeEnum.image,
                              //     senderId: widget.senderId,
                              //     chatId: widget.chatId,
                              //   ),
                              // );
                            }
                          },
                        ),
                        _SheetItem(
                          color: colors.primaryContainer,
                          icon: FalaTuIconsEnum.image,
                          text: context.i18n.videos,
                          onTap: () async {
                            final file = await _picker.videoFromGallery();
                            if (file != null) {
                              // Modular.to.pushNamed(
                              //   ResigoRoutes.chatModule +
                              //       ResigoRoutes.mediaEditingPage,
                              //   arguments: MediaEditingPageParams(
                              //     medias: [file],
                              //     type: FileTypeEnum.video,
                              //     senderId: widget.senderId,
                              //     chatId: widget.chatId,
                              //   ),
                              // );
                            }
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            _SheetItem(
              icon: FalaTuIconsEnum.image,
              text: context.i18n.camera,
              color: colors.secondaryContainer,
              onTap: () {
                FalaTuBottomSheet.show(
                  context: context,
                  child: SafeArea(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 16.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          _SheetItem(
                            color: colors.secondaryContainer,
                            icon: FalaTuIconsEnum.image,
                            text: context.i18n.photo,
                            onTap: () async {
                              final file = await _picker.imageFromCamera();
                              if (file != null) {
                                // Modular.to.pushNamed(
                                //   ResigoRoutes.chatModule +
                                //       ResigoRoutes.mediaEditingPage,
                                //   arguments: MediaEditingPageParams(
                                //     medias: [file],
                                //     type: FileTypeEnum.image,
                                //     senderId: widget.senderId,
                                //     chatId: widget.chatId,
                                //   ),
                                // );
                              }
                            },
                          ),
                          _SheetItem(
                            color: colors.secondaryContainer,
                            icon: FalaTuIconsEnum.image,
                            text: context.i18n.video,
                            onTap: () async {
                              final file = await _picker.videoFromCamera();
                              if (file != null) {
                                // Modular.to.pushNamed(
                                //   ResigoRoutes.chatModule +
                                //       ResigoRoutes.mediaEditingPage,
                                //   arguments: MediaEditingPageParams(
                                //     medias: [file],
                                //     type: FileTypeEnum.video,
                                //     senderId: widget.senderId,
                                //     chatId: widget.chatId,
                                //     isVideoFromCamera: true,
                                //   ),
                                // );
                              }
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
            BlocListener<SendMessageBloc, BaseState>(
              bloc: _sendMessageBloc,
              listener: (context, state) {
                // if (state is ErrorState &&
                //     state.exception is DocumentSizeExceededError) {
                //   ToastHelper.show(
                //     context,
                //     message: state.message,
                //     status: ToastStatus.error,
                //     id: "file-validator",
                //   );
                // }
              },
              child: _SheetItem(
                color: colors.surfaceTint,
                icon: FalaTuIconsEnum.image,
                text: context.i18n.files,
                onTap: () async {
                  final file = await _picker.document();
                  if (file != null) {
                    final message = SendFileMessageEntity(
                        mediaFile: file, senderId: _userId);
                    _sendMessageBloc.call(widget.chatId, message);
                    if (context.mounted) {
                      Modular.to.pop(context);
                    }
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _SheetItem extends StatelessWidget {
  final FalaTuIconsEnum icon;
  final String text;
  final void Function()? onTap;
  final Color color;

  const _SheetItem({
    required this.icon,
    required this.text,
    required this.color,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final typography = Theme.of(context).textTheme;
    final colors = Theme.of(context).colorScheme;
    return FalaTuSplashEffect(
      onTap: onTap,
      backgroundColor: color,
      borderRadius: BorderRadius.circular(20.0),
      child: SizedBox.square(
        dimension: 60,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            FalaTuIcon(icon: icon, color: colors.surfaceBright, size: 24),
            8.ph,
            Flexible(
              child: Text(
                text,
                maxLines: 2,
                style: typography.bodySmall!.copyWith(
                    color: colors.surfaceBright, fontWeight: FontWeight.w600),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
