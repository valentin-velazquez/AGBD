from flask import Flask, g, request, jsonify
import sqlite3
from werkzeug.security import generate_password_hash, check_password_hash
import mysql.connector
from mysql.connector import Error

app = Flask(__name__)
app.config['DATABASE'] = 'hamburgueseria.db'  # SQLite local

# -------------------------
# Conexión SQLite local
# -------------------------
def get_db():
    if 'db' not in g:
        g.db = sqlite3.connect(app.config['DATABASE'], detect_types=sqlite3.PARSE_DECLTYPES)
        g.db.row_factory = sqlite3.Row
    return g.db

@app.teardown_appcontext
def close_db(e=None):
    db = g.pop('db', None)
    if db is not None:
        db.close()

# -------------------------
# Conexión MySQL remoto
# -------------------------
def get_mysql_connection():
    try:
        connection = mysql.connector.connect(
            host='10.9.120.5',
            user='hamburgueseria',
            password='hambur1234',
            database='hamburgueseria'
        )
        return connection
    except Error as e:
        print(f"Error conectando a MySQL: {e}")
        return None

# -------------------------
# Crear tablas SQLite (si no existen)
# -------------------------
def init_sqlite():
    db = get_db()
    db.execute('''
        CREATE TABLE IF NOT EXISTS usuarios (
            id_usuarios INTEGER PRIMARY KEY AUTOINCREMENT,
            Usuario TEXT NOT NULL,
            Email TEXT UNIQUE NOT NULL,
            Password TEXT NOT NULL
        )
    ''')
    db.execute('''
        CREATE TABLE IF NOT EXISTS Stock (
            id_Stock INTEGER PRIMARY KEY AUTOINCREMENT,
            Producto TEXT NOT NULL,
            Cantidad INTEGER NOT NULL CHECK(Cantidad >= 0)
        )
    ''')
    db.commit()

# -------------------------
# Registro de usuarios
# -------------------------
@app.route('/registro', methods=['POST'])
def registrar_usuario():
    data = request.get_json()
    if not data or 'Usuario' not in data or 'Email' not in data or 'Password' not in data:
        return {'mensaje': 'Faltan datos'}, 400

    nombre = data['Usuario']
    email = data['Email']
    password = generate_password_hash(data['Password'])

    # SQLite
    db = get_db()
    try:
        cursor = db.cursor()
        cursor.execute('INSERT INTO usuarios (Usuario, Email, Password) VALUES (?, ?, ?)',
                       (nombre, email, password))
        db.commit()
        id_local = cursor.lastrowid
    except sqlite3.IntegrityError:
        return {'mensaje': 'El email ya está registrado'}, 400

    # MySQL
    mysql_conn = get_mysql_connection()
    if mysql_conn:
        try:
            cursor_mysql = mysql_conn.cursor()
            cursor_mysql.execute(
                "INSERT INTO usuarios (Usuario, Email, Password) VALUES (%s, %s, %s)",
                (nombre, email, password)
            )
            mysql_conn.commit()
            id_remoto = cursor_mysql.lastrowid
        except Error as e:
            return {"mensaje_local": "Usuario registrado localmente",
                    "error_mysql": str(e)}, 201
        finally:
            mysql_conn.close()

    return {
        "mensaje": "Usuario registrado correctamente",
        "id_local": id_local,
        "id_remoto": id_remoto
    }, 201

# -------------------------
# Login de usuarios
# -------------------------
@app.route('/login', methods=['POST'])
def login():
    data = request.get_json()
    if not data or 'Email' not in data or 'Password' not in data:
        return {'mensaje': 'Faltan datos'}, 400

    email = data['Email']
    password = data['Password']

    db = get_db()
    usuario = db.execute('SELECT * FROM usuarios WHERE Email = ?', (email,)).fetchone()
    if usuario is None or not check_password_hash(usuario['Password'], password):
        return {'mensaje': 'Credenciales inválidas'}, 401

    return {'mensaje': f'Bienvenido {usuario["Usuario"]}'}, 200

# -------------------------
# Stock
# -------------------------
@app.route('/stock', methods=['GET'])
def listar_stock():
    db = get_db()
    resultado = db.execute('SELECT * FROM Stock').fetchall()
    return {'Stock': [dict(row) for row in resultado]}

@app.route('/stock/agregar', methods=['POST'])
def agregar_stock():
    data = request.get_json()
    db = get_db()
    cursor = db.cursor()
    cursor.execute('INSERT INTO Stock (Producto, Cantidad) VALUES (?, ?)',
                   (data['Producto'], data['Cantidad']))
    db.commit()
    id_local = cursor.lastrowid

    # MySQL
    mysql_conn = get_mysql_connection()
    if mysql_conn:
        try:
            cursor_mysql = mysql_conn.cursor()
            cursor_mysql.execute(
                "INSERT INTO Stock (Producto, Cantidad) VALUES (%s, %s)",
                (data['Producto'], data['Cantidad'])
            )
            mysql_conn.commit()
            id_remoto = cursor_mysql.lastrowid
        except Error as e:
            return {"mensaje_local": "Stock agregado localmente",
                    "error_mysql": str(e)}, 201
        finally:
            mysql_conn.close()

    return {"mensaje": "Stock agregado correctamente",
            "id_local": id_local,
            "id_remoto": id_remoto}, 201

@app.route('/stock/<int:stock_id>', methods=['PUT'])
def modificar_stock(stock_id):
    data = request.get_json()
    if not data or 'Cantidad' not in data:
        return {'mensaje': 'Falta el campo Cantidad'}, 400

    db = get_db()
    cursor = db.execute('UPDATE Stock SET Cantidad = ? WHERE id_Stock = ?',
                        (data['Cantidad'], stock_id))
    db.commit()
    if cursor.rowcount == 0:
        return {'mensaje': 'No se encontró el registro'}, 404

    return {'mensaje': f'Stock con ID {stock_id} actualizado correctamente'}

@app.route('/stock/<int:stock_id>', methods=['DELETE'])
def eliminar_stock(stock_id):
    db = get_db()
    cursor = db.execute('DELETE FROM Stock WHERE id_Stock = ?', (stock_id,))
    db.commit()
    if cursor.rowcount == 0:
        return {'mensaje': 'No se encontró el registro'}, 404
    return {'mensaje': f'Stock con ID {stock_id} eliminado correctamente'}

# -------------------------
# Ejecutar app
# -------------------------
if __name__ == '__main__':
    init_sqlite()  # Crear tablas SQLite si no existen
    app.run(debug=True)
