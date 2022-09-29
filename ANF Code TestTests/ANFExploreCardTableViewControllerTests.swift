//
//  ANF_Code_TestTests.swift
//  ANF Code TestTests
//


import XCTest
@testable import ANF_Code_Test

class ANFExploreCardTableViewControllerTests: XCTestCase {

    var testInstance: ANFExploreCardTableViewController!
    
    override func setUp() {
        let mainStoryboard = UIStoryboard(storyboard: .main)
        testInstance = mainStoryboard.instantiateViewController(withIdentifier: String(describing: ANFExploreCardTableViewController.self)) as? ANFExploreCardTableViewController
        let data = productMock.data(using: .utf8)!
        do {
            
            let productsList = try JSONDecoder().decode([Product].self, from: data)
            testInstance.viewModel = ANFExploreCardViewModel(products: productsList)
            testInstance.viewModel?.viewDidLoad()
            
        } catch let jsonErr {
            print("Error serializing json:", jsonErr)
        }
    }

    func test_numberOfSections_ShouldBeOne() {
        let numberOfSections = testInstance.numberOfSections(in: testInstance.tableView)
        XCTAssert(numberOfSections == 1, "table view should have 1 section")
    }
    
    func test_numberOfRows_ShouldBeOne() {
        let numberOfRows = testInstance.viewModel?.numberOfRows()
        XCTAssert(numberOfRows == 1, "table view should have 1 cells")
    }
    
    func test_cellForRowAtIndexPath_titleText_shouldNotBeBlank() {
        guard let firstCell = testInstance.tableView(testInstance.tableView, cellForRowAt: IndexPath(row: 0, section: 0)) as? PromotionCardCell else {
            return
        }
        XCTAssert(firstCell.productTitleLabel.text?.count ?? 0 > 0, "title should not be blank")
    }
    
    func testFirstProductItemImageShouldNotBeNil() {
        let firstCellViewModel = testInstance.viewModel?.cellData(for: 0)
        let imageURL = firstCellViewModel?.bgImageUrl
        XCTAssert(!(imageURL?.absoluteString.isEmpty ?? true), "image is not nil")
    }
}
