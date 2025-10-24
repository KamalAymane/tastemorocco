from .auth import auth_bp
from .product import product_bp
from .recommendation import recommendation_bp
from .scan import scan_bp

def register_routes(app):
    app.register_blueprint(auth_bp, url_prefix='/auth')
    app.register_blueprint(product_bp, url_prefix='/products')
    app.register_blueprint(recommendation_bp, url_prefix='/recommendations')
    app.register_blueprint(scan_bp, url_prefix='/scan')
