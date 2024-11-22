from flask import Flask, render_template, request, redirect, url_for
from flask_sqlalchemy import SQLAlchemy

# Database connection URL
DATABASE_URL = "postgresql://postgres:12345678@db.c9a4moy2qoog.eu-north-1.rds.amazonaws.com:5432/postgres"


# Initialize Flask app
app = Flask(__name__)
app.config['SQLALCHEMY_DATABASE_URI'] = DATABASE_URL
app.config['SQLALCHEMY_TRACK_MODIFICATIONS'] = False  # Suppress deprecation warnings

# Initialize SQLAlchemy
db = SQLAlchemy(app)

# User Model
class User(db.Model):
    __tablename__ = 'users'
    email = db.Column(db.String, primary_key=True)
    name = db.Column(db.String, nullable=False)
    surname = db.Column(db.String, nullable=False)
    salary = db.Column(db.Float, nullable=False)
    cname = db.Column(db.String, nullable=False)
    phone = db.Column(db.String, nullable=False)

    def __repr__(self):
        return f"<User {self.email}>"

# Route to Add a User
@app.route('/user/add', methods=['GET', 'POST'])
def add_user():
    countries = [
        "Kazakhstan", "Uzbekistan", "Russia", "Brazil", "Germany",
        "China", "Japan", "South Korea", "USA", "India"
    ]
    if request.method == 'POST':
        new_user = User(
            email=request.form['email'],
            name=request.form['name'],
            surname=request.form['surname'],
            salary=float(request.form['salary']),
            cname=request.form['cname'],
            phone=request.form['phone']
        )
        try:
            db.session.add(new_user)
            db.session.commit()
            return redirect(url_for('list_users'))
        except Exception as e:
            db.session.rollback()
            return f"Error: {str(e)}", 500
    return render_template('add_user.html', countries=countries)

# Route to Update a User
@app.route('/user/update/<string:email>', methods=['GET', 'POST'])
def update_user(email):
    user = User.query.filter_by(email=email).first()
    countries = [
        "Kazakhstan", "Uzbekistan", "Russia", "Brazil", "Germany",
        "China", "Japan", "South Korea", "USA", "India"
    ]
    if not user:
        return "User not found", 404

    if request.method == 'POST':
        user.name = request.form['name']
        user.surname = request.form['surname']
        user.salary = float(request.form['salary'])
        user.cname = request.form['cname']
        user.phone = request.form['phone']
        try:
            db.session.commit()
            return redirect(url_for('list_users'))
        except Exception as e:
            db.session.rollback()
            return f"Error: {str(e)}", 500

    return render_template('update_user.html', user=user, countries=countries)

# Route to Delete a User
@app.route('/user/delete/<string:email>', methods=['POST'])
def delete_user(email):
    user = User.query.filter_by(email=email).first()
    if user:
        try:
            db.session.delete(user)
            db.session.commit()
            return redirect(url_for('list_users'))
        except Exception as e:
            db.session.rollback()
            return f"Error: {str(e)}", 500
    return "User not found", 404

# Route to List All Users
@app.route('/user', methods=['GET'])
def list_users():
    users = User.query.all()
    return render_template('users.html', users=users)

class Country(db.Model):
    __tablename__ = 'country'
    cname = db.Column(db.String(100), primary_key=True)
    population = db.Column(db.Integer, nullable=False)

class Discover(db.Model):
    __tablename__ = 'discover'
    cname = db.Column(db.String(100), db.ForeignKey('country.cname'), primary_key=True)
    disease_code = db.Column(db.String(50), primary_key=True)
    first_enc_date = db.Column(db.Date, nullable=False)

class Disease(db.Model):
    __tablename__ = 'disease'
    disease_code = db.Column(db.String(50), primary_key=True)
    pathogen = db.Column(db.String(100), nullable=False)
    description = db.Column(db.String(255), nullable=False)
    id = db.Column(db.Integer, db.ForeignKey('diseasetype.id'), nullable=False)

class DiseaseType(db.Model):
    __tablename__ = 'diseasetype'
    id = db.Column(db.Integer, primary_key=True)
    description = db.Column(db.String(100), nullable=False)

class Doctor(db.Model):
    __tablename__ = 'doctor'
    email = db.Column(db.String(255), db.ForeignKey('users.email'), primary_key=True)
    degree = db.Column(db.String(50), nullable=False)

class PatientDisease(db.Model):
    __tablename__ = 'patientdisease'
    email = db.Column(db.String(255), db.ForeignKey('users.email'), primary_key=True)
    disease_code = db.Column(db.String(50), db.ForeignKey('disease.disease_code'), primary_key=True)

# Main Dashboard Route
@app.route('/')
def index():
    return render_template('index.html')



# Country Routes
@app.route('/country', methods=['GET'])
def list_country():
    countries = Country.query.all()
    return render_template('country.html', countries=countries)

# Discover Routes
@app.route('/discover', methods=['GET'])
def list_discover():
    discovers = Discover.query.all()  # This fetches all Discover entries
    return render_template('discover.html', discoveries=discovers)  # Pass as 'discoveries'


# Disease Routes
@app.route('/disease', methods=['GET'])
def list_disease():
    diseases = Disease.query.all()
    return render_template('disease.html', diseases=diseases)

# DiseaseType Routes
@app.route('/diseasetype', methods=['GET'])
def list_diseasetype():
    diseasetypes = DiseaseType.query.all()
    return render_template('diseasetype.html', diseasetypes=diseasetypes)

# Doctor Routes
@app.route('/doctor', methods=['GET'])
def list_doctor():
    doctors = Doctor.query.all()
    return render_template('doctor.html', doctors=doctors)

# PatientDisease Routes
@app.route('/patientdisease', methods=['GET'])
def list_patientdisease():
    patientdiseases = PatientDisease.query.all()
    return render_template('patientdisease.html', patientdiseases=patientdiseases)

# Run the Flask app
if __name__ == '__main__':
    app.run(debug=True)
