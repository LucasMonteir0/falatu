import "package:cross_file/cross_file.dart";
import "package:falatu_mobile/chat/core/domain/entities/message/send/send_image_message_entity.dart";
import "package:falatu_mobile/chat/core/domain/entities/message/send/send_message_entity.dart";
import "package:falatu_mobile/chat/core/domain/entities/message/send/send_video_message_entity.dart";
import "package:falatu_mobile/chat/ui/blocs/send_message/send_messge_bloc.dart";
import "package:falatu_mobile/chat/ui/components/media/falatu_video_player.dart";
import "package:falatu_mobile/commons/core/domain/services/file_picker_service/file_picker_service.dart";
import "package:falatu_mobile/commons/core/domain/services/shared_preferences_services/shared_preferences_services.dart";
import "package:falatu_mobile/commons/ui/components/falatu_icon.dart";
import "package:falatu_mobile/commons/ui/components/falatu_image.dart";
import "package:falatu_mobile/commons/ui/components/falatu_splash_effect.dart";
import "package:falatu_mobile/commons/utils/enums/icons_enum.dart";
import "package:falatu_mobile/commons/utils/extensions/context_extensions.dart";
import "package:falatu_mobile/commons/utils/extensions/num_extensions.dart";
import "package:falatu_mobile/commons/utils/helpers/file_helper.dart";
import "package:falatu_mobile/commons/utils/states/base_state.dart";
import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:flutter_modular/flutter_modular.dart";

enum MediaType {
  image,
  video;

  bool get isImage => this == MediaType.image;

  bool get isVideo => this == MediaType.video;
}

class MediaEditorPageParams {
  final List<XFile> medias;
  final MediaType type;
  final String chatId;
  final bool isVideoFromCamera;

  MediaEditorPageParams({
    required this.medias,
    required this.type,
    required this.chatId,
    this.isVideoFromCamera = false,
  });
}

class MediaEditorPage extends StatefulWidget {
  final MediaEditorPageParams params;

  const MediaEditorPage({required this.params, super.key});

  @override
  State<MediaEditorPage> createState() => _MediaEditorPageState();
}

class _MediaEditorPageState extends State<MediaEditorPage> {
  late final ValueNotifier<List<XFile>> _selectedFiles;

  late final PageController _pageController;
  late final TextEditingController _textController;

  final ValueNotifier<int> _currentIndex = ValueNotifier(0);
  final ScrollController _scrollController = ScrollController();
  late final SendMessageBloc _sendMessageBloc;
  late final FilePickerService _picker;
  late final SharedPreferencesService _preferences;

  @override
  void initState() {
    super.initState();
    _selectedFiles = ValueNotifier<List<XFile>>(widget.params.medias);
    _pageController = PageController();
    _textController = TextEditingController();

    _sendMessageBloc = Modular.get<SendMessageBloc>();
    _picker = Modular.get<FilePickerService>();
    _preferences = Modular.get<SharedPreferencesService>();
  }

  String get _userId => _preferences.getUserId()!;

  @override
  void dispose() {
    _pageController.dispose();
    _currentIndex.dispose();
    _scrollController.dispose();
    _textController.dispose();
    super.dispose();
  }

  void _changePage(int index) {
    _pageController.jumpToPage(index);
    _currentIndex.value = index;
  }

  void _deleteFile() {
    final updatedFiles = List<XFile>.from(_selectedFiles.value);
    updatedFiles.removeAt(_currentIndex.value);

    _selectedFiles.value = updatedFiles;

    if (_currentIndex.value >= _selectedFiles.value.length) {
      _changePage(_selectedFiles.value.length - 1);
    } else {
      _changePage(_currentIndex.value);
    }
  }

  String? _handleText() =>
      _textController.text.trim().isEmpty ? null : _textController.text;

