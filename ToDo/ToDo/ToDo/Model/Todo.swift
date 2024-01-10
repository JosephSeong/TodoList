//
//  Todo.swift
//  ToDo
//
//  Created by Joseph on 12/22/23.
//

import Foundation

// 할 일 데이터 모델 정의
struct Todo: Codable {
    var id: Int
    var title: String
    var isCompleted: Bool
    var category: String
}
