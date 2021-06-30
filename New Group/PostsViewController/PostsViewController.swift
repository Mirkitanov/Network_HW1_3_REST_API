
import UIKit

class PostsViewController: UIViewController {
    
    private let tableView = UITableView(frame: .zero, style: .grouped)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupTableView()
        setupViews()
    }

    private func setupTableView() {
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.backgroundColor = .systemGray4
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(
            PostTableViewCell.self,
            forCellReuseIdentifier: String(describing: PostTableViewCell.self)
        )
   }
    
    private func setupViews() {
        view.addSubview(tableView)
        
        let constraints = [
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor)
        ]
        
        NSLayoutConstraint.activate(constraints)
    }
}

extension PostsViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return Storage.tableModel.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let tableSection: PostSection = Storage.tableModel[section]
        return tableSection.posts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: PostTableViewCell = tableView.dequeueReusableCell(withIdentifier: String(describing: PostTableViewCell.self), for: indexPath) as! PostTableViewCell
        
        let tableSection: PostSection = Storage.tableModel[indexPath.section]
        let post: Post = tableSection.posts[indexPath.row]
        
        cell.postInScreen = post
        
        return cell
    }
}

extension PostsViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return .zero
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        guard section == 0 else { return .zero }
        
        let headerView = UINib(nibName: "ProfileHeaderView", bundle: nil).instantiate(withOwner: nil, options: nil).first as! ProfileHeaderView

        return headerView.frame.height
    }
   
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
    
        let headerView = UINib(nibName: "ProfileHeaderView", bundle: nil).instantiate(withOwner: nil, options: nil).first as! ProfileHeaderView

        return headerView
    }
}