  void _sendMessage() async {
    for (var e in _selectedFiles.value) {
      SendMessageEntity? message;
      String? text = _handleText();
      if (widget.params.type.isImage) {
        message =
            SendImageMessageEntity(mediaFile: e, senderId: _userId, text: text);
      }
      if (widget.params.type.isVideo) {
        message = SendVideoMessageEntity(
          mediaFile: e,
          text: text,
          thumbFile: (await FileHelper.getVideoThumbnail(e.path))!,
          senderId: _userId,
        );
      }
      if (message == null) {
        return;
      }
      _sendMessageBloc.call(widget.params.chatId, message);
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final colors = Theme.of(context).colorScheme;
    return Container(
      height: double.infinity,
      width: double.infinity,
      color: Colors.black54,
      child: ValueListenableBuilder<List<XFile>>(
          valueListenable: _selectedFiles,
          builder: (context, medias, _) {
            return Scaffold(
              extendBodyBehindAppBar: true,
              backgroundColor: Colors.black54,
              appBar: AppBar(
                backgroundColor: Colors.transparent,
                elevation: 0,
                actions: [
                  if (widget.params.type.isImage && medias.length > 1)
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: FalaTuSplashEffect(
                        backgroundColor:
                            colors.primaryContainer.withValues(alpha: 0.5),
                        borderRadius: BorderRadius.circular(100),
                        onTap: _deleteFile,
                        child: const FalaTuIcon(
                          icon: FalaTuIconsEnum.deleteFilled,
                          color: Colors.white,
                        ),
                      ),
                    ),
                ],
              ),
              body: SizedBox(
                height: double.infinity,
                width: size.width,
                child: Stack(
                  alignment: Alignment.topCenter,
                  children: [
                    PageView.builder(
                      controller: _pageController,
                      itemCount: medias.length,
                      onPageChanged: (value) => _currentIndex.value = value,
                      itemBuilder: (context, index) {
                        final file = medias[index];
                        if (widget.params.type.isImage) {
                          return FalaTuImage.xFile(file: file);
                        } else if (widget.params.type.isVideo) {
                          return FalaTuVideoPlayer.file(file: medias.first);
                        }
                        return Text(context.i18n.invalidFile);
                      },
                    ),
                    Positioned(
                      bottom: widget.params.type.isVideo ? 50.0 : 15.0,
                      child: SafeArea(
                        child: Column(
                          children: [
                            if (widget.params.type.isImage && medias.length > 1)
                              ValueListenableBuilder<int>(
                                  valueListenable: _currentIndex,
                                  builder: (context, value, _) {
                                    return _SelectedItemsCard(
                                      medias: medias,
                                      selectedIndex: value,
                                      onItemTap: (index) => _changePage(index),
                                      controller: _scrollController,
                                    );
                                  }),
                            8.ph,
                            Container(
                              width: size.width,
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 16),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  widget.params.type.isImage
                                      ? FalaTuSplashEffect(
                                          backgroundColor: colors
                                              .primaryContainer
                                              .withValues(alpha: 0.5),
                                          borderRadius:
                                              BorderRadius.circular(100),
                                          onTap: () async {
                                            final files = await _picker
                                                .multipleImagesFromGallery();
                                            if (files.isNotEmpty) {
                                              _selectedFiles.value = [
                                                ...medias,
                                                ...files
                                              ];
                                              _changePage(medias.length);
                                            }
                                          },
                                          child: const FalaTuIcon(
                                            icon: FalaTuIconsEnum.image,
                                            color: Colors.white,
                                          ),
                                        )
                                      : const SizedBox.square(dimension: 30.0),
                                  Expanded(
                                      child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 8.0),
                                    child: _TextField(
                                        controller: TextEditingController()),
                                  )),
                                  BlocConsumer<SendMessageBloc, BaseState>(
                                      bloc: _sendMessageBloc,
                                      listener: (context, state) {
                                        if (state is SuccessState) {
                                          Modular.to.pop();
                                          Navigator.pop(context);
                                        }
                                      },
                                      builder: (context, state) {
                                        if (state is LoadingState) {
                                          return const Padding(
                                            padding:
                                                EdgeInsets.only(right: 12.0),
                                            child: SizedBox.square(
                                              dimension: 26,
                                              child: CircularProgressIndicator(
                                                color: Colors.white,
                                              ),
                                            ),
                                          );
                                        }
                                        return FalaTuSplashEffect(
                                          backgroundColor: colors
                                              .primaryContainer
                                              .withValues(alpha: 0.5),
                                          borderRadius:
                                              BorderRadius.circular(100),
                                          onTap: _sendMessage,
                                          child: const FalaTuIcon(
                                            icon: FalaTuIconsEnum.sendFilled,
                                            color: Colors.white,
                                          ),
                                        );
                                      }),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
            );
          }),
    );
  }
}

class _SelectedItemsCard extends StatefulWidget {
  final List<XFile> medias;
  final void Function(int index) onItemTap;
  final int selectedIndex;
  final ScrollController controller;

  const _SelectedItemsCard({
    required this.medias,
    required this.onItemTap,
    required this.selectedIndex,
    required this.controller,
  });

  @override
  State<_SelectedItemsCard> createState() => _SelectedItemsCardState();
}

class _SelectedItemsCardState extends State<_SelectedItemsCard> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final colors = Theme.of(context).colorScheme;
    return SizedBox(
      height: 50,
      width: size.width,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 4),
        controller: widget.controller,
        itemCount: widget.medias.length,
        separatorBuilder: (context, index) => 6.pw,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () => widget.onItemTap(index),
            child: Container(
                width: 50.0,
                clipBehavior: Clip.antiAlias,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  border: widget.selectedIndex == index
                      ? Border.all(width: 2, color: colors.primary)
                      : Border.all(color: Colors.transparent),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(6),
                  child: FalaTuImage.xFile(
                    file: widget.medias[index],
                    fit: BoxFit.cover,
                  ),
                )),
          );
        },
      ),
    );
  }
}

class _TextField extends StatelessWidget {
  final TextEditingController controller;

  const _TextField({required this.controller});

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    return Container(
      clipBehavior: Clip.antiAlias,
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: colors.surface,
        border: Border.all(
          color: colors.primaryContainer.withValues(alpha: 0.5),
          width: 2,
        ),
        borderRadius: BorderRadius.circular(30.0),
      ),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
            isCollapsed: true,
            filled: false,
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4),
            hintText: context.i18n.writeYourMessage,
            border: InputBorder.none),
        minLines: 1,
        maxLines: 3,
      ),
    );
  }
}
