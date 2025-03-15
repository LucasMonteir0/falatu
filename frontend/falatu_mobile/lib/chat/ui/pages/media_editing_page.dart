// import 'dart:io';
//
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_modular/flutter_modular.dart';
// import 'package:resigo_design_system/resigo_design_system.dart';
// import 'package:resigo_mobile_preceptor/app/data/services/local/pick_file/pick_file.dart';
// import 'package:resigo_mobile_preceptor/app/modules/chat/data/dtos/send_message_dto.dart';
// import 'package:resigo_mobile_preceptor/app/modules/chat/ui/blocs/send_message_bloc/send_message_bloc.dart';
// import 'package:resigo_mobile_preceptor/app/modules/chat/ui/components/video_player.dart';
// import 'package:resigo_mobile_preceptor/commons/errors/file_size_exceeded_error.dart';
// import 'package:resigo_mobile_preceptor/commons/resigo_ui/enums/file_type.dart';
// import 'package:resigo_mobile_preceptor/commons/resigo_ui/extensions/num_extensions.dart';
// import 'package:resigo_mobile_preceptor/commons/resigo_ui/helpers/file_helper.dart';
// import 'package:resigo_mobile_preceptor/commons/resigo_ui/helpers/toast_helper.dart';
// import 'package:resigo_mobile_preceptor/commons/states/base_state.dart';
//
// class MediaEditingPageParams {
//   final List<File> medias;
//   final FileTypeEnum type;
//   final String senderId;
//   final String chatId;
//   final bool isVideoFromCamera;
//
//   MediaEditingPageParams({
//     required this.medias,
//     required this.type,
//     required this.senderId,
//     required this.chatId,
//     this.isVideoFromCamera = false,
//   });
// }
//
// class MediaEditingPage extends StatefulWidget {
//   final MediaEditingPageParams params;
//
//   const MediaEditingPage({Key? key, required this.params}) : super(key: key);
//
//   @override
//   State<MediaEditingPage> createState() => _MediaEditingPageState();
// }
//
// class _MediaEditingPageState extends State<MediaEditingPage> {
//   late final ValueNotifier<List<File>> _selectedFiles;
//
//   late final PageController _pageController;
//
//   final ValueNotifier<int> _currentIndex = ValueNotifier(0);
//   final ScrollController _scrollController = ScrollController();
//   late final SendMessageBloc _sendMessageBloc;
//   bool isLoading = false;
//
//   @override
//   void initState() {
//     super.initState();
//     _selectedFiles = ValueNotifier<List<File>>(widget.params.medias);
//     _pageController = PageController();
//
//     _sendMessageBloc = Modular.get<SendMessageBloc>();
//   }
//
//   @override
//   void dispose() {
//     _pageController.dispose();
//     _currentIndex.dispose();
//     _scrollController.dispose();
//     super.dispose();
//   }
//
//   void _changePage(int index) {
//     _pageController.jumpToPage(index);
//     _currentIndex.value = index;
//   }
//
//   void _deleteFile() {
//     final updatedFiles = List<File>.from(_selectedFiles.value);
//     updatedFiles.removeAt(_currentIndex.value);
//
//     _selectedFiles.value = updatedFiles;
//
//     if (_currentIndex.value >= _selectedFiles.value.length) {
//       _changePage(_selectedFiles.value.length - 1);
//     } else {
//       _changePage(_currentIndex.value);
//     }
//   }
//
//   void _sendMessage() async {
//     for (var e in _selectedFiles.value) {
//       dynamic message;
//       if (widget.params.type == FileTypeEnum.image) {
//         message =
//             SendImageMessageDTO(image: e, senderId: widget.params.senderId);
//       }
//       if (widget.params.type == FileTypeEnum.video) {
//         message = SendVideoMessageDTO(
//           video: e,
//           thumb: (await FileHelper.getThumbnailFile(e.path))!,
//           senderId: widget.params.senderId,
//           isFromCamera: widget.params.isVideoFromCamera,
//         );
//       }
//       _sendMessageBloc.call(message: message, chatId: widget.params.chatId);
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     final size = MediaQuery.of(context).size;
//     return Container(
//       height: double.infinity,
//       width: double.infinity,
//       color: Colors.black54,
//       child: ValueListenableBuilder<List<File>>(
//           valueListenable: _selectedFiles,
//           builder: (context, medias, _) {
//             return Scaffold(
//               extendBodyBehindAppBar: true,
//               backgroundColor: Colors.black54,
//               appBar: AppBar(
//                 backgroundColor: Colors.transparent,
//                 elevation: 0,
//                 actions: [
//                   if (widget.params.type == FileTypeEnum.image &&
//                       medias.length > 1)
//                     Padding(
//                       padding: const EdgeInsets.all(6.0),
//                       child: ResiGoIcon.button(
//                         ResiGoIcons.trash_outline,
//                         size: 26,
//                         color: ResiGoColors.surfaceBC_50,
//                         onTap: _deleteFile,
//                       ),
//                     ),
//                 ],
//               ),
//               body: SizedBox(
//                 height: double.infinity,
//                 width: size.width,
//                 child: Stack(
//                   alignment: Alignment.topCenter,
//                   children: [
//                     PageView.builder(
//                       scrollDirection: Axis.horizontal,
//                       controller: _pageController,
//                       itemCount: medias.length,
//                       onPageChanged: (value) => _currentIndex.value = value,
//                       itemBuilder: (context, index) {
//                         final file = medias[index];
//                         if (widget.params.type == FileTypeEnum.image) {
//                           return Image.file(file, fit: BoxFit.contain);
//                         } else if (widget.params.type == FileTypeEnum.video) {
//                           return VideoPlayer.file(file: medias.first);
//                         }
//                         return const Text('Erro ao carregar o arquivo');
//                       },
//                     ),
//                     Positioned(
//                       bottom: 15.0,
//                       child: SafeArea(
//                         child: Column(
//                           children: [
//                             if (widget.params.type == FileTypeEnum.image &&
//                                 medias.length > 1)
//                               ValueListenableBuilder<int>(
//                                   valueListenable: _currentIndex,
//                                   builder: (context, value, _) {
//                                     return _SelectedItemsCard(
//                                       medias: medias,
//                                       selectedIndex: value,
//                                       onItemTap: (index) => _changePage(index),
//                                       controller: _scrollController,
//                                     );
//                                   }),
//                             8.ph,
//                             Container(
//                               width: size.width,
//                               padding:
//                                   const EdgeInsets.symmetric(horizontal: 16),
//                               child: Row(
//                                 mainAxisAlignment:
//                                     MainAxisAlignment.spaceBetween,
//                                 children: [
//                                   widget.params.type == FileTypeEnum.image
//                                       ? Container(
//                                           padding: const EdgeInsets.all(2),
//                                           decoration: BoxDecoration(
//                                             color:
//                                                 Colors.black.withOpacity(0.4),
//                                             shape: BoxShape.circle,
//                                           ),
//                                           child: ResiGoIcon.button(
//                                               ResiGoIcons.images,
//                                               color: ResiGoColors.surfaceBC_50,
//                                               onTap: () async {
//                                             final files = await PickFile
//                                                 .multipleImagesFromGallery();
//                                             if (files.isNotEmpty) {
//                                               _selectedFiles.value
//                                                   .addAll(files);
//                                               _changePage(medias.length - 1);
//                                               _selectedFiles.notifyListeners();
//                                             }
//                                           }),
//                                         )
//                                       : const SizedBox.square(dimension: 30.0),
//                                   BlocConsumer<SendMessageBloc, BaseState>(
//                                       bloc: _sendMessageBloc,
//                                       listener: (context, state) {
//                                         if (state is SuccessState) {
//                                           Modular.to.pop();
//                                           Navigator.pop(context);
//                                           Navigator.pop(context);
//                                         } else if (state is ErrorState &&
//                                             state.exception
//                                                 is FileSizeExceededError) {
//                                           ToastHelper.show(
//                                             context,
//                                             message: state.message,
//                                             status: ToastStatus.error,
//                                             id: 'file-validator'
//                                           );
//                                         }
//                                       },
//                                       builder: (context, state) {
//                                         if (state is LoadingState) {
//                                           return const Padding(
//                                             padding:
//                                                 EdgeInsets.only(right: 12.0),
//                                             child: SizedBox.square(
//                                               dimension: 26,
//                                               child: CircularProgressIndicator(
//                                                 color:
//                                                     ResiGoColors.surfaceBC_50,
//                                               ),
//                                             ),
//                                           );
//                                         }
//                                         return Container(
//                                           padding: const EdgeInsets.all(2),
//                                           decoration: BoxDecoration(
//                                             color:
//                                                 Colors.black.withOpacity(0.4),
//                                             shape: BoxShape.circle,
//                                           ),
//                                           child: ResiGoIcon.button(
//                                             ResiGoIcons.send,
//                                             color: ResiGoColors.surfaceBC_50,
//                                             onTap: _sendMessage,
//                                           ),
//                                         );
//                                       }),
//                                 ],
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//                     )
//                   ],
//                 ),
//               ),
//             );
//           }),
//     );
//   }
// }
//
// class _SelectedItemsCard extends StatefulWidget {
//   final List<File> medias;
//   final void Function(int index) onItemTap;
//   final int selectedIndex;
//   final ScrollController controller;
//
//   const _SelectedItemsCard(
//       {Key? key,
//       required this.medias,
//       required this.onItemTap,
//       required this.selectedIndex,
//       required this.controller})
//       : super(key: key);
//
//   @override
//   State<_SelectedItemsCard> createState() => _SelectedItemsCardState();
// }
//
// class _SelectedItemsCardState extends State<_SelectedItemsCard> {
//   @override
//   Widget build(BuildContext context) {
//     final size = MediaQuery.of(context).size;
//     return SingleChildScrollView(
//       child: SizedBox(
//         height: 50,
//         width: size.width,
//         child: ListView.builder(
//           scrollDirection: Axis.horizontal,
//           padding: const EdgeInsets.symmetric(horizontal: 4),
//           controller: widget.controller,
//           itemCount: widget.medias.length,
//           itemBuilder: (context, index) {
//             return GestureDetector(
//               onTap: () => widget.onItemTap(index),
//               child: Padding(
//                 padding: const EdgeInsets.symmetric(horizontal: 2.0),
//                 child: ClipRRect(
//                   borderRadius: BorderRadius.circular(8.0),
//                   clipBehavior: Clip.antiAlias,
//                   child: Container(
//                     width: 50.0,
//                     clipBehavior: Clip.antiAlias,
//                     decoration: BoxDecoration(
//                         borderRadius:
//                             const BorderRadius.all(Radius.circular(8.0)),
//                         border: widget.selectedIndex == index
//                             ? Border.all(width: 2, color: Colors.blue)
//                             : Border.all(color: Colors.transparent),
//                         image: DecorationImage(
//                           fit: BoxFit.cover,
//                           image: FileImage(widget.medias[index]),
//                         )),
//                   ),
//                 ),
//               ),
//             );
//           },
//         ),
//       ),
//     );
//   }
// }
