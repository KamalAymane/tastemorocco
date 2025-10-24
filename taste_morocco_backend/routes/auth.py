from flask import Blueprint, request, jsonify
from extensions import db
from models import User
from werkzeug.security import generate_password_hash, check_password_hash

auth_bp = Blueprint('auth', __name__)

@auth_bp.route('/signup', methods=['POST'])
def signup():
    data = request.get_json()
    email = data.get('email')
    password = data.get('password')
    allergies = data.get('allergies', '')

    if not email or not password:
        return jsonify({'error': 'Email and password required'}), 400

    if User.query.filter_by(email=email).first():
        return jsonify({'error': 'User already exists'}), 409

    hashed_password = generate_password_hash(password)
    new_user = User(email=email, password=hashed_password, allergies=allergies)
    db.session.add(new_user)
    db.session.commit()

    return jsonify({'message': 'User created successfully'}), 201

@auth_bp.route('/login', methods=['POST'])
def login():
    data = request.get_json()
    email = data.get('email')
    password = data.get('password')

    if not email or not password:
        return jsonify({'error': 'Email and password are required'}), 400

    user = User.query.filter_by(email=email).first()
    if user and check_password_hash(user.password, password):
        return jsonify({
            'message': 'Login successful',
            'user': {
                'id': user.id,
                'email': user.email,
                'allergies': user.allergies
            }
        }), 200
    else:
        return jsonify({'error': 'Invalid credentials'}), 401

@auth_bp.route('/update_allergies', methods=['POST'])
def update_allergies():
    data = request.get_json()
    email = data.get('email')
    allergies = data.get('allergies')

    if not email or allergies is None:
        return jsonify({'error': 'Email and allergies are required'}), 400

    user = User.query.filter_by(email=email).first()
    if not user:
        return jsonify({'error': 'User not found'}), 404

    user.allergies = ','.join(allergies)  # Save as comma-separated string
    db.session.commit()

    return jsonify({'message': 'Allergies updated successfully'}), 200

# ✅ Add this for testing
@auth_bp.route('/test', methods=['GET'])
def test_auth():
    return jsonify({'message': '✅ Auth blueprint is working'})
