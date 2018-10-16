//
//  WeatherViewController.swift
//  WeatherForecast
//
//  Created by Niloy Chakraborty on 15/10/2018.
//  Copyright © 2018 Niloy. All rights reserved.
//

import UIKit
protocol WeatherViewProtocol: class {
    func updateView()
    var viewModel: ForecastViewModel! { get set }
}

class WeatherViewController: UIViewController, WeatherViewProtocol {

    var viewModel: ForecastViewModel!
    lazy private var refreshControl: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action:
            #selector(WeatherViewController.refreshWeatherPage(_:)),
                                 for: .valueChanged)
        return refreshControl
    }()

    @IBOutlet weak var tableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        tableView.delegate = self
        tableView.dataSource = self
        self.tableView.rowHeight = 110.0
        tableView.addSubview(refreshControl)
        tableView.tableHeaderView = createTableHeaderView()
        let loadingIndicator = UIViewController.displayLoadingIndicator(onView: self.view)
        viewModel.getforecast() { [unowned self, loadingIndicator ] error in
            UIViewController.removeLoadingIndicator(spinner: loadingIndicator)
            guard let error = error as? WeatherAppError else {
                self.updateView()
                return
            }
            // SwitchCase Error Type to display Alert or show Empty Screen
            DispatchQueue.main.async{ [unowned self] in
                self.handleError(error)
            }
        }
    }

    private func handleError(_ error: WeatherAppError) {
        switch error {
        case .generalError(let title, let message):
            displayError(title: title, message: message)
            break
        case .networkError(let title, let message):
            displayError(title: title, message: message)
            break
        }
    }

    func updateView() {
        DispatchQueue.main.async{ [unowned self] in
            self.tableView.reloadData()
        }
    }

    private func displayError(title: String?, message: String?) {
        DispatchQueue.main.async{ [unowned self] in
            let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)

            let OKAction = UIAlertAction(title: "OK", style: .default)
            alertController.addAction(OKAction)

            self.present(alertController, animated: true, completion:nil)
        }
    }

    private func createTableHeaderView() -> UIView {
        let headerView = UIView(frame: CGRect(x: 0, y: 0, width: tableView.frame.width, height: 50))
        let myLabel = UILabel()
        myLabel.frame = CGRect(x: 10, y: 0, width: tableView.frame.width - 70, height: 50)
        myLabel.textColor = UIColor.gray
        myLabel.textAlignment = .left
        myLabel.text = SelectedCity
        headerView.addSubview(myLabel)
        return headerView
    }

    @objc private func refreshWeatherPage(_ sender: Any)
    {
        viewModel.refreshWeatherForecast() { [unowned self ] error in
            DispatchQueue.main.async{ [unowned self] in
                self.refreshControl.endRefreshing()
                //This is required to avart one typical issue where the Alert controller does not allow the TableView to go up and hide the regresh controller 
                self.tableView.setContentOffset(CGPoint.zero, animated: true)
                guard let error = error as? WeatherAppError else {
                    self.tableView.reloadData()
                    return
                }
                self.handleError(error)
            }

        }
    }
}

extension WeatherViewController: UITableViewDelegate {

}

extension WeatherViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel.forecastDisplayModelList.count
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        return viewModel.forecastDisplayModelList[section].forecastItems.count
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 30.0
    }

    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return viewModel.forecastDisplayModelList[section].sectionHeaderCurrentDateDisplayString
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "WeaherForecastCell", for: indexPath) as! WeatherForecastTableViewCell
        let forecastItem = viewModel.forecastDisplayModelList[indexPath.section].forecastItems[indexPath.row]
        cell.configure(with: forecastItem)
        return cell
    }
}
