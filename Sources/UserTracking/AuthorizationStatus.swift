import AppTrackingTransparency

extension ATTrackingManager.AuthorizationStatus {
  public var isAuthorized: Bool {
    self == .authorized
  }
}

extension ATTrackingManager.AuthorizationStatus: CustomStringConvertible {
  public var description: String {
    switch self {
    case .notDetermined:
      return "notDetermined"
    case .restricted:
      return "restricted"
    case .denied:
      return "denied"
    case .authorized:
      return "authorized"
    }
  }
}

extension ATTrackingManager.AuthorizationStatus: Equatable {}

extension ATTrackingManager.AuthorizationStatus: Hashable {}

extension ATTrackingManager.AuthorizationStatus: Sendable {}
