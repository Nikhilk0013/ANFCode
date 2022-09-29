//
//  ANFExploreCardViewModel.swift
//  ANF Code Test
//
//  Created by Nikhil on 28/09/22.
//

import Foundation

typealias ANFExploreCardViewModelOutput = (ANFExploreCardViewModel.Output) -> ()

class ANFExploreCardViewModel {

    private var productPOs = [ProductPO]()
        
    private var products: [Product] {
        didSet {
            domainToPresentationObjectMapping()
            completionHandler?(.reloadData)
        }
    }
    
    var completionHandler: ANFExploreCardViewModelOutput?
    
    //MARK: - Initializer
    init(products: [Product] = []) {
        self.products = products
        self.domainToPresentationObjectMapping()
    }
    
    func viewDidLoad() {
        self.fetchAllProducts()
    }
    
    enum Output {
        case reloadData
        case showError(message: String)
    }
}

extension ANFExploreCardViewModel {
    
    func fetchAllProducts() {
       
        APIManager.shared.fetchAllProducts { result in
            switch result {
            case .success(let products):
                self.products.removeAll()
                self.products = products
                self.completionHandler?(.reloadData)
                
            case .failure(let error):
                self.completionHandler?(.showError(message: error.rawValue))
            }
        }
    }
    
}


extension ANFExploreCardViewModel {
    
    private func domainToPresentationObjectMapping() {
        productPOs = []

        for (index, product) in self.products.enumerated() {
            
            if let imageUrl = URL(string: product.backgroundImage) {
                let productCellVM = ProductPO(
                    cellIndex: index,
                    bgImageUrl: imageUrl,
                    topDescription: product.topDescription ?? "",
                    productTitle: product.title,
                    promoMessage: product.promoMessage ?? "",
                    bottomDescription: product.bottomDescription ?? "",
                    content1: product.content?.first,
                    content2: (product.content?.count ?? 0 > 1) ? product.content?.last : nil )
                
                self.productPOs.append(productCellVM)
            }
        }
    }
    

    func numberOfRows() -> Int {
        return productPOs.count
    }
    
    func cellData(for row: Int) -> ProductPO {
        return productPOs[row]
    }
    
}

