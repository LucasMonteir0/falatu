import "package:falatu_mobile/chat/core/domain/entities/message/file_message_entity.dart";
import "package:falatu_mobile/chat/ui/components/messages/message_container.dart";
import "package:falatu_mobile/commons/ui/blocs/share_bloc/share_files_bloc.dart";
import "package:falatu_mobile/commons/ui/blocs/share_bloc/share_state.dart";
import "package:falatu_mobile/commons/ui/components/falatu_icon.dart";
import "package:falatu_mobile/commons/ui/components/falatu_image.dart";
import "package:falatu_mobile/commons/utils/enums/file_extension_enum.dart";
import "package:falatu_mobile/commons/utils/enums/icons_enum.dart";
import "package:falatu_mobile/commons/utils/extensions/file_extensions.dart";
import "package:falatu_mobile/commons/utils/extensions/num_extensions.dart";
import "package:falatu_mobile/commons/utils/helpers/file_helper.dart";
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

  @override
  void initState() {
    super.initState();
    _share = Modular.get<ShareFilesBloc>();
  }

  @override
  Widget build(BuildContext context) {
    final typography = Theme.of(context).textTheme;
    final colors = Theme.of(context).colorScheme;
    return Align(
      alignment: widget.isMe ? Alignment.centerRight : Alignment.centerLeft,
      child: MessageContainer(
        createdAt: widget.message.createdAt,
        wasSeen: false,
        isMe: widget.isMe,
        content: Builder(builder: (context) {
          if (widget.message.file == null) {
            return const SizedBox.shrink();
          }
          return SizedBox(
            height: 46,
            child: Row(
              children: [
                FalaTuImage.asset(
                  image: FileHelper.getIconByFileExtension(
                    FileExtensionsEnum.fromName(widget.message.file!.extension),
                  ),
                ),
                4.pw,
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Text(
                        widget.message.file!.fileName,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: typography.bodyLarge!
                            .copyWith(color: colors.onSurface),
                      ),
                      Text(
                        "${widget.message.file!.extension.toUpperCase()}  •  ${FileHelper.bytesConverter(widget.message.file!.lengthSync())}",
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
                  builder: (context, state) {
                    if (state is ShareLoadingState) {
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
                        onTap: () => _share.call(file: widget.message.file!),
                        color: colors.onSurface,
                      ),
                    );
                  },
                ),
              ],
            ),
          );
        }),
      ),
    );
  }
}
