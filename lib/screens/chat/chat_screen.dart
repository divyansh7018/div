import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';

import '../../core/theme/app_theme.dart';
import '../../providers/chat_provider.dart';
import '../../widgets/scale_tap.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final _controller = TextEditingController();
  final _scrollController = ScrollController();

  @override
  void dispose() {
    _controller.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<ChatProvider>();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(_scrollController.position.maxScrollExtent, duration: const Duration(milliseconds: 250), curve: Curves.easeOut);
      }
    });

    return SafeArea(
      child: Column(
        children: [
          if (provider.patternSuggestion != null)
            Padding(
              padding: const EdgeInsets.all(12),
              child: GlassCard(child: Text(provider.patternSuggestion!)),
            ),
          Expanded(
            child: ListView.builder(
              controller: _scrollController,
              itemCount: provider.messages.length + (provider.isLoading ? 1 : 0),
              itemBuilder: (context, index) {
                if (index >= provider.messages.length) {
                  return Padding(
                    padding: const EdgeInsets.all(12),
                    child: Shimmer.fromColors(
                      baseColor: Colors.grey.shade300,
                      highlightColor: Colors.grey.shade100,
                      child: Container(height: 44, decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(14))),
                    ),
                  );
                }
                final msg = provider.messages[index];
                return TweenAnimationBuilder<double>(
                  tween: Tween(begin: 20, end: 0),
                  duration: const Duration(milliseconds: 260),
                  builder: (_, offset, child) => Transform.translate(offset: Offset(0, offset), child: child),
                  child: Align(
                    alignment: msg.isUser ? Alignment.centerRight : Alignment.centerLeft,
                    child: Container(
                      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                      padding: const EdgeInsets.all(12),
                      constraints: const BoxConstraints(maxWidth: 300),
                      decoration: BoxDecoration(
                        color: msg.isUser ? Theme.of(context).colorScheme.primary.withOpacity(0.2) : Theme.of(context).colorScheme.surface,
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Text(msg.text),
                    ),
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: EdgeInsets.only(
              left: 12,
              right: 12,
              top: 8,
              bottom: MediaQuery.viewInsetsOf(context).bottom + 10,
            ),
            child: Row(
              children: [
                Expanded(child: TextField(controller: _controller, decoration: const InputDecoration(hintText: 'Share what\'s on your mind...'))),
                const SizedBox(width: 10),
                ScaleTap(
                  onTap: () {
                    context.read<ChatProvider>().sendMessage(_controller.text);
                    _controller.clear();
                  },
                  child: const CircleAvatar(child: Icon(Icons.send_rounded)),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
