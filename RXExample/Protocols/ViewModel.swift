//
//  ViewModel.swift
//  RXExample
//
//  Created by DAVIDPAN on 2022/12/30.
//

import Foundation

protocol ViewModel {
    associatedtype Input
    associatedtype Output
    
    var input: Input { get }
    var output: Output { get }
}
