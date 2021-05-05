//
//  StoryViewModel.swift
//  CleanseDI
//
//  Created by William Hendra on 05/05/21.
//

import Cleanse
import RxSwift
import RxCocoa

struct StoryViewModel {
    struct Output {
        let title: Driver<String>
        let url: Driver<URL?>
    }
    let output: Output
    
    init(story: HNStory) {
        let titleDriver = Driver.just(story.title)
        let urlDriver = Driver.just(URL(string: story.url ?? ""))
        self.output = Output(title: titleDriver, url: urlDriver)
    }
    
}

