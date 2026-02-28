import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';

import '../constants.dart';

class CommunityChatScreen extends StatefulWidget {
  const CommunityChatScreen({super.key});

  @override
  State<CommunityChatScreen> createState() => _CommunityChatScreenState();
}

class _CommunityChatScreenState extends State<CommunityChatScreen>
    with TickerProviderStateMixin {
  final GlobalKey<AnimatedListState> _listKey = GlobalKey<AnimatedListState>();
  final ScrollController _scrollController = ScrollController();
  final TextEditingController _inputController = TextEditingController();
  final FocusNode _focusNode = FocusNode();

  final List<_ChatMessage> _messages = [];

  late final AnimationController _sendController;
  late final AnimationController _typingDotsController;

  Timer? _incomingTimer;
  Timer? _onlineUsersTimer;
  bool _isOtherTyping = false;
  int _onlineUsers = 128;

  final Random _random = Random();

  final List<String> _sampleUsers = const [
    'Ayesha',
    'Bilal',
    'Noor',
    'Hassan',
    'Sana',
    'Usman',
  ];

  final List<String> _sampleIncoming = const [
    'Please share donor eligibility tips for first-time donors.',
    'O- blood awareness camp is happening this weekend.',
    'How soon can someone donate again after 3 months?',
    'Is there any urgent request in Lahore right now?',
    'Reminder: always verify medical need before posting.',
  ];

  @override
  void initState() {
    super.initState();

    _sendController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 220),
      lowerBound: 0.88,
      upperBound: 1,
      value: 1,
    );

    _typingDotsController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 900),
    )..repeat();

    _seedInitialMessages();
    _startIncomingSimulation();
    _startOnlineUsersSimulation();
  }

  @override
  void dispose() {
    _incomingTimer?.cancel();
    _onlineUsersTimer?.cancel();
    _sendController.dispose();
    _typingDotsController.dispose();
    _inputController.dispose();
    _focusNode.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  void _seedInitialMessages() {
    final seed = <_ChatMessage>[
      _ChatMessage.other(
        userName: 'Ayesha',
        text: 'Welcome everyone. Please keep discussion respectful.',
      ),
      _ChatMessage.mine(text: 'Thanks. Any verified donor events this week?'),
      _ChatMessage.other(
        userName: 'Hassan',
        text: 'Yes, awareness session at City Hospital tomorrow.',
      ),
    ];

    for (var i = 0; i < seed.length; i++) {
      Future.delayed(Duration(milliseconds: 120 * (i + 1)), () {
        if (!mounted) {
          return;
        }
        _insertMessage(seed[i]);
      });
    }
  }

  void _startIncomingSimulation() {
    _incomingTimer = Timer.periodic(const Duration(seconds: 14), (_) async {
      if (!mounted) {
        return;
      }

      setState(() => _isOtherTyping = true);
      await Future.delayed(const Duration(seconds: 2));
      if (!mounted) {
        return;
      }

      final user = _sampleUsers[_random.nextInt(_sampleUsers.length)];
      final text = _sampleIncoming[_random.nextInt(_sampleIncoming.length)];
      _insertMessage(_ChatMessage.other(userName: user, text: text));
      setState(() => _isOtherTyping = false);
    });
  }

  void _startOnlineUsersSimulation() {
    _onlineUsersTimer = Timer.periodic(const Duration(seconds: 7), (_) {
      if (!mounted) {
        return;
      }

      final delta = _random.nextBool() ? 1 : -1;
      final updated = (_onlineUsers + delta).clamp(96, 190);
      setState(() => _onlineUsers = updated);
    });
  }

  void _insertMessage(_ChatMessage message) {
    final index = _messages.length;
    _messages.add(message);
    _listKey.currentState?.insertItem(
      index,
      duration: const Duration(milliseconds: 260),
    );

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent + 120,
          duration: const Duration(milliseconds: 250),
          curve: Curves.easeOut,
        );
      }
    });
  }

  void _onSendPressed() {
    final trimmed = _inputController.text.trim();
    if (trimmed.isEmpty) {
      return;
    }

    _sendController.reverse().then((_) {
      if (mounted) {
        _sendController.forward();
      }
    });

    _insertMessage(_ChatMessage.mine(text: trimmed));
    _inputController.clear();
    _focusNode.requestFocus();
  }

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        leading: const BackButton(),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Community Chat'),
            AnimatedSwitcher(
              duration: const Duration(milliseconds: 220),
              transitionBuilder: (child, animation) => FadeTransition(
                opacity: animation,
                child: SizeTransition(sizeFactor: animation, child: child),
              ),
              child: Text(
                key: ValueKey<int>(_onlineUsers),
                '$_onlineUsers online',
                style: Theme.of(context).textTheme.labelSmall,
              ),
            ),
          ],
        ),
        actions: [
          IconButton(
            tooltip: 'Search',
            icon: const Icon(Icons.search_rounded),
            onPressed: () {},
          ),
          PopupMenuButton<String>(
            tooltip: 'Moderation actions',
            onSelected: (_) {},
            itemBuilder: (context) => const [
              PopupMenuItem(value: 'report', child: Text('Report Message')),
              PopupMenuItem(value: 'block', child: Text('Block User')),
              PopupMenuItem(value: 'mute', child: Text('Mute Notifications')),
            ],
          ),
        ],
      ),
      body: Column(
        children: [
          Container(
            width: double.infinity,
            margin: const EdgeInsets.fromLTRB(12, 8, 12, 8),
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
            decoration: BoxDecoration(
              color: isDarkMode
                  ? AppColors.primary.withValues(alpha: 0.18)
                  : AppColors.primary.withValues(alpha: 0.08),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: AppColors.primary.withValues(alpha: 0.25),
              ),
            ),
            child: Text(
              'Be respectful. No fake requests.',
              style: Theme.of(context).textTheme.bodySmall,
            ),
          ),
          Expanded(
            child: AnimatedList(
              key: _listKey,
              controller: _scrollController,
              padding: const EdgeInsets.fromLTRB(12, 6, 12, 8),
              physics: const BouncingScrollPhysics(),
              initialItemCount: _messages.length,
              itemBuilder: (context, index, animation) {
                final message = _messages[index];
                return FadeTransition(
                  opacity: animation,
                  child: SizeTransition(
                    sizeFactor: animation,
                    axisAlignment: -1,
                    child: _MessageBubble(message: message),
                  ),
                );
              },
            ),
          ),
          if (_isOtherTyping)
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 0, 16, 8),
              child: Row(
                children: [
                  CircleAvatar(
                    radius: 14,
                    backgroundColor: isDarkMode
                        ? Colors.grey.shade700
                        : Colors.grey.shade300,
                    child: const Icon(Icons.person, size: 16),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 8,
                      ),
                      decoration: BoxDecoration(
                        color: isDarkMode
                            ? Colors.grey.shade800
                            : Colors.grey.shade200,
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Row(
                        children: [
                          Text(
                            'User is typing',
                            style: Theme.of(context).textTheme.bodySmall,
                          ),
                          const SizedBox(width: 8),
                          _TypingDots(controller: _typingDotsController),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          SafeArea(
            top: false,
            child: _InputBar(
              controller: _inputController,
              focusNode: _focusNode,
              sendScale: _sendController,
              onSend: _onSendPressed,
            ),
          ),
        ],
      ),
    );
  }
}

