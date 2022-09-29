//
//  ANFExploreCardTableViewController.swift
//  ANF Code Test
//

import UIKit

class ANFExploreCardTableViewController: UITableViewController {
    
    //MARK: - View Model
    var viewModel: ANFExploreCardViewModel? = ANFExploreCardViewModel()


    //MARK: - Override Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.tableFooterView = UIView()
        self.tableView.estimatedRowHeight = UIScreen.main.bounds.height
        self.title = "A&F mobile shoppers."
        self.viewModelBinding()
        self.viewModel?.viewDidLoad()
    }
            
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.viewModel?.numberOfRows() ?? 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = self.tableView.dequeueReusableCell(withIdentifier: String(describing: PramotionCardCell.self), for: indexPath) as? PramotionCardCell,
            let viewModel = self.viewModel?.cellData(for: indexPath.row) else {
            
            return UITableViewCell()
        }
        cell.product = viewModel
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}

//MARK: - View Model Binding
extension ANFExploreCardTableViewController {
    
    private func viewModelBinding() {
        
        self.viewModel?.completionHandler = { output in
            switch output {
            case .reloadData:
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            
            case .showError(let message):
                DispatchQueue.main.async {
                    showAlert(withTitle: "Error", Message: message, controller: self)
                }
                break
                
            }
        }
    }
    
}

