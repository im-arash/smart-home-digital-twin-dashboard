#ifndef DEVICECONTROLLER_H
#define DEVICECONTROLLER_H

#include <QObject>
#include <QQmlEngine>
#include <QWebSocket>
#include <QJsonDocument>
#include <QJsonObject>
#include <QDebug>

class DeviceController : public QObject
{
    Q_OBJECT
    QML_ELEMENT
public:
    explicit DeviceController(QObject *parent = nullptr)
        : QObject{parent}
    {
        connect(&m_client, &QWebSocket::connected, this, [](){
            qInfo() << "connected";
        });
        m_client.open(QUrl("ws://localhost:8080"));
    }

    Q_INVOKABLE void setThermostatState(const QString &deviceId, const QString &state) {
        if (state != "heat" && state != "cool" && state != "off") {
            qWarning() << "Invalid thermostat state:" << state;
            return;
        }

        QJsonObject json;
        json["deviceId"] = deviceId;
        json["action"] = "setState";
        json["state"] = state; // "heat", "cool", or "off"

        QJsonDocument doc(json);
        m_client.sendTextMessage(QString::fromUtf8(doc.toJson(QJsonDocument::Compact)));
    }

private:
    QWebSocket m_client;
};

#endif // DEVICECONTROLLER_H
