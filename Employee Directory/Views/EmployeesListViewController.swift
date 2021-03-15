//
//  EmployeesListViewController.swift
//  Employee Directory
//
//  Created by Bradford Chessin on 3/10/21.
//

import Foundation
import UIKit

final class EmployeesListViewController: UITableViewController {
    static internal let cellIdentifier = "EmployeeCell"
    var employeesListViewModel: EmployeesListViewModel = EmployeesListViewModel()
    
    // MARK: UI
    private (set) lazy var loadingIndicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView(style: .large)
        indicator.color = .squareLightGray
        indicator.translatesAutoresizingMaskIntoConstraints = false
        indicator.hidesWhenStopped = true
        return indicator
    }()
    
    private (set) lazy var emptyOrErrorLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.translatesAutoresizingMaskIntoConstraints = true
        return label
    }()
    
    private func setupLoadingIndicator() {
        loadingIndicator.startAnimating()
        self.view.addSubview(loadingIndicator)
        
        // Make sure the indicator is centered in the view
        loadingIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        loadingIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
    }
    
    private func setupTableView() {
        // Show the UITableView and ensure it fills the entire view
        self.tableView.separatorStyle = .singleLine
    }
    
    func setupEmptyOrErrorView(withMessage message: String) {
        emptyOrErrorLabel.text = message
        self.tableView.backgroundView = emptyOrErrorLabel
        self.tableView.separatorStyle = .none
    }
    
    // MARK: Lifecycle Events
    override func viewDidLoad() {
        self.navigationItem.title = StringHelper.employeeDirectory
        self.tableView.register(EmployeesListCell.self, forCellReuseIdentifier: EmployeesListViewController.cellIdentifier)
        
        setupLoadingIndicator()
        
        employeesListViewModel.loadEmployees({ (state) in
            self.loadingIndicator.stopAnimating()
            
            // Check what state we should go into
            switch state {
            case .empty:
                self.setupEmptyOrErrorView(withMessage: StringHelper.noEmployees)
            case .success:
                self.setupTableView()
            case .failure(let errorMessage):
                self.setupEmptyOrErrorView(withMessage: errorMessage)
            }
            
            // Reload the tableview after our state has changed
            self.tableView.reloadData()
        })
    }
}

extension EmployeesListViewController {
    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    override func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return employeesListViewModel.numberOfEmployees()
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let employeeCell = tableView.dequeueReusableCell(withIdentifier: EmployeesListViewController.cellIdentifier, for: indexPath) as! EmployeesListCell
        employeeCell.selectionStyle = .none
        
        // Grab the current employee and set up the cell
        if let employee = employeesListViewModel.employeeAt(index: indexPath.row) {
            let networkingService = employeesListViewModel.networkingService
            let cacheService = employeesListViewModel.cacheService
            employeeCell.setData(employee: employee, networking: networkingService, cacheService: cacheService)
        }
        
        return employeeCell
    }
}
