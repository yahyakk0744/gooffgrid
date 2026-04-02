import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../config/theme.dart';
import '../models/story_comment.dart';
import '../providers/stories_provider.dart';
import '../services/haptic_service.dart';

class StoryCommentsSheet extends ConsumerStatefulWidget {
  const StoryCommentsSheet({super.key, required this.storyId});

  final String storyId;

  @override
  ConsumerState<StoryCommentsSheet> createState() => _StoryCommentsSheetState();
}

class _StoryCommentsSheetState extends ConsumerState<StoryCommentsSheet> {
  final _controller = TextEditingController();
  final _focusNode = FocusNode();
  String? _replyToId;
  String? _replyToUsername;
  bool _isSending = false;

  @override
  void dispose() {
    _controller.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final commentsAsync = ref.watch(storyCommentsProvider(widget.storyId));

    return DraggableScrollableSheet(
      initialChildSize: 0.6,
      maxChildSize: 0.9,
      minChildSize: 0.3,
      builder: (context, scrollController) {
        return ClipRRect(
          borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 24, sigmaY: 24),
            child: Container(
              decoration: BoxDecoration(
                color: const Color(0xFF121218).withValues(alpha: 0.95),
                borderRadius:
                    const BorderRadius.vertical(top: Radius.circular(20)),
                border: Border(
                  top: BorderSide(
                    color: Colors.white.withValues(alpha: 0.1),
                  ),
                ),
              ),
              child: Column(
                children: [
                  // Handle + Header
                  _buildHeader(commentsAsync),

                  // Comments list
                  Expanded(
                    child: commentsAsync.when(
                      data: (comments) => comments.isEmpty
                          ? _buildEmptyState()
                          : ListView.builder(
                              controller: scrollController,
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 16, vertical: 8),
                              itemCount: comments.length,
                              itemBuilder: (_, i) =>
                                  _CommentTile(
                                    comment: comments[i],
                                    onReply: () => _setReplyTarget(
                                      comments[i].id,
                                      comments[i].username,
                                    ),
                                  ),
                            ),
                      loading: () => const Center(
                        child: CircularProgressIndicator(
                            color: AppColors.neonGreen),
                      ),
                      error: (_, __) => _buildEmptyState(),
                    ),
                  ),

                  // Input bar
                  _buildInputBar(),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildHeader(AsyncValue<List<StoryComment>> commentsAsync) {
    final count = commentsAsync.valueOrNull?.length ?? 0;
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 12, 8, 8),
      child: Column(
        children: [
          Center(
            child: Container(
              width: 36,
              height: 4,
              decoration: BoxDecoration(
                color: AppColors.textTertiary,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Text('Yorumlar', style: AppTextStyles.h2),
              const SizedBox(width: 8),
              Text('$count', style: AppTextStyles.bodySecondary),
              const Spacer(),
              IconButton(
                icon: const Icon(Icons.close_rounded,
                    color: AppColors.textSecondary),
                onPressed: () => Navigator.pop(context),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.chat_bubble_outline_rounded,
              size: 48,
              color: AppColors.textTertiary.withValues(alpha: 0.4)),
          const SizedBox(height: 12),
          const Text('Henuz yorum yok', style: AppTextStyles.bodySecondary),
          const SizedBox(height: 4),
          Text(
            'Ilk yorumu sen yap!',
            style: TextStyle(
                fontSize: 12, color: AppColors.textTertiary),
          ),
        ],
      ),
    );
  }

  Widget _buildInputBar() {
    return Container(
      padding: EdgeInsets.fromLTRB(
          16, 8, 8, MediaQuery.of(context).viewInsets.bottom + 12),
      decoration: BoxDecoration(
        color: const Color(0xFF1A1A22),
        border: Border(
          top: BorderSide(color: AppColors.cardBorder.withValues(alpha: 0.5)),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (_replyToUsername != null)
            Padding(
              padding: const EdgeInsets.only(bottom: 6),
              child: Row(
                children: [
                  Text(
                    '@$_replyToUsername\'e yanit yaziyorsun',
                    style: const TextStyle(
                        fontSize: 12, color: AppColors.neonGreen),
                  ),
                  const SizedBox(width: 4),
                  GestureDetector(
                    onTap: _clearReply,
                    child: const Icon(Icons.close_rounded,
                        size: 16, color: AppColors.textTertiary),
                  ),
                ],
              ),
            ),
          Row(
            children: [
              Expanded(
                child: TextField(
                  controller: _controller,
                  focusNode: _focusNode,
                  style:
                      const TextStyle(fontSize: 14, color: AppColors.textPrimary),
                  decoration: InputDecoration(
                    hintText: 'Yorum yaz...',
                    hintStyle: TextStyle(color: AppColors.textTertiary),
                    filled: true,
                    fillColor: AppColors.cardBorder.withValues(alpha: 0.3),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(24),
                      borderSide: BorderSide.none,
                    ),
                    contentPadding: const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 10),
                    isDense: true,
                  ),
                  maxLines: 3,
                  minLines: 1,
                ),
              ),
              const SizedBox(width: 8),
              GestureDetector(
                onTap: _isSending ? null : _sendComment,
                child: Container(
                  width: 40,
                  height: 40,
                  decoration: const BoxDecoration(
                    color: AppColors.neonGreen,
                    shape: BoxShape.circle,
                  ),
                  child: _isSending
                      ? const Padding(
                          padding: EdgeInsets.all(10),
                          child: CircularProgressIndicator(
                              strokeWidth: 2, color: Colors.black),
                        )
                      : const Icon(Icons.arrow_upward_rounded,
                          color: Colors.black, size: 22),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  void _setReplyTarget(String commentId, String username) {
    HapticService.light();
    setState(() {
      _replyToId = commentId;
      _replyToUsername = username;
    });
    _focusNode.requestFocus();
  }

  void _clearReply() {
    setState(() {
      _replyToId = null;
      _replyToUsername = null;
    });
  }

  Future<void> _sendComment() async {
    final text = _controller.text.trim();
    if (text.isEmpty) return;

    setState(() => _isSending = true);
    HapticService.light();

    try {
      await addStoryComment(
        widget.storyId,
        text,
        parentId: _replyToId,
      );
      _controller.clear();
      _clearReply();
      ref.invalidate(storyCommentsProvider(widget.storyId));
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: const Text('Uygunsuz icerik tespit edildi'),
            backgroundColor: AppColors.ringDanger,
          ),
        );
      }
    } finally {
      if (mounted) setState(() => _isSending = false);
    }
  }
}

class _CommentTile extends StatelessWidget {
  const _CommentTile({required this.comment, required this.onReply});

  final StoryComment comment;
  final VoidCallback onReply;

  @override
  Widget build(BuildContext context) {
    final isReply = comment.parentId != null;

    return Padding(
      padding: EdgeInsets.only(
        left: isReply ? 32 : 0,
        bottom: 16,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Avatar
          Container(
            width: 32,
            height: 32,
            decoration: BoxDecoration(
              color: comment.avatarColor ?? AppColors.textTertiary,
              shape: BoxShape.circle,
            ),
            child: Center(
              child: Text(
                comment.username.isNotEmpty
                    ? comment.username[0].toUpperCase()
                    : '?',
                style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: Colors.white),
              ),
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      comment.username,
                      style: const TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w600,
                          color: AppColors.textPrimary),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      comment.timeAgo,
                      style: const TextStyle(
                          fontSize: 11, color: AppColors.textTertiary),
                    ),
                  ],
                ),
                const SizedBox(height: 2),
                if (isReply && comment.parentUsername != null)
                  Padding(
                    padding: const EdgeInsets.only(bottom: 2),
                    child: Text(
                      '\u21b3 @${comment.parentUsername}\'e yanit',
                      style: const TextStyle(
                          fontSize: 11, color: AppColors.neonGreen),
                    ),
                  ),
                Text(
                  comment.content,
                  style: const TextStyle(
                      fontSize: 13, color: AppColors.textPrimary, height: 1.4),
                ),
                const SizedBox(height: 4),
                GestureDetector(
                  onTap: onReply,
                  child: const Text(
                    'Yanit ver',
                    style: TextStyle(
                        fontSize: 11,
                        color: AppColors.textSecondary,
                        fontWeight: FontWeight.w500),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
