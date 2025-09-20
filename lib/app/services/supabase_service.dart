import 'package:supabase_flutter/supabase_flutter.dart';
import '../constants/app_constants.dart';

/// Supabase client configuration and initialization
class SupabaseService {
  static SupabaseClient? _client;

  /// Get the Supabase client instance
  static SupabaseClient get client {
    if (_client == null) {
      throw Exception(
          'Supabase client not initialized. Call initialize() first.');
    }
    return _client!;
  }

  /// Initialize Supabase client
  static Future<void> initialize() async {
    await Supabase.initialize(
      url: AppConstants.supabaseUrl,
      anonKey: AppConstants.supabaseAnonKey,
      authOptions: const FlutterAuthClientOptions(
        authFlowType: AuthFlowType.pkce,
      ),
      realtimeClientOptions: const RealtimeClientOptions(
        logLevel: RealtimeLogLevel.info,
        timeout: Duration(seconds: 20),
      ),
      storageOptions: const StorageClientOptions(
        retryAttempts: 3,
      ),
    );

    _client = Supabase.instance.client;
  }

  /// Get current user
  static User? get currentUser => _client?.auth.currentUser;

  /// Check if user is authenticated
  static bool get isAuthenticated => currentUser != null;

  /// Get auth state stream
  static Stream<AuthState> get authStateChanges =>
      _client!.auth.onAuthStateChange;

  /// Sign out current user
  static Future<void> signOut() async {
    await _client?.auth.signOut();
  }

  /// Get user ID
  static String? get userId => currentUser?.id;

  /// Get user email
  static String? get userEmail => currentUser?.email;

  /// Get user metadata
  static Map<String, dynamic>? get userMetadata => currentUser?.userMetadata;

  /// Dispose resources
  static void dispose() {
    _client = null;
  }
}