class _InputBar extends StatelessWidget {
  final TextEditingController controller;
  final FocusNode focusNode;
  final Animation<double> sendScale;
  final VoidCallback onSend;

  const _InputBar({
    required this.controller,
    required this.focusNode,
    required this.sendScale,
    required this.onSend,
  });

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return Container(
      padding: const EdgeInsets.fromLTRB(12, 8, 12, 12),
      decoration: BoxDecoration(
        color: isDarkMode
            ? Colors.black.withValues(alpha: 0.55)
            : Colors.white.withValues(alpha: 0.95),
        border: Border(
          top: BorderSide(
            color: isDarkMode
                ? AppColors.primary.withValues(alpha: 0.28)
                : Colors.black.withValues(alpha: 0.06),
          ),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.08),
            blurRadius: 12,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.attach_file_rounded),
            tooltip: 'Attachment',
          ),
          Expanded(
            child: TextField(
              controller: controller,
              focusNode: focusNode,
              minLines: 1,
              maxLines: 4,
              textInputAction: TextInputAction.newline,
              decoration: InputDecoration(
                hintText: 'Type a message...',
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 14,
                  vertical: 10,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(28),
                ),
              ),
            ),
          ),
          const SizedBox(width: 8),
          ScaleTransition(
            scale: sendScale,
            child: IconButton.filled(
              onPressed: onSend,
              icon: const Icon(Icons.send_rounded),
              tooltip: 'Send',
            ),
          ),
        ],
      ),
    );
  }
}

