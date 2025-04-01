import "package:cross_file/cross_file.dart";
import "package:falatu_mobile/chat/core/domain/entities/message/file_message_entity.dart";
import "package:falatu_mobile/chat/ui/components/messages/message_container.dart";
import "package:falatu_mobile/commons/ui/blocs/download_file_bloc.dart";
import "package:falatu_mobile/commons/ui/blocs/share_bloc/share_files_bloc.dart";
import "package:falatu_mobile/commons/ui/blocs/share_bloc/share_state.dart";
import "package:falatu_mobile/commons/ui/components/falatu_icon.dart";
import "package:falatu_mobile/commons/ui/components/falatu_image.dart";
import "package:falatu_mobile/commons/ui/components/falatu_shimmer.dart";
import "package:falatu_mobile/commons/utils/enums/file_extension_enum.dart";
import "package:falatu_mobile/commons/utils/enums/icons_enum.dart";
import "package:falatu_mobile/commons/utils/extensions/context_extensions.dart";
import "package:falatu_mobile/commons/utils/extensions/file_extensions.dart";
import "package:falatu_mobile/commons/utils/extensions/num_extensions.dart";
import "package:falatu_mobile/commons/utils/helpers/file_helper.dart";
import "package:falatu_mobile/commons/utils/states/base_state.dart";
import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:flutter_modular/flutter_modular.dart";

class FileMessageCard extends StatefulWidget {
  final FileMessageEntity message;
  final bool isMe;

  const FileMessageCard({required this.message, required this.isMe, super.key});

  @override
  State<FileMessageCard> createState() => _FileMessageCardState();
}

class _FileMessageCardState extends State<FileMessageCard> {
  late final ShareFilesBloc _share;
  late final DownloadFileBloc _download;

  @override
  void initState() {
    super.initState();
    _share = Modular.get<ShareFilesBloc>();
    _download = Modular.get<DownloadFileBloc>();

    _download.call(widget.message.mediaUrl);
  }


  @override
  Widget build(BuildContext context) {
    final typography = Theme.of(context).textTheme;
    final colors = Theme.of(context).colorScheme;
    final maxWidth = MediaQuery.of(context).size.width * 0.7;
    return Align(
      alignment: widget.isMe ? Alignment.centerRight : Alignment.centerLeft,
      child: MessageContainer(
        createdAt: widget.message.createdAt,
        maxWidth: maxWidth,
        wasSeen: false,
        isMe: widget.isMe,
        content: SizedBox(
          height: 46,
          width: maxWidth,
          child: BlocBuilder<DownloadFileBloc, BaseState>(
              bloc: _download,
              builder: (context, state) {
                if (state is ErrorState) {
                  return const _Error();
                } else if (state is SuccessState<XFile>) {
                  return Row(
                    children: [
                      FalaTuImage.asset(
                        image: FileHelper.getIconByFileExtension(
                          FileExtensionsEnum.fromName(state.data.extension),
                        ),
                      ),
                      4.pw,
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Text(
                              state.data.fileName,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: typography.bodyLarge!
                                  .copyWith(color: colors.onSurface),
                            ),
                            Text(
                              "${state.data.extension.toUpperCase()}  •  ${FileHelper.bytesConverter(state.data.lengthSync())}",
                              overflow: TextOverflow.ellipsis,
                              style: typography.bodySmall!
                                  .copyWith(color: colors.onSurface),
                            ),
                          ],
                        ),
                      ),
                      8.pw,
                      BlocBuilder<ShareFilesBloc, ShareState>(
                        bloc: _share,
                        builder: (context, shareState) {
                          if (shareState is ShareLoadingState) {
                            return SizedBox.square(
                              dimension: 40,
                              child: Padding(
                                padding: const EdgeInsets.all(5.0),
                                child: CircularProgressIndicator(
                                    color: colors.onSurface),
                              ),
                            );
                          }
                          return SizedBox.square(
                            dimension: 40,
                            child: FalaTuIcon(
                              icon: FalaTuIconsEnum.downloadFilled,
                              onTap: () => _share.call(file: state.data),
                              color: colors.onSurface,
                            ),
                          );
                        },
                      ),
                    ],
                  );
                }
                return _Loading();
              }),
        ),
      ),
    );
  }
}

class _Loading extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const FalaTuShimmer.rectangle(height: 50, width: 35),
        8.pw,
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const FalaTuShimmer.rectangle(height: 15),
              4.ph,
              const FalaTuShimmer.rectangle(height: 10, width: 70),
            ],
          ),
        ),
        8.pw,
        const FalaTuShimmer.circle(size: 40),
      ],
    );
  }
}

class _Error extends StatelessWidget {
  const _Error();

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    return Row(
      children: [
        FalaTuIcon(
          icon: FalaTuIconsEnum.error,
          color: colors.error,
          size: 36,
        ),
        8.pw,
        Expanded(
          child: Text(context.i18n.fileNotFoundError),
        ),
      ],
    );
  }
}
