from flask import Blueprint, request, jsonify
from extensions import db
from models import ScanHistory, Product, User
from datetime import datetime
import requests

scan_bp = Blueprint('scan', __name__)

# ✅ Save barcode scan, even if product is not in local DB
@scan_bp.route('/', methods=['POST'])
def save_scan():
    data = request.get_json()
    email = data.get('email')
    barcode = data.get('barcode')
    product_name = data.get('product_name', 'Unknown Product')
    ingredients = data.get('ingredients', 'No ingredient info')  # ✅ new

    print(f"🔄 Saving scan | Email: {email} | Barcode: {barcode} | Product: {product_name}")

    user = User.query.filter_by(email=email).first()
    if not user:
        print("❌ User not found")
        return jsonify({'error': 'User not found'}), 404

    # Try to find or create product
    product = Product.query.filter_by(barcode=barcode).first()
    if not product:
        product = Product(barcode=barcode, name=product_name, ingredients=ingredients)  # ✅ save ingredients
        db.session.add(product)
        db.session.commit()
        print(f"✅ Product created: {product_name}")

    scan = ScanHistory(user_id=user.id, product_id=product.id, scanned_at=datetime.utcnow())
    db.session.add(scan)
    db.session.commit()

    print("✅ Scan saved successfully")
    return jsonify({'message': 'Scan saved successfully'}), 201

# ✅ Get scan history for the user
@scan_bp.route('/history', methods=['GET'])
def get_scan_history():
    email = request.args.get('email')
    print(f"📄 Getting scan history for {email}")
    user = User.query.filter_by(email=email).first()

    if not user:
        print("❌ User not found")
        return jsonify({'error': 'User not found'}), 404

    history = ScanHistory.query.filter_by(user_id=user.id).order_by(ScanHistory.scanned_at.desc()).all()

    results = []
    for scan in history:
        results.append({
            'product_name': scan.product.name or 'Unknown',
            'barcode': scan.product.barcode,
            'ingredients': scan.product.ingredients or 'N/A',
            'scanned_at': scan.scanned_at.isoformat()
        })

    print(f"✅ Found {len(results)} scan(s)")
    return jsonify({'history': results}), 200

# ✅ Get product info from Open Food Facts by barcode
@scan_bp.route('/barcode-info', methods=['POST'])
def get_barcode_info():
    data = request.get_json()
    barcode = data.get('barcode')
    print(f"🔎 Fetching Open Food Facts for barcode: {barcode}")

    if not barcode:
        return jsonify({'error': 'Barcode is required'}), 400

    api_url = f"https://world.openfoodfacts.org/api/v0/product/{barcode}.json"
    try:
        response = requests.get(api_url)
    except requests.exceptions.RequestException as e:
        print(f"❌ Connection error: {e}")
        return jsonify({'error': f'Failed to connect to Open Food Facts: {str(e)}'}), 502

    if response.status_code != 200:
        print(f"❌ Open Food Facts returned status code {response.status_code}")
        return jsonify({'error': f'Open Food Facts returned status code {response.status_code}'}), 502

    result = response.json()
    if result.get('status') != 1:
        print("❌ Product not found in Open Food Facts")
        return jsonify({'error': 'Product not found in Open Food Facts'}), 404

    product = result.get('product', {})
    print(f"✅ Product found: {product.get('product_name', 'Unknown')}")

    return jsonify({
        'name': product.get('product_name', 'Unknown'),
        'brand': product.get('brands', ''),
        'score': product.get('nutriscore_score'),
        'grade': product.get('nutriscore_grade', '').upper(),
        'image': product.get('image_front_url'),
        'nutriments': {
            'sugars_100g': product.get('nutriments', {}).get('sugars_100g'),
            'energy_kcal_100g': product.get('nutriments', {}).get('energy-kcal_100g'),
            'saturated_fat_100g': product.get('nutriments', {}).get('saturated-fat_100g'),
            'fruits_vegetables_100g': product.get('nutriments', {}).get('fruits-vegetables-nuts_100g'),
        },
        'additives_count': product.get('additives_n', 0),
        'ingredients': product.get('ingredients_text', 'No ingredient info')  # ✅ needed for frontend
    })
