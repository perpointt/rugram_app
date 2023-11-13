import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rugram/application/ui/screens/profile_widget/profile_view_model.dart';
import 'package:rugram/application/ui/themes/themes.dart';
import 'package:rugram/application/ui/widgets/buttons/buttons.dart';
import 'dart:math' as math;

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen>
    with SingleTickerProviderStateMixin {
  late final TabController _tabController;
  @override
  void initState() {
    super.initState();
    _tabController = TabController(initialIndex: 0, length: 2, vsync: this);
  }

  double getHeight() {
    return 800;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      body: SafeArea(
        child: Stack(
          children: [
            DefaultTabController(
              length: 3,
              child: NestedScrollView(
                headerSliverBuilder: (context, value) {
                  return [
                    const SliverAppBar(
                      pinned: true,
                      title: _AppBarTitle(),
                    ),
                    const SliverToBoxAdapter(
                      child: _ProfileInfoWidget(),
                    ),
                    SliverPersistentHeader(
                      pinned: true,
                      delegate: _SliverAppBarDelegate(
                        minHeight: 46,
                        maxHeight: 46,
                        child: TabBar(
                          controller: _tabController,
                          tabs: [
                            Tab(
                              icon: Theme(
                                data: Theme.of(context),
                                child: const Icon(Icons.grid_on_rounded),
                              ),
                            ),
                            Tab(
                              icon: Theme(
                                data: Theme.of(context),
                                child: const Icon(Icons.person_pin_outlined),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ];
                },
                body: TabBarView(
                  controller: _tabController,
                  children: [
                    SingleChildScrollView(
                      child: Container(
                        padding: const EdgeInsets.only(bottom: 10000),
                        child: const Column(
                          children: [],
                        ),
                      ),
                    ),
                    SingleChildScrollView(
                      child: Container(
                        padding: const EdgeInsets.only(bottom: 10000),
                        child: const Column(
                          children: [],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ProfileInfoWidget extends StatelessWidget {
  const _ProfileInfoWidget();

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _AvatarWidget(),
              Padding(
                padding: EdgeInsets.only(right: 16),
                child: _SubInfoWidget(),
              ),
            ],
          ),
          SizedBox(height: 16),
          _BioWidget(),
          _ActionsWidget(),
          SizedBox(height: 8),
        ],
      ),
    );
  }
}

class _ActionsWidget extends StatelessWidget {
  const _ActionsWidget();

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: _ActionButton(
            title: 'Following',
            onTap: () {},
          ),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: _ActionButton(
            title: 'Message',
            onTap: () {},
          ),
        ),
      ],
    );
  }
}

class _ActionButton extends StatelessWidget {
  final String title;
  final void Function() onTap;
  const _ActionButton({
    required this.title,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return CustomButton(
      title: title,
      onTap: onTap,
      padding: const EdgeInsets.all(6),
      background: AppColors.divider,
      style: AppTextStyle.primary600.copyWith(
        color: Colors.white,
        fontSize: 12,
      ),
    );
  }
}

class _BioWidget extends StatelessWidget {
  const _BioWidget();

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<ProfileViewModel>();
    final name = viewModel.user?.name ?? '';
    final bio = viewModel.user?.bio ?? '';

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (name.isNotEmpty) Text(name),
        if (bio.isNotEmpty) Text(bio),
        if (name.isNotEmpty || bio.isNotEmpty) ...[
          const SizedBox(height: 16),
        ],
      ],
    );
  }
}

class _SubInfoWidget extends StatelessWidget {
  const _SubInfoWidget();

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        _SubButtonWidget(
          count: 113,
          label: 'Posts',
          onTap: () {},
        ),
        const SizedBox(width: 32),
        _SubButtonWidget(
          count: 256,
          label: 'Followers',
          onTap: () {},
        ),
        const SizedBox(width: 32),
        _SubButtonWidget(
          count: 1170,
          label: 'Following',
          onTap: () {},
        ),
      ],
    );
  }
}

class _SubButtonWidget extends StatelessWidget {
  final int count;
  final String label;
  final void Function() onTap;
  const _SubButtonWidget({
    required this.count,
    required this.label,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final bodyMedium = Theme.of(context).textTheme.bodyMedium;
    final style = bodyMedium?.copyWith(
      fontWeight: FontWeight.w500,
      fontSize: 16,
    );

    return Column(
      children: [
        Text(title, style: style),
        const SizedBox(height: 2),
        Text(label, style: const TextStyle(fontSize: 12)),
      ],
    );
  }

  String get title {
    if (count > 1000) {
      final value = (count / 1000).toStringAsPrecision(3);
      return '${value}k';
    } else {
      return '$count';
    }
  }
}

class _AvatarWidget extends StatelessWidget {
  const _AvatarWidget();

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: 32,
      backgroundColor: AppColors.divider,
      child: Theme(
        data: Theme.of(context),
        child: const Icon(Icons.person, size: 32),
      ),
    );
  }
}

class _SliverAppBarDelegate extends SliverPersistentHeaderDelegate {
  _SliverAppBarDelegate({
    required this.minHeight,
    required this.maxHeight,
    required this.child,
  });
  final double minHeight;
  final double maxHeight;
  final Widget child;

  @override
  double get minExtent => minHeight;

  @override
  double get maxExtent => math.max(maxHeight, minHeight);

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return SizedBox.expand(child: child);
  }

  @override
  bool shouldRebuild(_SliverAppBarDelegate oldDelegate) {
    return maxHeight != oldDelegate.maxHeight ||
        minHeight != oldDelegate.minHeight ||
        child != oldDelegate.child;
  }
}

class _AppBarTitle extends StatelessWidget {
  const _AppBarTitle();

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<ProfileViewModel>();
    final user = viewModel.user;
    return Text(user?.username ?? '');
  }
}
