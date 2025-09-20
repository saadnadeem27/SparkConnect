import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../constants/app_colors.dart';
import '../../constants/app_text_styles.dart';

class StoryViewerScreen extends StatefulWidget {
  const StoryViewerScreen({super.key});

  @override
  State<StoryViewerScreen> createState() => _StoryViewerScreenState();
}

class _StoryViewerScreenState extends State<StoryViewerScreen>
    with TickerProviderStateMixin {
  late AnimationController _progressController;
  late PageController _pageController;

  int currentStoryIndex = 0;

  // Mock story data
  final List<Map<String, dynamic>> stories = [
    {
      'id': 'story1',
      'type': 'image',
      'url':
          'https://images.unsplash.com/photo-1571019613454-1cb2f99b2d8b?w=600&h=800&fit=crop',
      'user': {
        'username': 'john_doe',
        'profileImage':
            'https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?w=150&h=150&fit=crop&crop=face',
      },
      'timestamp': DateTime.now().subtract(const Duration(hours: 2)),
      'viewsCount': 1234,
    },
    {
      'id': 'story2',
      'type': 'image',
      'url':
          'https://images.unsplash.com/photo-1506905925346-21bda4d32df4?w=600&h=800&fit=crop',
      'user': {
        'username': 'john_doe',
        'profileImage':
            'https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?w=150&h=150&fit=crop&crop=face',
      },
      'timestamp': DateTime.now().subtract(const Duration(hours: 1)),
      'viewsCount': 987,
    },
    {
      'id': 'story3',
      'type': 'image',
      'url':
          'https://images.unsplash.com/photo-1555774698-0b77e0d5fac6?w=600&h=800&fit=crop',
      'user': {
        'username': 'john_doe',
        'profileImage':
            'https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?w=150&h=150&fit=crop&crop=face',
      },
      'timestamp': DateTime.now().subtract(const Duration(minutes: 30)),
      'viewsCount': 567,
    },
  ];

  @override
  void initState() {
    super.initState();
    _progressController = AnimationController(
      duration: const Duration(seconds: 5),
      vsync: this,
    );
    _pageController = PageController();

    _startStoryTimer();
  }

  @override
  void dispose() {
    _progressController.dispose();
    _pageController.dispose();
    super.dispose();
  }

  void _startStoryTimer() {
    _progressController.forward().then((_) {
      _nextStory();
    });
  }

  void _nextStory() {
    if (currentStoryIndex < stories.length - 1) {
      setState(() {
        currentStoryIndex++;
      });
      _progressController.reset();
      _pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
      _startStoryTimer();
    } else {
      Get.back();
    }
  }

  void _previousStory() {
    if (currentStoryIndex > 0) {
      setState(() {
        currentStoryIndex--;
      });
      _progressController.reset();
      _pageController.previousPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
      _startStoryTimer();
    }
  }

  void _pauseStory() {
    _progressController.stop();
  }

  void _resumeStory() {
    _progressController.forward();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: GestureDetector(
        onTapDown: (_) => _pauseStory(),
        onTapUp: (_) => _resumeStory(),
        onTapCancel: () => _resumeStory(),
        child: Stack(
          children: [
            // Story Content
            PageView.builder(
              controller: _pageController,
              itemCount: stories.length,
              onPageChanged: (index) {
                setState(() {
                  currentStoryIndex = index;
                });
                _progressController.reset();
                _startStoryTimer();
              },
              itemBuilder: (context, index) {
                final story = stories[index];

                return SizedBox(
                  width: double.infinity,
                  height: double.infinity,
                  child: story['type'] == 'image'
                      ? Image.network(
                          story['url'],
                          fit: BoxFit.cover,
                        )
                      : Container(
                          color: Colors.grey[800],
                          child: const Center(
                            child: Icon(
                              Icons.play_circle_filled,
                              color: Colors.white,
                              size: 80,
                            ),
                          ),
                        ),
                );
              },
            ),

            // Navigation Areas
            Row(
              children: [
                // Left tap area
                Expanded(
                  child: GestureDetector(
                    onTap: _previousStory,
                    child: Container(
                      color: Colors.transparent,
                      height: double.infinity,
                    ),
                  ),
                ),
                // Right tap area
                Expanded(
                  child: GestureDetector(
                    onTap: _nextStory,
                    child: Container(
                      color: Colors.transparent,
                      height: double.infinity,
                    ),
                  ),
                ),
              ],
            ),

            // Top Overlay
            SafeArea(
              child: Column(
                children: [
                  // Progress Indicators
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                    child: Row(
                      children: List.generate(
                        stories.length,
                        (index) => Expanded(
                          child: Container(
                            height: 3,
                            margin: const EdgeInsets.symmetric(horizontal: 1),
                            decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.3),
                              borderRadius: BorderRadius.circular(1.5),
                            ),
                            child: FractionallySizedBox(
                              alignment: Alignment.centerLeft,
                              widthFactor: index == currentStoryIndex
                                  ? 1.0
                                  : index < currentStoryIndex
                                      ? 1.0
                                      : 0.0,
                              child: AnimatedBuilder(
                                animation: _progressController,
                                builder: (context, child) {
                                  return FractionallySizedBox(
                                    widthFactor: index == currentStoryIndex
                                        ? _progressController.value
                                        : index < currentStoryIndex
                                            ? 1.0
                                            : 0.0,
                                    child: Container(
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius:
                                            BorderRadius.circular(1.5),
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),

                  // User Info Header
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    child: Row(
                      children: [
                        CircleAvatar(
                          radius: 18,
                          backgroundImage: NetworkImage(
                            stories[currentStoryIndex]['user']['profileImage'],
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                stories[currentStoryIndex]['user']['username'],
                                style: AppTextStyles.bodyMedium.copyWith(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              Text(
                                '2h ago',
                                style: AppTextStyles.bodySmall.copyWith(
                                  color: Colors.white.withOpacity(0.8),
                                ),
                              ),
                            ],
                          ),
                        ),
                        IconButton(
                          onPressed: () => Get.back(),
                          icon: const Icon(
                            Icons.close,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            // Bottom Overlay
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: SafeArea(
                child: Container(
                  padding: const EdgeInsets.all(16),
                  child: Row(
                    children: [
                      Expanded(
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.black.withOpacity(0.3),
                            borderRadius: BorderRadius.circular(25),
                            border: Border.all(
                              color: Colors.white.withOpacity(0.3),
                            ),
                          ),
                          child: TextField(
                            style: AppTextStyles.bodyMedium.copyWith(
                              color: Colors.white,
                            ),
                            decoration: InputDecoration(
                              hintText: 'Reply to story...',
                              hintStyle: AppTextStyles.bodyMedium.copyWith(
                                color: Colors.white.withOpacity(0.7),
                              ),
                              border: InputBorder.none,
                              contentPadding: const EdgeInsets.symmetric(
                                horizontal: 16,
                                vertical: 12,
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.black.withOpacity(0.3),
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: Colors.white.withOpacity(0.3),
                          ),
                        ),
                        child: IconButton(
                          onPressed: () {
                            // Handle like
                          },
                          icon: const Icon(
                            Icons.favorite_border,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.black.withOpacity(0.3),
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: Colors.white.withOpacity(0.3),
                          ),
                        ),
                        child: IconButton(
                          onPressed: () {
                            // Handle share
                          },
                          icon: const Icon(
                            Icons.share,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
