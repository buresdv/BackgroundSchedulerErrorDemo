//
//  Background_Scheduler_DemoApp.swift
//  Background Scheduler Demo
//
//  Created by David Bureš on 12.06.2024.
//

import SwiftUI

@main
struct Background_Scheduler_DemoApp: App
{
    @State var mutableVariable: Bool = true

    let scheduler: NSBackgroundActivityScheduler =
    {
        var scheduler: NSBackgroundActivityScheduler = .init(identifier: "com.davidbures.updater")
        scheduler.repeats = true
        scheduler.interval = 1 * 60
        scheduler.tolerance = 30
        return scheduler
    }()

    var body: some Scene
    {
        WindowGroup
        {
            ContentView()
                .onAppear
                {
                    scheduler.schedule
                    { (completion: NSBackgroundActivityScheduler.CompletionHandler) in
                        Task(priority: .background)
                        {
                            mutableVariable = false // Error
                            await changeValueOfMutableVar(to: false) // No Error
                        }
                    }
                }
        }
    }
    
    private func changeValueOfMutableVar(to newValue: Bool)
    {
        self.mutableVariable = newValue
    }
}
