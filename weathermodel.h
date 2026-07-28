#ifndef WEATHERMODEL_H
#define WEATHERMODEL_H

#include <QObject>
#include <QQmlEngine>
#include <QAbstractListModel>
#include <QDate>
#include <vector>

struct Weather{
    QDate date;
    int HTemperature;
    int LTemperature;
};

class WeatherModel : public QAbstractListModel
{
    Q_OBJECT
    QML_ELEMENT

    Q_PROPERTY(int currentTemperature READ currentTemperature CONSTANT)
    Q_PROPERTY(int currentLowTemperature READ currentLowTemperature CONSTANT)
    Q_PROPERTY(QString currentDay READ currentDay CONSTANT)

public:

    enum Roles{
        DateRole = Qt::UserRole + 1,
        HTemperatureRole,
        LTemperatureRole
    };

    explicit WeatherModel(QObject *parent = nullptr)
        : QAbstractListModel{parent}
    {
        QDate start = QDate::currentDate();

        for (int i = 0; i < 7; ++i) {
            m_data.push_back({
                start.addDays(i),
                25 + (i % 5),
                10 + (i % 4)
            });
        }
    }

    int rowCount(const QModelIndex &parent) const override{
        if(parent.isValid())
            return 0;
        return static_cast<int>(m_data.size());
    }

    QVariant data(const QModelIndex &index, int role) const override{
        if(!index.isValid() || index.row() >= m_data.size())
            return QVariant();

        const Weather &w = m_data[index.row()];

        switch(role){
        case DateRole:
            return w.date;
        case HTemperatureRole:
            return w.HTemperature;
        case LTemperatureRole:
            return w.LTemperature;
        default:
            return QVariant();
        }
    }

    QHash<int, QByteArray> roleNames() const override{
        QHash<int, QByteArray> roles;
        roles[DateRole] = "date";
        roles[HTemperatureRole] = "highTemperature";
        roles[LTemperatureRole] = "lowTemperature";
        return roles;
    }

    int currentTemperature() const
    {
        if (m_data.empty())
            return 0;
        return m_data.back().HTemperature; // LAST day (rightmost in your chart)
    }

    int currentLowTemperature() const
    {
        if (m_data.empty())
            return 0;
        return m_data.back().LTemperature;
    }

    QString currentDay() const
    {
        if (m_data.empty())
            return QString();
        return m_data.back().date.toString("dddd, MMMM d yyyy");
    }

signals:

private:
    std::vector<Weather> m_data;
};

#endif // WEATHERMODEL_H
