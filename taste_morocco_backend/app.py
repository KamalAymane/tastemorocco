from flask import Flask
from flask_cors import CORS
from config import Config
from extensions import db
from routes import register_routes  # ✅ make sure this line works

def create_app():
    app = Flask(__name__)
    app.config.from_object(Config)

    db.init_app(app)
    CORS(app)
    register_routes(app)

    @app.route('/')
    def index():
        return "TasteMorocco API is running 🎉"

    return app

app = create_app()

if __name__ == '__main__':
    app.run(debug=True, host='0.0.0.0', port=5000)
