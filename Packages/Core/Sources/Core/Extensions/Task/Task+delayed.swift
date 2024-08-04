import Foundation

public extension Task where Failure == Error {
    /**
     This method creates a new `Task` that delays its execution by a specified time interval before performing the provided asynchronous operation. The task can be executed with an optional priority.

     - Parameters:
        - delayInterval: The time interval (in seconds) to delay the execution of the task. This value is converted to nanoseconds for the underlying sleep function.
        - priority: An optional `TaskPriority` to set the priority of the task. If `nil`, the task will inherit the priority of the current task.
        - operation: A closure that contains the asynchronous operation to be performed after the delay. This closure is marked as `@Sendable` to ensure thread safety.

     - Returns:
        A `Task` instance that will execute the provided operation after the specified delay.

     - Note:
        The `@discardableResult` attribute allows the caller to ignore the returned `Task` instance if it's not needed.

     - Usage Example:
        ```swift
        Task.delayed(byTimeInterval: 2.0) {
            // This code will execute after a 2-second delay
            print("Delayed operation executed")
        }
        ```
     */
    @discardableResult
    static func delayed(
        byTimeInterval delayInterval: TimeInterval,
        priority: TaskPriority? = nil,
        @_implicitSelfCapture operation: @escaping @Sendable () async throws -> Success
    ) -> Task {
        Task(priority: priority) {
            let delay = UInt64(delayInterval * 1_000_000_000)
            try await Task<Never, Never>.sleep(nanoseconds: delay)
            return try await operation()
        }
    }
}
