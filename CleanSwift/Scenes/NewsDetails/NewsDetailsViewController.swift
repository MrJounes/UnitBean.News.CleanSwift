//
//  NewsDetailsViewController.swift
//  CleanSwift
//
//  Created by Игорь Дикань on 28.11.2020.
//  Copyright © 2020 Игорь Дикань. All rights reserved.
//

import UIKit

protocol NewsDetailsDisplayLogic: class {
    func displayData(data: NewsCellModel)
}

class NewsDetailsViewController: UIViewController {
    
    // MARK: - IBOutlets
    @IBOutlet weak var detailsAutorLabel: UILabel!
    @IBOutlet weak var detailsDateLabel: UILabel!
    @IBOutlet weak var detailsTitleLabel: UILabel!
    @IBOutlet weak var detailsImageView: WebImageViewService!
    @IBOutlet weak var detailsTextLabel: UILabel!
    
    // MARK: - External vars
    private(set) var router: (NewsDetailsRoutingLogic & NewsDetailsDataPassingProtocol)?
    
    // MARK: - Internal vars
    private var interactor: (NewsDetailsBusinessLogic & NewsDetailsStoreProtocol)?
    var detailsData: NewsCellModel?
    
    // MARK: - Object lifecycle
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        setup()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }
    
    // MARK: - Setup
    private func setup() {
        let viewController = self
        let interactor = NewsDetailsInteractor()
        let presenter = NewsDetailsPresenter()
        let router = NewsDetailsRouter()
        interactor.presenter = presenter
        presenter.viewController = viewController
        router.dataStore = interactor
        viewController.interactor = interactor
        viewController.router = router
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Статья"
        // Do any additional setup after loading the view.
        interactor?.fetchDetails()
        configureDetails(data: detailsData)
    }
    
    // MARK: - Internal logic
    private func configureDetails(data: NewsCellModel?) {
        detailsAutorLabel.text = data?.newsAutor
        detailsDateLabel.text = data?.newsDate
        detailsTitleLabel.text = data?.newsTitle.uppercased()
        detailsImageView.set(urlString: data?.newsImage ?? "")
        detailsTextLabel.text = data?.newsText
        
        detailsAutorLabel.font = UIFont(name: "PTRootUI-Regular", size: 12)
        detailsDateLabel.font = UIFont(name: "PTRootUI-Light", size: 12)
        detailsTitleLabel.font = UIFont(name: "PTRootUI-Medium", size: 28)
        detailsTextLabel.font = UIFont(name: "PTRootUI-Regular", size: 16)
    }
}

// MARK: - Display logic
extension NewsDetailsViewController: NewsDetailsDisplayLogic {
    func displayData(data: NewsCellModel) {
        self.detailsData = data
    }
}
