//
//  FilmListViewController.swift
//  Omdb Api
//
//  Created by AbdulKadir Akkaş on 15.06.2021.
//

import UIKit
import Loaf


class FilmListViewController: UIViewController {

    //MARK: -UIElements
    
    @IBOutlet weak var searchBar: UISearchBar!
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var spinner: UIActivityIndicatorView!
    
    
    //MARK: - Properties
    var listOfFilms = [DetailFilm]() {
        didSet {
            
            DispatchQueue.main.async {
                self.spinner.stopAnimating()
                self.spinner.isHidden = true
                self.tableView.reloadData()
                self.navigationItem.title = "\(self.listOfFilms.count) Film found"
                
            }
        }
    }
    
    
    
    //MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        self.tableView.allowsSelection = true
        spinner.startAnimating()
    }
    
    
    //MARK: - Methods
     func setupView(){
        tableView.delegate = self
        tableView.dataSource = self
        searchBar.delegate = self
        
        searchBar.searchTextField.textColor = .black
        self.navigationController?.navigationBar.tintColor = UIColor.black
        //let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))

            //tableView.addGestureRecognizer(tap)
    }

    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let indeks = sender as? Int
        let destinationVC = segue.destination as! DetailViewController
        destinationVC.detailOfFilm = listOfFilms[indeks!]
        
    
    }
    
    
    //MARK: - Actions
    


}
//MARK: - Extensions
extension FilmListViewController : UITableViewDelegate , UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listOfFilms.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let film = listOfFilms[indexPath.row]
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell" , for: indexPath) as! FilmListTableViewCell
        cell.accessoryType = .disclosureIndicator
        cell.filmNameLabel.text = film.title_films
        cell.selectionStyle = .none
        
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.performSegue(withIdentifier: "toDetail", sender: indexPath.row)
    }
}


extension FilmListViewController : UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let searchBarText = searchBar.text  else {
            
            
            return
        }
        
        let filmRequest = APIRequest(filmName: searchBarText)
        filmRequest.getFilms { [weak self] result in
            switch result {
            case .failure( let error):
                DispatchQueue.main.async {
                    Loaf("Sonuç Bulunamadı", state: .error, location: .bottom , sender: self!).show()
                }
                print(error.localizedDescription)
                
            case.success(let films) :
                self?.listOfFilms = films
            }
            
        }
    }
    
}
