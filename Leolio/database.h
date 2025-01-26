#ifndef DATABASE_H
#define DATABASE_H

#include <QObject>
#include <QSqlDatabase>
#include <QSqlQuery>
#include <QSqlError>
#include <QDebug>

class Database : public QObject
{
    Q_OBJECT
public:
    explicit Database(QObject *parent = nullptr);
    ~Database();
    bool openDatabase();
    void closeDatabase();
    Q_INVOKABLE bool registerUser(const QString &username, const QString &password);
    Q_INVOKABLE bool userExists(const QString &username);  // Check if user exists
    Q_INVOKABLE bool loginUser(const QString &username, const QString &password);  // Check login credentials

private:
    QSqlDatabase db;
};

#endif // DATABASE_H
