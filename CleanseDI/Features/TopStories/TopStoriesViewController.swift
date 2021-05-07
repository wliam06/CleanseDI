//
//  TopStoriesViewController.swift
//  CleanseDI
//
//  Created by William Hendra on 05/05/21.
//

import UIKit
import RxSwift
import RxDataSources
import Cleanse

class TopStoriesViewController: UIViewController {
    var disposeBag = DisposeBag()
    let storyFactory: Factory<StoryViewController.AssistedFactory>
    let viewModel: TopStoriesViewModel

    @IBOutlet weak var tableView: UITableView!
    
    init(viewModel: TopStoriesViewModel,
         storyFactory: Factory<StoryViewController.AssistedFactory>) {
        self.viewModel = viewModel
        self.storyFactory = storyFactory
        super.init(nibName: nil, bundle: nil)
        self.title = "Top Stories"
        self.tabBarItem = UITabBarItem(title: "Top Stories", image: nil, selectedImage: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        setupViewModel()
    }
}

fileprivate extension TopStoriesViewController {
    func setupTableView() {
        self.tableView.register(UINib(nibName: "TopStoriesTableViewCell", bundle: nil),
                                forCellReuseIdentifier: "TopStoriesTableViewCell")
        self.tableView.rowHeight = UITableView.automaticDimension
        self.tableView.estimatedRowHeight = 70
    }

    func setupViewModel() {
        viewModel.output.stories
            .drive(tableView.rx.items(cellIdentifier: "TopStoriesTableViewCell")) { index, model, cell in
                guard let topStoryCell = cell as? TopStoriesTableViewCell else { return }
                topStoryCell.story = model
        }.disposed(by: self.disposeBag)

        Observable.zip(tableView.rx.modelSelected(HNStory.self), tableView.rx.itemSelected, resultSelector: { ($0, $1) })
            .subscribe(onNext: { [weak self] zipped in
                guard let strongSelf = self else { return }
                strongSelf.tableView.deselectRow(at: zipped.1, animated: true)
                let viewController = strongSelf.storyFactory.build(zipped.0)
                strongSelf.navigationController?.pushViewController(viewController, animated: true)
            }).disposed(by: self.disposeBag)
    }
}

extension TopStoriesViewController {
    struct Module: Cleanse.Module {
        static func configure(binder: UnscopedBinder) {
            binder
                .bind(TopStoriesViewModel.self)
                .to(factory: TopStoriesViewModel.init)
            
            binder
                .bind(UIViewController.self)
                .intoCollection()
                .to(factory: { (topStoriesViewModel: TopStoriesViewModel,
                                factory: Factory<StoryViewController.AssistedFactory>) in
                    return UINavigationController(rootViewController: TopStoriesViewController(viewModel: topStoriesViewModel,
                                                                                               storyFactory: factory))
                })
        }
    }
}
