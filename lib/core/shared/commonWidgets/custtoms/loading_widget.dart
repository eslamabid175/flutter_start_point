import 'package:flutter/material.dart';
import '../../theme/spacing/app_dimensions.dart';
import '../../utils/extensions/context_extensions.dart';

class LoadingWidget extends StatelessWidget {
  final String? message;
  final Color? color;
  final double size;
  final double strokeWidth;
  final bool showCard;

  const LoadingWidget({
    Key? key,
    this.message,
    this.color,
    this.size = 50,
    this.strokeWidth = 3,
    this.showCard = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final loadingIndicator = SizedBox(
      width: size,
      height: size,
      child: CircularProgressIndicator(
        valueColor: AlwaysStoppedAnimation<Color>(
          color ?? context.primaryColor,
        ),
        strokeWidth: strokeWidth,
      ),
    );

    final content = Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        loadingIndicator,
        if (message != null) ...[
          const SizedBox(height: AppDimensions.space16),
          Text(
            message!,
            style: context.bodyLarge,
            textAlign: TextAlign.center,
          ),
        ],
      ],
    );

    if (showCard) {
      return Center(
        child: Card(
          elevation: AppDimensions.cardElevationM,
          shape: RoundedRectangleBorder(
            borderRadius: AppDimensions.borderRadius12,
          ),
          child: Padding(
            padding: const EdgeInsets.all(AppDimensions.space24),
            child: content,
          ),
        ),
      );
    }

    return Center(child: content);
  }
}