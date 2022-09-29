//
//  PramotionCardCell.swift
//  ANF Code Test
//
//  Created by Nikhil on 28/09/22.
//

import UIKit

class PramotionCardCell: UITableViewCell {
    
    private var cachedImages = [Int: UIImage]()
    
    var product: ProductPO? {
        didSet {
            configure()
        }
    }
    
    //MARK: - Outlets
    @IBOutlet weak var backgroundImage: UIImageView!
    @IBOutlet weak var topDescriptionLabel: UILabel!
    @IBOutlet weak var productTitleLabel: UILabel!
    @IBOutlet weak var promoMessageLabel: UILabel!
    @IBOutlet weak var promoDescriptionLabel: UILabel!
    @IBOutlet weak var shopContent1: UIView! {
        didSet {
            shopContent1.layer.borderWidth = 1
            shopContent1.layer.borderColor = UIColor(red: 0.6, green: 0.6, blue: 0.5, alpha: 1).cgColor
            
        }
    }
    
    @IBOutlet weak var shopContent2: UIView! {
        didSet {
            shopContent2.layer.borderWidth = 1
            shopContent2.layer.borderColor = UIColor(red: 0.6, green: 0.6, blue: 0.5, alpha: 1).cgColor
        }
    }
    
    @IBOutlet weak var shopContent1Button: UIButton!
    @IBOutlet weak var shopContent2Button: UIButton!
    

    //MARK: - Override Methods
    override func prepareForReuse() {
        super.prepareForReuse()
        self.backgroundImage.image = nil
        
    }
        
    
    //MARK: - Public Methods
    func configure() {
        guard let product = self.product else {
            return
        }
        
        topDescriptionLabel.text = product.topDescription
        productTitleLabel.text = product.productTitle
        promoMessageLabel.text = product.promoMessage
        promoDescriptionLabel.attributedText = product.bottomDescription.toHtmlAttributedString()
        promoDescriptionLabel.textAlignment = .center
        shopContent1.isHidden = product.content1 == nil
        shopContent2.isHidden = product.content2 == nil
        shopContent1Button.setTitle(product.content1?.title, for: .normal)
        shopContent2Button.setTitle(product.content2?.title, for: .normal)
        
        self.loadImage()
        
    }
    
    //MARK: - Private Methods
    private func loadImage() {
        OperationQueue().addOperation {
            
            if let viewModel = self.product {
                if let image = self.cachedImages[viewModel.cellIndex] {
                    self.loadImageFromCache(image: image)
                    
                } else {
                    self.backgroundImage.downloadImage(from: viewModel.bgImageUrl) { image in
                        DispatchQueue.main.async {
                            self.backgroundImage.image = image
                            self.cachedImages[viewModel.cellIndex] = self.backgroundImage.image
                        }
                    }
                    
                }
            }
        }
    }
    
    private func loadImageFromCache(image: UIImage?) {
        DispatchQueue.main.async {
            self.backgroundImage.image = image
        }
    }

}
