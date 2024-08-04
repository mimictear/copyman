import Core
import Observation

@MainActor
@Observable
final class RouterPath {
    public var path: [RouterDestination] = []
    public var presentedSheet: SheetDestination?
    
    init() {}
    
    func navigate(to: RouterDestination) {
        path.append(to)
    }
    
    func replaceLast(with destination: RouterDestination) {
        guard path.isEmpty else {
            path.replaceLast(with: destination)
            return
        }
        path.append(destination)
    }
    
    func clear() {
        path = []
    }
    
    func goBack() {
        path.removeLast()
    }
}