class _MessageBubble extends StatelessWidget {
  final _ChatMessage message;

  const _MessageBubble({required this.message});

  Color _senderColor(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final palette = <Color>[
      scheme.primary,
      scheme.secondary,
      scheme.tertiary,
      AppColors.primaryLight,
      AppColors.success,
      AppColors.warning,
    ];

    final index = message.userName.hashCode.abs() % palette.length;
    return palette[index];
  }

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final senderColor = _senderColor(context);
    final bubbleColor = message.isMine
        ? AppColors.primary.withValues(alpha: 0.85)
        : (isDarkMode ? Colors.grey.shade900 : Colors.white);
    final borderColor = message.isMine
        ? AppColors.primary.withValues(alpha: 0.55)
        : senderColor.withValues(alpha: 0.35);
    final senderTextColor = message.isMine ? Colors.white : senderColor;
    final bodyTextColor = message.isMine
        ? Colors.white
        : Theme.of(context).textTheme.bodyMedium?.color;
    final maxBubbleWidth = MediaQuery.of(context).size.width * 0.78;

    return Semantics(
      label:
          'Message from ${message.isMine ? 'you' : message.userName} at ${message.timestamp}: ${message.text}',
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 6),
        child: Align(
          alignment: message.isMine
              ? Alignment.centerRight
              : Alignment.centerLeft,
          child: ConstrainedBox(
            constraints: BoxConstraints(maxWidth: maxBubbleWidth),
            child: Container(
              padding: const EdgeInsets.fromLTRB(12, 10, 12, 10),
              decoration: BoxDecoration(
                color: bubbleColor,
                borderRadius: BorderRadius.circular(14),
                border: Border.all(color: borderColor),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(
                      alpha: isDarkMode ? 0.22 : 0.06,
                    ),
                    blurRadius: 8,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CircleAvatar(
                    radius: 14,
                    backgroundColor: message.isMine
                        ? AppColors.primaryLight
                        : senderColor,
                    child: Text(
                      message.userName.substring(0, 1),
                      style: const TextStyle(
                        fontSize: 12,
                        color: Colors.white,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: Text(
                                message.userName,
                                overflow: TextOverflow.ellipsis,
                                style: Theme.of(context).textTheme.labelLarge
                                    ?.copyWith(
                                      fontWeight: FontWeight.w700,
                                      color: senderTextColor,
                                    ),
                              ),
                            ),
                            const SizedBox(width: 8),
                            Text(
                              message.timestamp,
                              style: Theme.of(context).textTheme.labelSmall
                                  ?.copyWith(
                                    color: message.isMine
                                        ? Colors.white70
                                        : Theme.of(
                                            context,
                                          ).textTheme.labelSmall?.color,
                                  ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 6),
                        Text(
                          message.text,
                          style: TextStyle(
                            color: bodyTextColor,
                            height: 1.35,
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _TypingDots extends StatelessWidget {
  final Animation<double> controller;

  const _TypingDots({required this.controller});

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: controller,
      builder: (context, child) {
        return Row(
          children: List.generate(3, (index) {
            final phase = ((controller.value + index * 0.18) % 1.0);
            final dy = sin(phase * pi * 2) * 2;
            return Transform.translate(
              offset: Offset(0, -dy),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 1.5),
                child: Container(
                  width: 6,
                  height: 6,
                  decoration: BoxDecoration(
                    color: AppColors.primary.withValues(alpha: 0.9),
                    shape: BoxShape.circle,
                  ),
                ),
              ),
            );
          }),
        );
      },
    );
  }
}

class _ChatMessage {
  final String text;
  final String userName;
  final bool isMine;
  final String timestamp;

  const _ChatMessage({
    required this.text,
    required this.userName,
    required this.isMine,
    required this.timestamp,
  });

  factory _ChatMessage.mine({required String text}) {
    return _ChatMessage(
      text: text,
      userName: 'You',
      isMine: true,
      timestamp: _nowStamp(),
    );
  }

  factory _ChatMessage.other({required String userName, required String text}) {
    return _ChatMessage(
      text: text,
      userName: userName,
      isMine: false,
      timestamp: _nowStamp(),
    );
  }

  static String _nowStamp() {
    final now = DateTime.now();
    final hour = now.hour > 12
        ? now.hour - 12
        : (now.hour == 0 ? 12 : now.hour);
    final minute = now.minute.toString().padLeft(2, '0');
    final period = now.hour >= 12 ? 'PM' : 'AM';
    return '$hour:$minute $period';
  }
}
