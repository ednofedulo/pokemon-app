//
//  DetailViewController.swift
//  pokemon-app
//
//  Created by Edno Fedulo on 26/12/20.
//

import UIKit

protocol DetailViewDelegate:AnyObject {
    func setupView(pokemon:PokemonModel)
}

class DetailViewController: UIViewController {
    
    lazy var headerBackgroundView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    var headerView: DetailHeaderView?
    
    lazy var tabBarStackView:UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        
        let aboutButton = UIButton()
        aboutButton.setTitle("About", for: .normal)
        aboutButton.addTarget(self, action: #selector(showAbout(sender:)), for: .touchUpInside)
        
        let statsButton = UIButton()
        statsButton.setTitle("Stats", for: .normal)
        statsButton.addTarget(self, action: #selector(showStats(sender:)), for: .touchUpInside)
        statsButton.setBackgroundImage(UIImage(named: "pokeball-full"), for: .normal)
        statsButton.layoutIfNeeded()
        statsButton.subviews.first?.contentMode = .scaleAspectFit
        
        let evolutionButton = UIButton()
        evolutionButton.setTitle("Evolution", for: .normal)
        evolutionButton.addTarget(self, action: #selector(showEvolution(sender:)), for: .touchUpInside)
        
        stackView.heightAnchor.constraint(equalToConstant: 40).isActive = true
        
        stackView.addArrangedSubview(aboutButton)
        stackView.addArrangedSubview(statsButton)
        stackView.addArrangedSubview(evolutionButton)
        
        return stackView
    }()
    
    lazy var detailContainerView:UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 30
        view.layer.cornerCurve = .continuous
        view.backgroundColor = .white
        return view
    }()
    
    lazy var scrollView:UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.delegate = self
        
        return scrollView
    }()
    
    lazy var scrollViewContainerView:UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    var detailContainerViewTopConstraint:NSLayoutConstraint?
    
    var label = UILabel()
    
    var presenter:DetailPresenter?
    
