//
//  DetailsViewController.swift
//  movie-app
//
//  Created by Omar on 06/07/2025.
//

import UIKit

class DetailsViewController: BaseViewController {
    
    @IBOutlet weak var posterImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var releaseDateLabel: UILabel!
    @IBOutlet weak var ratingLabel: UILabel!
    @IBOutlet weak var overviewTextView: UITextView!
    @IBOutlet weak var favoriteButton: UIButton!
    
    private var movie: MovieModel?
    private var viewModel: MoviesViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.movie = props?["movie"] as? MovieModel
        self.viewModel = props?["viewModel"] as? MoviesViewModel
        setupUI()
    }

    
    private func setupUI() {
        guard let movie = movie else { return }
        
        // Configure UI with movie data
        titleLabel.text = movie.title
        releaseDateLabel.text = "Release Date: \(formatDate(movie.releaseDate))"
        ratingLabel.text = "⭐ \(String(format: "%.1f", movie.voteAverage))"
        overviewTextView.text = movie.overview
        posterImageView.sd_setImage(
            with: URL(string: ApiEndPoints.ImageUrl + movie.posterPath),
            placeholderImage: UIImage(named: movie.title)
        )
        updateFavoriteButton()
    }
    
    private func formatDate(_ dateString: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        if let date = dateFormatter.date(from: dateString) {
            dateFormatter.dateFormat = "MMMM d, yyyy"
            return dateFormatter.string(from: date)
        }
        return dateString
    }
    
    private func updateFavoriteButton() {
        guard let movie = movie else { return }
        let heartIcon = movie.isFavourite ? "heart.fill" : "heart"
        favoriteButton.setImage(UIImage(systemName: heartIcon), for: .normal)
    }
    
    @IBAction func favoriteButtonTapped(_ sender: UIButton) {
        guard var movie = movie, let viewModel = viewModel else { return }
        viewModel.toggleFavorite(movie: movie)
        movie.isFavourite.toggle()
        self.movie = movie
        self.updateFavoriteButton()
    }
}
