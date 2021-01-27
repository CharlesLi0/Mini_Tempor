//
//  SummaryViewModel.swift
//  MiniTempor
//
//  Created by Chenbo Fu on 8/10/19.
//  Copyright © 2019 s3644772. All rights reserved.
//

import Foundation

struct SummaryViewModel {
    
    private var planViewModel = PlanViewModel.shared
    
    //Create the Json String for requesting
    public func getTaskJsonString() -> String {
        let taskJsonString = """
            {
                "chart": {
                            "type": "bar",
                            "data": {
                                        "labels": ["ToDo", "Doing", "Done"],
                                        "datasets": [{
                                                        "backgroundColor": ["#FF3784", "#36A2EB", "#4BC0C0"],
                                                        "data": [\(numberOfTasksOnDifferentState(forTaskProgress: .todo)), \(numberOfTasksOnDifferentState(forTaskProgress: .doing)), \(numberOfTasksOnDifferentState(forTaskProgress: .done))]
                                                    }]
                                    },
                            "options": {
                                            "plugins": {
                                                            "legend": false
                                                       }
                                       }
                        }
            }
        """
        return taskJsonString
    } //end of getTaskJsonString
    
    //Create the Json String for requesting
    public func getPlanJsonString() -> String {
        let planJsonString = """
            {
                "backgroundColor": "transparent",
                "width": 250,
                "height": 150,
                "format": "png",
                "chart": {
                            "type": "outlabeledPie",
                            "data": {
                                        "labels": ["Study", "Work", "Shopping", "Game", "Travel", "Other"],
                                        "datasets": [{
                                                        "backgroundColor": ["#FF3784", "#36A2EB", "#4BC0C0", "#F77825", "#9966FF"],
                                                        "data": [\(numberOfTasksInDifferentPlan(forPlanType: .study)), \(numberOfTasksInDifferentPlan(forPlanType: .work)), \(numberOfTasksInDifferentPlan(forPlanType: .shopping)), \(numberOfTasksInDifferentPlan(forPlanType: .game)), \(numberOfTasksInDifferentPlan(forPlanType: .travel)), \(numberOfTasksInDifferentPlan(forPlanType: .other))]
                                                    }]
                                    },
                            "options": {
                                            "plugins": {
                                                            "legend": false,
                                                            "outlabels": {
                                                                            "text": "%l %p",
                                                                            "color": "white",
                                                                            "stretch": 10,
                                                                            "font": {
                                                                                        "resizable": true,
                                                                                        "minSize": 6,
                                                                                        "maxSize": 8
                                                                                    }
                                                                        }
                                                        }
                                        }
                        }
            }
        """
        return planJsonString
    } //end of getPlanJsonString
    
    //Get the number of tasks in different progress
    private func numberOfTasksOnDifferentState(forTaskProgress progress: TaskProgress) -> Int {
        var amount = 0
        
        for plan in planViewModel.planList {
            
            for task in plan.tasks?.allObjects as! [Task] {
                
                if task.taskProgress == progress.rawValue {
                    amount += 1
                }
            }
        }
        
        return amount
    } //end of numberOfTasksOnDifferentState
    
    //Get the number of tasks in different plan with particular plan type
    private func numberOfTasksInDifferentPlan(forPlanType planType: PlanType) -> Int {
        var amount = 0
        
        for plan in planViewModel.planList {
            
            if plan.planType == planType.rawValue {
                amount += plan.tasks!.count
            }
        }
        
        return amount
    } //end of numberOfTasksInDifferentPlan
}
