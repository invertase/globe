import 'package:bad_words/bad_words.dart';
import 'package:api_domain/src/models/models.dart';

/// Enum for the possible expected failures when creating a post.
enum CreatePostFailure {
  /// The message is empty.
  empty,

  /// The post message is too long.
  tooLong,

  /// The post message includes profanity.
  isProfane,

  /// Something unexpected happened while creating the post.
  unexpected,
}

/// {@template post_creation_failure}
/// Thrown when a post fails to be created.
/// {@endtemplate}
class PostCreationFailure implements Exception {
  /// {@macro post_creation_failure}
  const PostCreationFailure(this.reason, this.stackTrace);

  /// The reason why the post failed to be created.
  final CreatePostFailure reason;

  /// The stack trace associated with the failure.
  final StackTrace stackTrace;
}

/// {@template post_repository_adapter}
/// Adapter for the post repository.
/// {@endtemplate}
abstract class PostRepositoryAdapter {
  /// Creates a post.
  Future<Post> createPost({
    required String userId,
    required String message,
  });

  /// Gets a post.
  Future<Post?> getPost({
    required String postId,
  });

  /// Gets a list of posts for the home feed.
  Future<List<Post>> listHomePosts();
}

/// {@template post_repository}
/// Repository which manages posts.
/// {@endtemplate}
class PostRepository {
  /// {@macro post_repository}
  PostRepository({
    required PostRepositoryAdapter adapter,
    Filter? profanityFilter,
  }) : _adapter = adapter {
    _profanityFilter = profanityFilter ?? Filter();
  }

  final PostRepositoryAdapter _adapter;

  late final Filter _profanityFilter;

  /// Creates a post.
  Future<Post> createPost({
    required String userId,
    required String message,
  }) {
    if (message.isEmpty) {
      throw PostCreationFailure(
        CreatePostFailure.empty,
        StackTrace.current,
      );
    }

    if (message.length > 280) {
      throw PostCreationFailure(
        CreatePostFailure.tooLong,
        StackTrace.current,
      );
    }

    if (_profanityFilter.isProfane(message)) {
      throw PostCreationFailure(
        CreatePostFailure.isProfane,
        StackTrace.current,
      );
    }

    try {
      return _adapter.createPost(
        userId: userId,
        message: message,
      );
    } catch (e, st) {
      throw PostCreationFailure(
        CreatePostFailure.unexpected,
        st,
      );
    }
  }

  /// Gets a post.
  Future<Post?> getPost({
    required String postId,
  }) =>
      _adapter.getPost(postId: postId);

  /// Gets a list of posts for the home feed.
  Future<List<Post>> listHomePosts() => _adapter.listHomePosts();
}
