# 🚑 Disease Information and Reporting System (DIRS)

## 📌 Overview
The **Disease Information and Reporting System (DIRS)** is a web-based application built with **Flask** and **PostgreSQL** to efficiently manage disease records, user information, and healthcare data. It allows for tracking diseases, medical professionals, and patient records in an interactive and structured manner.

## 🌟 Features

### 🏥 User Management
- Create, update, delete, and list users with details such as name, surname, salary, company, and phone number.

### 🌍 Country Data Tracking
- Store country names along with their population for reference in disease tracking.

### 🦠 Disease Management
- Maintain records of diseases, their pathogens, descriptions, and associated disease types.

### 📅 Disease Discovery Tracking
- Record the first encounter dates of diseases in specific countries for historical tracking.

### 👩‍⚕️ Doctor Registry
- Manage doctors and their medical qualifications linked to registered users.

### 🤒 Patient Disease Records
- Track which patients have been diagnosed with specific diseases, providing better insights into public health.

## 🛠️ Tech Stack

- **Backend:** Flask (Python) 🐍
- **Database:** PostgreSQL (SQLAlchemy ORM) 🗄️
- **Frontend:** Jinja2 Templates 🎨
- **Hosting:** AWS RDS for PostgreSQL ☁️

## 🚀 Installation & Setup

### Prerequisites
Ensure you have the following installed:
- Python 3.12+ 🐍
- PostgreSQL 📦
- Flask & SQLAlchemy 📜

### Clone the Repository
```sh
$ git clone https://github.com/your-repo/dirs.git
$ cd dirs
```

### Install Dependencies
```sh
$ pip install -r requirements.txt
```

### Configure Database
Update the `DATABASE_URL` in the `app.py` file:
```python
DATABASE_URL = "postgresql://username:password@hostname:port/database"
```

### Run the Application
```sh
$ python app.py
```

The application will run on **http://127.0.0.1:5000/** 🚀

## 📜 API Endpoints

| Endpoint | Method | Description |
|----------|--------|-------------|
| `/user` | GET | List all users |
| `/user/add` | POST | Add a new user |
| `/user/update/<email>` | POST | Update user details |
| `/user/delete/<email>` | POST | Delete a user |
| `/country` | GET | List all countries |
| `/disease` | GET | List all diseases |
| `/doctor` | GET | List all doctors |
| `/patientdisease` | GET | List all patient-disease records |

## 🎨 Screenshots

🚧 *Screenshots will be added soon.*

## 🤝 Contributing
We welcome contributions! Feel free to open issues and submit pull requests. 🚀

## 📜 License
This project is licensed under the **MIT License**. See `LICENSE` for details.

---

💡 *Made with ❤️ using Flask & PostgreSQL*

