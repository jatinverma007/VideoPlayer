//
//  ViewController.swift
//  VideoPlayer
//
//  Created by jatin verma on 29/04/21.
//

import UIKit
import SnapKit

class ViewController: UIViewController {

    var mainTableView: UITableView!
    let cellId = "HomeCell"
    @objc dynamic var currentIndex = 0
    var oldAndNewIndices = (0,0)
    
    var data = ["https://res.cloudinary.com/byosocial/video/upload/q_60/v1576476056/OnBoardingScreens/launch_onboarding_1.mp4", "https://res.cloudinary.com/byosocial/video/upload/q_60/v1576476055/OnBoardingScreens/launch_onboarding_2.mp4", "https://res.cloudinary.com/byosocial/video/upload/q_60/v1576476055/OnBoardingScreens/launch_onboarding_3.mp4", "https://res.cloudinary.com/byosocial/video/upload/q_60/v1576476056/OnBoardingScreens/launch_onboarding_4.mp4"]

    let viewModel = HomeViewModel()


    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.setAudioMode()
        setupView()
    }

    /// Set up Views
    func setupView(){
        mainTableView = UITableView()
        mainTableView.backgroundColor = .white
        mainTableView.translatesAutoresizingMaskIntoConstraints = false  // Enable Auto Layout
        mainTableView.tableFooterView = UIView()
        mainTableView.isPagingEnabled = true
        mainTableView.contentInsetAdjustmentBehavior = .never
        mainTableView.showsVerticalScrollIndicator = false
        mainTableView.separatorStyle = .none
        view.addSubview(mainTableView)
        mainTableView.snp.makeConstraints({ make in
            make.edges.equalToSuperview()
        })
        mainTableView.register(UINib(nibName: "HomeTableViewCell", bundle: nil), forCellReuseIdentifier: cellId)
        mainTableView.delegate = self
        mainTableView.dataSource = self
        mainTableView.prefetchDataSource = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if let cell = mainTableView.visibleCells.first as? HomeTableViewCell {
            cell.play()
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        if let cell = mainTableView.visibleCells.first as? HomeTableViewCell {
            cell.pause()
        }
    }

}


extension ViewController: UITableViewDelegate, UITableViewDataSource, UITableViewDataSourcePrefetching{
    func tableView(_ tableView: UITableView, prefetchRowsAt indexPaths: [IndexPath]) {
        //
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! HomeTableViewCell
        cell.configure(url: data[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return self.view.frame.height
    }
    
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if let cell = cell as? HomeTableViewCell{
            oldAndNewIndices.1 = indexPath.row
            currentIndex = indexPath.row
            cell.pause()
        }
    }
    
    func tableView(_ tableView: UITableView, didEndDisplaying cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        // Pause the video if the cell is ended displaying
        if let cell = cell as? HomeTableViewCell {
            cell.pause()
        }
    }

    
}

extension ViewController: UIScrollViewDelegate {
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        let cell = self.mainTableView.cellForRow(at: IndexPath(row: self.currentIndex, section: 0)) as? HomeTableViewCell
        cell?.replay()
    }
    
}
