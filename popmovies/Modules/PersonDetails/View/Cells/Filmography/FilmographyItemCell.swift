//
//  FilmographyItemCell.swift
//  popmovies
//
//  Created by Tiago Silva on 20/06/19.
//  Copyright © 2019 Tiago Silva. All rights reserved.
//

import UIKit

class FilmographyItemCell: UICollectionViewCell {
    
    @IBOutlet weak var posterMovieView: UIImageView!
    @IBOutlet weak var titleView: UILabel!
    @IBOutlet weak var subtitleView: UILabel!
    @IBOutlet weak var depatmentsView: UILabel!
    
    var filmographyItem: FilmographyDTO? {
        didSet { bindFilmographyItem(self.filmographyItem!) }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        contentView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            contentView.leftAnchor.constraint(equalTo: leftAnchor),
            contentView.rightAnchor.constraint(equalTo: rightAnchor),
            contentView.topAnchor.constraint(equalTo: topAnchor),
            contentView.bottomAnchor.constraint(equalTo: bottomAnchor)
            ])
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
    }
    
    private func bindFilmographyItem(_ filmographyItem: FilmographyDTO) {
        posterMovieView.setTMDBImageBy(url: filmographyItem.movie?.posterPath, contentSize: TMDB.ImageSize.POSTER.w500, contentMode: .scaleAspectFill, placeholder: R.image.moviePlaceholder.name)
        posterMovieView.hero.id = String(describing: filmographyItem.movie?.posterPath)
        titleView.text = filmographyItem.movie?.title
        
        var subtitle: String = ""
        
        if let releaseDate = filmographyItem.movie?.releaseDate {
            subtitle.append("\(releaseDate.formatDate()) | ")
        }
        
        subtitle.append(filmographyItem.movie?.originalTitle ?? "")
        depatmentsView.text = filmographyItem.workingAs
    }
}

