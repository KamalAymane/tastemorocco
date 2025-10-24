# 🍽️ Taste Morocco
[PROJET PFA 4IIR G2 GROUP H (1).pdf](https://github.com/user-attachments/files/20554178/PROJET.PFA.4IIR.G2.GROUP.H.1.pdf)

A comprehensive Flutter mobile application that celebrates Moroccan cuisine through AI-powered food recognition, personalized recommendations, and cultural exploration.

## 🌟 Features

### 📱 Mobile App (Flutter)
- **Food Scanner**: AI-powered barcode and image recognition for Moroccan products
- **Recipe Recommendations**: Personalized suggestions based on user preferences and allergies
- **Cultural Exploration**: Discover authentic Moroccan dishes with detailed information
- **Interactive Map**: Find restaurants and food locations across Morocco
- **User Authentication**: Secure login and registration system
- **Scan History**: Track your food discoveries and preferences

### 🔧 Backend API (Python Flask)
- **Machine Learning**: Advanced recommendation algorithms
- **Product Database**: Comprehensive database of Moroccan food products
- **Authentication**: Secure user management system
- **RESTful API**: Well-structured endpoints for mobile app integration

## 🏗️ Project Structure

```
tasteMorocco/
├── pfaprojet/                    # Flutter Mobile App
│   ├── lib/
│   │   ├── models/              # Data models
│   │   ├── screens/             # UI screens
│   │   ├── services/            # API and business logic
│   │   └── widgets/             # Reusable UI components
│   ├── assets/                  # Images and resources
│   └── android/ios/             # Platform-specific code
│
├── taste_morocco_backend/        # Python Flask Backend
│   ├── routes/                  # API endpoints
│   ├── ml/                      # Machine learning models
│   ├── models.py               # Database models
│   └── app.py                  # Flask application
│
└── README.md                   # This file
```

## 🚀 Getting Started

### Prerequisites
- Flutter SDK (3.0+)
- Python 3.8+
- Android Studio / Xcode (for mobile development)
- Git

### Mobile App Setup

1. **Clone the repository**
   ```bash
   git clone https://github.com/KamalAymane/tastemorocco.git
   cd tasteMorocco/pfaprojet
   ```

2. **Install dependencies**
   ```bash
   flutter pub get
   ```

3. **Run the app**
   ```bash
   flutter run
   ```

### Backend Setup

1. **Navigate to backend directory**
   ```bash
   cd taste_morocco_backend
   ```

2. **Create virtual environment**
   ```bash
   python -m venv venv
   source venv/bin/activate  # On Windows: venv\Scripts\activate
   ```

3. **Install dependencies**
   ```bash
   pip install -r requirements.txt
   ```

4. **Run the server**
   ```bash
   python app.py
   ```

## 📱 Screenshots

**Authentification sécurisée** (inscription/connexion)

  ![image](https://github.com/user-attachments/assets/86482910-dd88-40a4-b9ea-dee0e6725c02)

- **Sélection d’allergènes** marocains ou classiques
  ![image](https://github.com/user-attachments/assets/b9a2dd35-5fa3-4ca0-8553-c2212b2753be)

- **Recommandation de plats marocains** adaptés
  ![image](https://github.com/user-attachments/assets/550e832f-0b0e-480c-b455-b863e88dd431)

- **Fiches recettes détaillées**
  ![image](https://github.com/user-attachments/assets/e7bcde8c-39f6-458b-a57c-b1fb279ae0a2)

- **Scanner de code-barres** (API Open Food Facts)
  ![image](https://github.com/user-attachments/assets/da04c501-164d-4ff6-a2cc-8818b0108249)

- **Analyse nutritionnelle** des produits scannés
  ![image](https://github.com/user-attachments/assets/85992df7-42ac-4be0-bb6a-809d31af4543)

- **Historique personnel des scans**
  ![image](https://github.com/user-attachments/assets/1f3d64ff-3cf3-416a-8160-263861a41470)

- **Carte interactive** des établissements compatibles (prévue)
![image](https://github.com/user-attachments/assets/dd93ee9b-93b5-4cb8-9f27-bd1f3e5723a0)

## 🛠️ Technologies Used
 **Flutter** (Dart) : UI responsive, animations et navigation fluide

### Backend
- **Flask** (Python) : API REST, communication client/serveur
- **SQLite** : Base de données embarquée

### APIs et outils
- **Open Food Facts API** : Analyse de produits alimentaires par code-barres
- **Postman** : Test et validation des requêtes API
- **Scikit-learn & NLTK** (préparés pour version future) : Recommandation intelligente et traitement de texte
## ⚙️ Architecture du projet

Architecture **MVC répartie** :
- **Modèle** : Flask + SQLite (gestion des données, validation, stockage)
- **Vue** : Flutter (UI mobile : pages de login, recommandations, scan…)
- **Contrôleur** : logique Flutter (actions utilisateurs) + routes Flask
## 🍽️ Moroccan Dishes Featured

The app includes a comprehensive collection of authentic Moroccan dishes:

- **Tajines**: Lamb, chicken, and vegetable tajines
- **Couscous**: Traditional Moroccan couscous variations
- **Pastilla**: Sweet and savory pastries
- **Harira**: Traditional soup
- **Mint Tea**: Moroccan tea culture
- **And many more...**

## 🤝 Contributing

We welcome contributions to Taste Morocco! Here's how you can help:

1. **Fork the repository**
2. **Create a feature branch** (`git checkout -b feature/amazing-feature`)
3. **Commit your changes** (`git commit -m 'Add some amazing feature'`)
4. **Push to the branch** (`git push origin feature/amazing-feature`)
5. **Open a Pull Request**

### Development Guidelines
- Follow Flutter/Dart coding standards
- Write meaningful commit messages
- Add tests for new features
- Update documentation as needed


## 👥 Team

- **Aymane Kamal** - Poject Lead & Developer
- **Aymane Kamal** - Developer

## 🙏 Acknowledgments

- Moroccan culinary experts for authentic recipes
- Flutter and Python communities
- Open source contributors

## 📞 Contact

- **GitHub**: [@KamalAymane](https://github.com/KamalAymane)
- **GitHub**: [@douaaea](https://github.com/douaaea)
- **Project Link**: [https://github.com/KamalAymane/tastemorocco](https://github.com/KamalAymane/tastemorocco)

## 🔮 Future Enhancements

- [ ] Multi-language support (Arabic, French, English)
- [ ] Social features (sharing recipes, reviews)
- [ ] Offline mode for recipe browsing
- [ ] Integration with local restaurants
- [ ] Voice-guided cooking instructions
- [ ] Nutritional information tracking

---

**Made with ❤️ for Moroccan cuisine lovers worldwide**
