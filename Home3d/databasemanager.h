#ifndef DATABASEMANAGER_H
#define DATABASEMANAGER_H

#include <QObject>
#include <QSqlDatabase>
#include <QSqlQuery>
#include <QSqlError>
#include <QDateTime>
#include <QJsonArray>
#include <QDebug>

class DatabaseManager : public QObject {
    Q_OBJECT
public:
    explicit DatabaseManager(QObject *parent = nullptr) : QObject(parent) {
        setupDatabase();
    }

    void saveMetrics(double temp, double power) {
        QSqlQuery query;
        query.prepare("INSERT INTO metrics (timestamp, temperature, power) VALUES (:time, :temp, :power)");
        query.bindValue(":time", QDateTime::currentSecsSinceEpoch());
        query.bindValue(":temp", temp);
        query.bindValue(":power", power);

        if (!query.exec()) {
            qDebug() << "DB ERROR: Failed to write to DB:" << query.lastError().text();
        }
    }

    QJsonArray getLatestChartData(int limit = 20) {
        QSqlQuery query;
        query.prepare("SELECT power FROM metrics ORDER BY timestamp DESC LIMIT :limit");
        query.bindValue(":limit", limit);
        query.exec();

        QList<double> history;
        while (query.next()) {
            history.prepend(query.value(0).toDouble()); // Prepend to reverse the order (oldest to newest)
        }

        QJsonArray dataArray;
        for (double val : history) {
            dataArray.append(val);
        }
        return dataArray;
    }

private:
    void setupDatabase() {
        QSqlDatabase db = QSqlDatabase::addDatabase("QSQLITE");
        db.setDatabaseName("smarthome.db");

        if (!db.open()) {
            qDebug() << "DB ERROR: Cannot open database:" << db.lastError().text();
            return;
        }

        QSqlQuery query;
        query.exec("CREATE TABLE IF NOT EXISTS metrics ("
                   "id INTEGER PRIMARY KEY AUTOINCREMENT, "
                   "timestamp INTEGER, "
                   "temperature REAL, "
                   "power REAL)");
        qDebug() << "DB: Database ready.";
    }
};

#endif // DATABASEMANAGER_H
