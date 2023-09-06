import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/components/widgets/custom_input.dart';
import '../../../state/material_state.dart';
import '../../../styles/colors.dart';
@RoutePage()
class ResourcesScreen extends ConsumerStatefulWidget {
  const ResourcesScreen({super.key});

  @override
  ConsumerState<ResourcesScreen> createState() => _MaterialScreenState();
}

class _MaterialScreenState extends ConsumerState<ResourcesScreen> {
  @override
  Widget build(BuildContext context) {
    return Container();
    }
}