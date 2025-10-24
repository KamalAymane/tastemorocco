from flask import Blueprint, request, jsonify
from extensions import db
from models import Product

product_bp = Blueprint('product', __name__)

# POST /products/add
@product_bp.route('/add', methods=['POST'])
def add_product():
    data = request.get_json()
    barcode = data.get('barcode')
    name = data.get('name')
    ingredients = data.get('ingredients')

    if not barcode or not name or not ingredients:
        return jsonify({'error': 'All fields (barcode, name, ingredients) are required'}), 400

    # Check if product already exists
    if Product.query.filter_by(barcode=barcode).first():
        return jsonify({'error': 'Product with this barcode already exists'}), 409

    new_product = Product(barcode=barcode, name=name, ingredients=ingredients)
    db.session.add(new_product)
    db.session.commit()

    return jsonify({'message': 'Product added successfully'}), 201


@product_bp.route('/<barcode>', methods=['GET'])
def get_product(barcode):
    product = Product.query.filter_by(barcode=barcode).first()

    if not product:
        return jsonify({'error': 'Product not found'}), 404

    return jsonify({
        'id': product.id,
        'barcode': product.barcode,
        'name': product.name,
        'ingredients': product.ingredients
    }), 200