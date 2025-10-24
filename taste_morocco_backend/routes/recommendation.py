# routes/recommendation.py

from flask import Blueprint, request, jsonify
import pandas as pd
from extensions import db
from models import User

recommendation_bp = Blueprint('recommendation', __name__)

# Load dishes CSV once (must include 'name', 'ingredients', and 'category' columns)
df = pd.read_csv('dishes.csv')

@recommendation_bp.route('/get', methods=['GET'])
def get_filtered_recommendations():
    email = request.args.get('email')
    if not email:
        return jsonify({'error': 'Email is required'}), 400

    email = email.strip().lower()  # Normalize email

    print(f"[DEBUG] Searching for user with email: '{email}'")
    all_users = User.query.all()
    print("[DEBUG] All users in DB:")
    for user in all_users:
        print(f" - {user.email.strip().lower()}")

    # Case-insensitive matching
    user = User.query.filter(User.email.ilike(email)).first()
    if not user:
        return jsonify({'error': 'User not found'}), 404

    if not user.allergies:
        return jsonify([])

    allergy_list = [a.strip().lower() for a in user.allergies.split(',') if a.strip()]
    print(f"[DEBUG] Allergies for {email}: {allergy_list}")

    def is_safe(ingredients):
        ingredients_lower = ingredients.lower()
        return not any(allergy in ingredients_lower for allergy in allergy_list)

    safe_dishes = df[df['ingredients'].apply(is_safe)]

    if not safe_dishes.empty:
        print("[DEBUG] Returning sample:", safe_dishes.iloc[0].to_dict())

    return jsonify([
        {
            'name': row['name'],
            'ingredients': row['ingredients'],
            'category': row.get('category', '')  # ✅ Include category safely
        }
        for _, row in safe_dishes.iterrows()
    ])
