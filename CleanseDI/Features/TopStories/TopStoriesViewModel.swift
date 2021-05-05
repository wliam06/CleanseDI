//
//  TopStoriesViewModel.swift
//  CleanseDI
//
//  Created by William Hendra on 05/05/21.
//

import Foundation
import RxSwift
import RxCocoa

struct TopStoriesViewModel {
    struct Input {
        var load: PublishRelay<()>
    }
    struct Output {
        let stories: Driver<[HNStory]>
    }

    let input: Input
    let output: Output

    init(topStoriesService: TopStoriesService) {
        let load = PublishRelay<()>()
        let stories = load.startWith(()).flatMap {
            topStoriesService.getTopStoriesObservable()
        }.asDriver(onErrorJustReturn: [HNStory]())
        
        input = Input(load: load)
        output = Output(stories: stories)
    }
}
