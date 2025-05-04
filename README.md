# Projects: Clinic Booking System & Contact Book API

---

## 📘 Project 1: Clinic Booking System (MySQL Database)

### 🎯 Objective

In this project I design and implement a full-featured relational database for **Clinic Booking System** using only **MySQL**. The database is well structured and contain tables with proper constraints (pk, fk, not null, unique). Relationships (1-1, 1-M, M-M) were also implemented.

### 🩺 Description

This project simulates a real-world clinic scenario with tables for doctors, patients, appointments, and specializations. It demonstrates relational database modeling with proper constraints and normalization.

### 📐 Features

- Proper use of constraints: `PRIMARY KEY`, `FOREIGN KEY`, `NOT NULL`, `UNIQUE`
- Support for 1-to-Many and Many-to-Many relationships
- Sample data included for testing

### 🗂️ Database Schema

- `patients`: Stores patient information
- `doctors`: Stores doctor details
- `specializations`: Lists various medical specialties
- `appointments`: Records patient bookings with doctors
- `doctor_specializations`: Many-to-many relation between doctors and their specialties

### 📎 Files Included

- `clinic_booking_system.sql`  
  Contains:
  - All `CREATE TABLE` statements
  - `INSERT INTO` statements with sample data
  - `SAMPLE QUERIES` to test the database

---

## 🔧 Project 2: Contact Book API (FastAPI + MySQL)

### 🎯 Objective

This project is a working CRUD API created using Python and MYSQL. I design the database schema in MySQL and build the API using: FastAPI. I implement all CRUD operations (Create, Read, Update, Delete). And Connected the API to the MySQL database.

Build a **CRUD API** using **FastAPI** that connects to a **MySQL** database to manage contact records.

### 🗒️ Description

This project allows users to manage a contact book through a RESTful API. It supports full CRUD operations, built using Python's FastAPI and SQLAlchemy ORM for database interaction.

### 🧱 Tech Stack

- **Backend**: FastAPI (Python)
- **Database**: MySQL
- **ORM**: SQLAlchemy
- **Environment**: Python 3.9+, MySQL Server

### 📐 Features

- Create, Read, Update, Delete contacts
- Grouping of contacts (optional)
- Search contacts (by name, email)

### 🗂️ Database Schema

- `contacts`: Stores basic contact info
- `groups`: Defines groups like "Friends", "Work", etc.
- `contact_group`: Many-to-many table to link contacts with groups

---

## 🚀 Setup & Run Instructions

#### 1. Clone Repo & Install Dependencies

```bash
python -m venv venv
venv\Scripts\activate      # On Windows
pip install -r requirements.txt
```

2. Create .env File with DB Credentials

```ini
DB_HOST=localhost
DB_PORT=3306
DB_USER=root
DB_PASSWORD=yourpassword
DB_NAME=contact_book
```

3. Start the FastAPI Server

```bash
uvicorn main:app --reload
```

4. Test API
   Visit http://localhost:8000/docs for the Swagger UI
   Use Postman to test each endpoint.

## Files Included in Project 2

- main.py: FastAPI routes

- models.py: SQLAlchemy models

- database.py: DB session and connection

- schemas.py: Pydantic models

- .env: Environment variables

- README.md: Documentation

## Summary

### PROJECT 1:

Title: Clinical Booking System Database

DESCRIPTION: A Database design for a clinical booking. That allow patients to book clinical appointed with Doctors.

TECHNOLOGY: MYSQL

### PROJECT 2:

Title: Contact Book API

DESCRIPTION: CRUD REST API connected to MySQL

TECHNOLOGY: FastAPI (Python) + MySQL

## ✍️ Author

Richard Akintunde

akintunderichard28@gmail.com