    init(presenter:DetailPresenter) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addSubviews()
        setupConstraints()
        setupView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.isTranslucent = true
        navigationController?.navigationBar.tintColor = .white
    }
    
    private func addSubviews(){
        self.headerView = DetailHeaderView(pokemon: self.presenter!.pokemon!)
        self.headerView?.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(headerBackgroundView)
        headerBackgroundView.addSubview(self.headerView!)
        self.view.addSubview(tabBarStackView)
        self.view.addSubview(detailContainerView)
        detailContainerView.addSubview(scrollView)
        scrollView.addSubview(scrollViewContainerView)
        scrollViewContainerView.addSubview(label)
        
        label.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private func setupConstraints(){
        NSLayoutConstraint.activate([
            headerBackgroundView.topAnchor.constraint(equalTo: self.view.topAnchor),
            headerBackgroundView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            headerBackgroundView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            headerBackgroundView.heightAnchor.constraint(equalToConstant: 280)
        ])
        
        detailContainerViewTopConstraint = detailContainerView.topAnchor.constraint(equalTo: headerBackgroundView.bottomAnchor, constant: -30)
        
        NSLayoutConstraint.activate([
            detailContainerView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            detailContainerView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            detailContainerViewTopConstraint!,
            detailContainerView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor)
        ])
        
        NSLayoutConstraint.activate([
            tabBarStackView.leadingAnchor.constraint(equalTo: detailContainerView.leadingAnchor, constant: 10),
            tabBarStackView.bottomAnchor.constraint(equalTo: detailContainerView.topAnchor, constant: -5),
            tabBarStackView.trailingAnchor.constraint(equalTo: detailContainerView.trailingAnchor, constant: -10)
        ])
        
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: self.detailContainerView.topAnchor, constant: 20),
            scrollView.leadingAnchor.constraint(equalTo: self.detailContainerView.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: self.detailContainerView.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: self.detailContainerView.bottomAnchor)
        ])
        
        NSLayoutConstraint.activate([
            scrollViewContainerView.topAnchor.constraint(equalTo: self.scrollView.topAnchor),
            scrollViewContainerView.leadingAnchor.constraint(equalTo: self.scrollView.leadingAnchor),
            scrollViewContainerView.trailingAnchor.constraint(equalTo: self.scrollView.trailingAnchor),
            scrollViewContainerView.bottomAnchor.constraint(equalTo: self.scrollView.bottomAnchor),
            scrollViewContainerView.widthAnchor.constraint(equalTo: self.detailContainerView.widthAnchor),
        ])
        
        NSLayoutConstraint.activate([
            label.topAnchor.constraint(equalTo: scrollViewContainerView.topAnchor),
            label.leadingAnchor.constraint(equalTo: scrollViewContainerView.leadingAnchor, constant: 10),
            label.trailingAnchor.constraint(equalTo: scrollViewContainerView.trailingAnchor, constant: -10),
            scrollViewContainerView.bottomAnchor.constraint(equalTo: label.bottomAnchor)
        ])
        
        NSLayoutConstraint.activate([
            headerView!.centerXAnchor.constraint(equalTo: headerBackgroundView.centerXAnchor),
            headerView!.topAnchor.constraint(equalTo: headerBackgroundView.safeAreaLayoutGuide.topAnchor, constant: -23)
        ])
    }
    
    private func setupView(){
        label.numberOfLines = 0
        
        label.text = "1312312312312  j1 ifo1 of1o 1n3oin13f on31fono3f no13f no 13fonf13 onfo  o1 of 3nf31 13fno fn13 fno1nfo31nifno f f ofnof3n1ofn13of31onf  f3f31f13  1 f 13 31f313f f 1f 1 31f 13f13113f13f13f13f13   1 133131f13f 1 13 13 1 f13 13f 31ff 1f1f1312312312312  j1 ifo1 of1o 1n3oin13f on31fono3f no13f no 13fonf13 onfo  o1 of 3nf31 13fno fn13 fno1nfo31nifno f f ofnof3n1ofn13of31onf  f3f31f13  1 f 13 31f313f f 1f 1 31f 13f13113f13f13f13f13   1 133131f13f 1 13 13 1 f13 13f 31ff 1f1f1312312312312  j1 ifo1 of1o 1n3oin13f on31fono3f no13f no 13fonf13 onfo  o1 of 3nf31 13fno fn13 fno1nfo31nifno f f ofnof3n1ofn13of31onf  f3f31f13  1 f 13 31f313f f 1f 1 31f 13f13113f13f13f13f13   1 133131f13f 1 13 13 1 f13 13f 31ff1312312312312  j1 ifo1 of1o 1n3oin13f on31fono3f no13f no 13fonf13 onfo  o1 of 3nf31 13fno fn13 fno1nfo31nifno f f ofnof3n1ofn13of31onf  f3f31f13  1 f 13 31f313f f 1f 1 31f 13f13113f13f13f13f13   1 133131f13f 1 13 13 1 f13 13f 31ff 1f1f1312312312312  j1 ifo1 of1o 1n3oin13f on31fono3f no13f no 13fonf13 onfo  o1 of 3nf31 13fno fn13 fno1nfo31nifno f f ofnof3n1ofn13of31onf  f3f31f13  1 f 13 31f313f f 1f 1 31f 13f13113f13f13f13f13   1 133131f13f 1 13 13 1 f13 13f 31ff 1f1f1312312312312  j1 ifo1 of1o 1n3oin13f on31fono3f no13f no 13fonf13 onfo  o1 of 3nf31 13fno fn13 fno1nfo31nifno f f ofnof3n1ofn13of31onf  f3f31f13  1 f 13 31f313f f 1f 1 31f 13f13113f13f13f13f13   1 133131f13f 1 13 13 1 f13 13f 31ff1312312312312  j1 ifo1 of1o 1n3oin13f on31fono3f no13f no 13fonf13 onfo  o1 of 3nf31 13fno fn13 fno1nfo31nifno f f ofnof3n1ofn13of31onf  f3f31f13  1 f 13 31f313f f 1f 1 31f 13f13113f13f13f13f13   1 133131f13f 1 13 13 1 f13 13f 31ff 1f1f1312312312312  j1 ifo1 of1o 1n3oin13f on31fono3f no13f no 13fonf13 onfo  o1 of 3nf31 13fno fn13 fno1nfo31nifno f f ofnof3n1ofn13of31onf  f3f31f13  1 f 13 31f313f f 1f 1 31f 13f13113f13f13f13f13   1 133131f13f 1 13 13 1 f13 13f 31ff 1f1f1312312312312  j1 ifo1 of1o 1n3oin13f on31fono3f no13f no 13fonf13 onfo  o1 of 3nf31 13fno fn13 fno1nfo31nifno f f ofnof3n1ofn13of31onf  f3f31f13  1 f 13 31f313f f 1f 1 31f 13f13113f13f13f13f13   1 133131f13f 1 13 13 1 f13 13f 31ff"
    }
    
    func updateTabBar(sender:UIButton){
        for view in tabBarStackView.arrangedSubviews where view is UIButton {
            let button = view as! UIButton
            
            if button == sender {
                button.setBackgroundImage(UIImage(named: "pokeball-full"), for: .normal)
            } else {
                button.setBackgroundImage(nil, for: .normal)
            }
            
            button.layoutIfNeeded()
            button.subviews.first?.contentMode = .scaleAspectFit
        }
    }
    
    @objc func showAbout(sender:UIButton){
        debugPrint("not implemented yet")
        
    }
    
    @objc func showStats(sender:UIButton){
        
    }
    
    @objc func showEvolution(sender:UIButton){
        debugPrint("not implemented yet")
    }
    
}

extension DetailViewController:UIScrollViewDelegate {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        if scrollView.contentOffset.y >= 40 {
            self.detailContainerViewTopConstraint?.constant = -110
            self.headerView?.loadShrinkedConstraints()
            
        } else if scrollView.contentOffset.y <= 0 {
            self.detailContainerViewTopConstraint?.constant = -30
            self.headerView?.loadExpandedConstraints()
            
        }
        
        UIViewPropertyAnimator(duration: 0.3, curve: .easeOut) {
            self.view.layoutIfNeeded()
        }.startAnimation()
    }
    
    
}

extension DetailViewController: DetailViewDelegate {
    func setupView(pokemon: PokemonModel) {
        headerBackgroundView.backgroundColor = pokemon.mainType()?.backgroundColor()
    }
}
