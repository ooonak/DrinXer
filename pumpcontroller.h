#ifndef PUMPCONTROLLER_H
#define PUMPCONTROLLER_H

#include <QObject>
#include <QString>

class QElapsedTimer;

#define NO_OF_PUMPS 6

class PumpController : public QObject
{
    Q_OBJECT
public:
    explicit PumpController(QObject *parent = nullptr);
    ~PumpController();

public slots:
    // Start pump n
    void startPump(int n);

    // Stop pump n
    void stopPump(int n);

    // Set calibration value for pump n, calculated as ('volume pumped in cl' * 1000000000) / 'measured duration in ms'
    void setCalibrationValue(int n, int val);

    // Dispense volume cl on pump n
    void dispense(int n, int vol);

signals:
    // Pump done
    void done(int n, bool result);

    // Report error
    void error(QString msg);

    // Report duration between start and stop in ms
    void duration(int ms);

private:
    enum PumpStatus
    {
        IDLE = 0,
        BUSY,
        ERROR,
        NO_OF
    };

    PumpStatus status[NO_OF_PUMPS];
    int calibrationValues[NO_OF_PUMPS];

    QElapsedTimer *timer;
};

#endif // PUMPCONTROLLER_H
