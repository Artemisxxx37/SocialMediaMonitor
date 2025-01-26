#include "database.h"

Database::Database(QObject *parent) : QObject(parent)
{
}

Database::~Database()
{
    closeDatabase();
}

bool Database::openDatabase()
{
    db = QSqlDatabase::addDatabase("QSQLITE");
    db.setDatabaseName("users.db");

    if (!db.open()) {
        qDebug() << "Error: connection with database failed";
        return false;
    } else {
        qDebug() << "Database: connection ok";
        QSqlQuery query;
        query.exec("CREATE TABLE IF NOT EXISTS users (id INTEGER PRIMARY KEY AUTOINCREMENT, username TEXT NOT NULL, password TEXT NOT NULL)");
        qDebug() << "Database created at:" << db.databaseName();
        return true;
    }
}

void Database::closeDatabase()
{
    db.close();
}

bool Database::registerUser(const QString &username, const QString &password)
{
    if (username.isEmpty() || password.isEmpty()) {
        return false;
    }

    if (userExists(username)) {
        qDebug() << "Error: username already exists";
        return false;
    }

    QSqlQuery query;
    query.prepare("INSERT INTO users (username, password) VALUES (:username, :password)");
    query.bindValue(":username", username);
    query.bindValue(":password", password);

    if (!query.exec()) {
        qDebug() << "Error: failed to register user" << query.lastError();
        return false;
    }

    return true;
}

bool Database::userExists(const QString &username)
{
    QSqlQuery query;
    query.prepare("SELECT COUNT(*) FROM users WHERE username = :username");
    query.bindValue(":username", username);

    if (query.exec()) {
        if (query.next() && query.value(0).toInt() > 0) {
            return true;
        }
    } else {
        qDebug() << "Error: failed to check if user exists" << query.lastError();
    }

    return false;
}

bool Database::loginUser(const QString &username, const QString &password)
{
    QSqlQuery query;
    query.prepare("SELECT COUNT(*) FROM users WHERE username = :username AND password = :password");
    query.bindValue(":username", username);
    query.bindValue(":password", password);

    if (query.exec()) {
        if (query.next() && query.value(0).toInt() > 0) {
            return true;
        }
    } else {
        qDebug() << "Error: failed to check login credentials" << query.lastError();
    }

    return false;
}
