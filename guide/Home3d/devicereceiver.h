#ifndef DEVICERECEIVER_H
#define DEVICERECEIVER_H

#include <QObject>
#include <QQmlEngine>
#include <QWebSocket>
#include <QWebSocketServer>
#include <QJsonDocument>
#include <QJsonObject>
#include <QJsonArray>
#include <QDebug>
#include <QHash>
#include <QTimer>

class DeviceReceiver : public QObject
{
    Q_OBJECT
    QML_ELEMENT
    QML_SINGLETON

    Q_PROPERTY(double totalEnergyUsage READ totalEnergyUsage NOTIFY totalEnergyUsageChanged)
public:
    explicit DeviceReceiver(QObject *parent = nullptr)
        : QObject{parent}
    {
        m_server = new QWebSocketServer("SmartHomeServer", QWebSocketServer::NonSecureMode, this);
        connect(m_server, &QWebSocketServer::newConnection, this, &DeviceReceiver::handleNewConnection);

        if(m_server->listen(QHostAddress::Any, 8080)){
            qInfo() << "SERVER: Listening on port 8080";
        }


        m_energyTimer = new QTimer(this);
        connect(m_energyTimer, &QTimer::timeout, this, &DeviceReceiver::calculateEnergy);
        m_energyTimer->start(1000);
    }

    double totalEnergyUsage() const { return m_totalEnergyUsage; }




    // --- THE MANAGER REGISTRY METHODS ---
    Q_INVOKABLE void registerDevice(QObject* device) {
        if (!device) return;

        // Read the custom property we injected in QML
        QString id = device->property("deviceId").toString();

        if (!id.isEmpty()) {
            m_devices.insert(id, device);
            qInfo() << "Registered device in C++:" << id;
        }

        connect(device, &QObject::destroyed, this, [this, id]() {
            m_devices.remove(id);
            qDebug() << "Auto-unregistered device:" << id;
        });
    }







    void calculateEnergy()
    {
        double currentPowerDrawWatts = 0.0;

        for (QObject* device : m_devices.values()) {
            if (!device) continue;

            bool isConsumingPower = false;

            // 1. Check if it's a light (has "isOn")
            QVariant isOnVar = device->property("isOn");
            if (isOnVar.isValid()) {
                isConsumingPower = isOnVar.toBool();
            }
            // 2. Check if it's a thermostat (has "mode")
            else {
                QVariant modeVar = device->property("mode");
                if (modeVar.isValid()) {
                    isConsumingPower = (modeVar.toString() != "off");
                }
            }

            // If it is turned ON, add its power to the total
            if (isConsumingPower) {
                QVariant powerVar = device->property("powerDraw");
                if (powerVar.isValid()) {
                    currentPowerDrawWatts += powerVar.toDouble();
                }
            }
        }

        if (currentPowerDrawWatts > 0) {
            m_totalEnergyUsage += (currentPowerDrawWatts / 36000.0);
            emit totalEnergyUsageChanged();
        }
    }
















private slots:
    void handleNewConnection(){
        QWebSocket *client = m_server->nextPendingConnection();
        connect(client, &QWebSocket::textMessageReceived, this, &DeviceReceiver::handleNewMessage);
        connect(client, &QWebSocket::disconnected, this, &DeviceReceiver::socketDisconnected);
        m_clients << client;
    }

    void handleNewMessage(const QString &message){
        QJsonDocument doc = QJsonDocument::fromJson(message.toUtf8());
        QJsonObject json = doc.object();

        QString deviceId = json["deviceId"].toString();
        QString action = json["action"].toString();

        if (m_devices.contains(deviceId)) {
            QObject* targetDevice = m_devices.value(deviceId);

            if (action == "toggle") {
                bool currentState = targetDevice->property("isOn").toBool();
                targetDevice->setProperty("isOn", !currentState);
            }
            else if (action == "setState" || action == "setMode") {
                QString newMode = json.contains("state") ? json["state"].toString() : json["mode"].toString();
                targetDevice->setProperty("mode", newMode);
            }
            else if (action == "setTemperature") {
                double newTemp = json["temperature"].toDouble();
                targetDevice->setProperty("temperature", newTemp);
                qInfo() << "Set thermostat" << deviceId << "to temperature:" << newTemp;
            }
            // NEW: Handle the Garage Door Lock
            else if (action == "setLock") {
                QString state = json["state"].toString();
                bool isLocked = (state == "locked"); // Convert string to true/false
                targetDevice->setProperty("isGarageLocked", isLocked);
                qInfo() << "Set Lock" << deviceId << "to:" << isLocked;
            }
        }
    }





    void socketDisconnected(){
        QWebSocket *client = qobject_cast<QWebSocket *>(sender());
        if (client) {
            m_clients.removeAll(client);
            client->deleteLater();
        }
    }

signals:
    void totalEnergyUsageChanged();

private:
    QWebSocketServer *m_server;
    QList<QWebSocket *> m_clients;

    // --- THE DICTIONARY ---
    QHash<QString, QObject*> m_devices;

    QTimer* m_energyTimer;
    double m_totalEnergyUsage = 0.0;
};

#endif // DEVICERECEIVER_H
