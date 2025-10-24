# 🍽️ Taste Morocco

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

*Add screenshots of your app here*

## 🛠️ Technologies Used

### Frontend (Flutter)
- **Flutter**: Cross-platform mobile development
- **Dart**: Programming language
- **Firebase**: Authentication and cloud services
- **Google Maps**: Location services
- **Camera**: Barcode and image scanning

### Backend (Python)
- **Flask**: Web framework
- **SQLAlchemy**: Database ORM
- **Machine Learning**: Recommendation algorithms
- **RESTful API**: API design

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

## 📄 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## 👥 Team

- **Aymane Kamal** - Project Lead & Developer
- *Add other team members here*

## 🙏 Acknowledgments

- Moroccan culinary experts for authentic recipes
- Flutter and Python communities
- Open source contributors

## 📞 Contact

- **GitHub**: [@KamalAymane](https://github.com/KamalAymane)
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
