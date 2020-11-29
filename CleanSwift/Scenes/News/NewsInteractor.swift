//
//  NewsInteractor.swift
//  CleanSwift
//
//  Created by Игорь Дикань on 28.11.2020.
//  Copyright © 2020 Игорь Дикань. All rights reserved.
//

import UIKit

protocol NewsBusinessLogic {
    func fetchNews()
    func getLogo(navController: UINavigationController?, navItem: UINavigationItem)
}

class NewsInteractor {
    
    // MARK: - External vars
    var presenter: NewsPresentationLogic?
    var service: NewsService?
    weak var viewController: NewsDisplayLogic?
}

// MARK: - Business logic
extension NewsInteractor: NewsBusinessLogic {
    
    func fetchNews() {
        if service == nil {
            service = NewsService()
        }
        service?.fetchNews(complition: { (news) in
            self.presenter?.presentData(data: news)
        })
    }
    
    func getLogo(navController: UINavigationController?, navItem: UINavigationItem) {
        presenter?.presentLogo(navController: navController, navItem: navItem)
    }
}
