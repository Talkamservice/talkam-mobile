import 'package:talkam/core/services/network/network_service.dart';
import 'package:talkam/core/services/network/url_config_v2.dart';
import 'package:talkam/features/earnings/data/models/earnings_dashboard.dart';
import 'package:talkam/features/earnings/data/models/earnings_transaction.dart';
import 'package:talkam/features/earnings/data/models/payout_result.dart';
import 'package:talkam/features/earnings/dormain/repository/earnings_repository.dart';

class EarningsRepositoryImpl extends EarningsRepository {
  final NetworkService _v2 = NetworkService(baseUrl: UrlConfigV2.coreBaseUrl);

  @override
  Future<EarningsDashboard> getDashboard() async {
    final response = await _v2.call(
      UrlConfigV2.therapistEarningsDashboard,
      RequestMethod.get,
    );
    return EarningsDashboard.fromJson(response.data['data']);
  }

  @override
  Future<EarningsTransactionsPage> getTransactions({int page = 1}) async {
    final response = await _v2.call(
      UrlConfigV2.therapistEarningsTransactions,
      RequestMethod.get,
      queryParams: {"page": page.toString()},
    );
    return EarningsTransactionsPage.fromJson(response.data['data']);
  }

  @override
  Future<PayoutResult> withdraw() async {
    final response = await _v2.call(
      UrlConfigV2.therapistPayouts,
      RequestMethod.post,
    );
    return PayoutResult.fromJson(response.data['data']);
  }

  @override
  Future<PayoutResult> getPayoutStatus(int payoutId) async {
    final response = await _v2.call(
      UrlConfigV2.therapistPayoutStatus(payoutId),
      RequestMethod.get,
    );
    return PayoutResult.fromJson(response.data['data']);
  }
}
