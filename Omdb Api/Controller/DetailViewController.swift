//
//  DetailViewController.swift
//  Omdb Api
//
//  Created by AbdulKadir Akkaş on 16.06.2021.
//

import UIKit
import SDWebImage
import Firebase
import FirebaseDatabase

class DetailViewController: UIViewController {

    //MARK: -UIElements
    
    @IBOutlet weak var filmName: UILabel!
    @IBOutlet weak var filmYear: UILabel!
    @IBOutlet weak var filmType: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    
    
    
    
    //MARK: - Properties
    var detailOfFilm :  DetailFilm?
    var ref : DatabaseReference!

    
    
    
    //MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        if detailOfFilm?.poster_films == nil {
            imageView.backgroundColor = .black
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        addFilmDetailToFireabse(film_Name: detailOfFilm!.title_films , film_Year: detailOfFilm!.year_films, film_Type: detailOfFilm!.type_films, film_Image: detailOfFilm!.poster_films)
    }
    
    //MARK: - Methods
     func setupView() {
        if let f = detailOfFilm {
            
            filmName.text = f.title_films
            filmYear.text = f.year_films
            filmType.text = f.type_films
            imageView.sd_setImage(with: URL(string: f.poster_films), completed: nil)
            
        }
        
        ref = Database.database().reference()
        
        
        
    }
    
    func addFilmDetailToFireabse (film_Name : String , film_Year : String  ,film_Type : String ,film_Image : String ) {
        let dict : [String : Any] = ["film_Name" : detailOfFilm?.title_films ,
                                     "film_Year" : detailOfFilm?.year_films ,
                                     "film_Type" : detailOfFilm?.type_films,
                                     "film_Image" : detailOfFilm?.poster_films
                                                                ]

        let newRef = ref.child("film").childByAutoId()
        newRef.setValue(dict)


    }
    
    //MARK: - Actions

}
