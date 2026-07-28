#pragma once
#include <QProcess>
#include <QImage>
#include <QVariant>
#include <QDebug>
#include <qqmlintegration.h>

class FFmpegStreamer : public QObject {
    Q_OBJECT
    QML_ELEMENT
public:
    explicit FFmpegStreamer(QObject *parent = nullptr) : QObject(parent) {
        ffmpeg = new QProcess(this);

        // Configure FFmpeg to read raw RGBA frames from stdin (-) and stream over UDP
        QStringList args = {
            "-y",
            "-f", "rawvideo",
            "-pixel_format", "rgba",
            "-video_size", "450x600", // Must match your offscreen View3D resolution
            "-framerate", "15",       // 15 FPS
            "-i", "-",                // Read from standard input
            "-c:v", "libx264",        // Encode to H.264
            "-preset", "ultrafast",   // Fast encoding for real-time
            "-tune", "zerolatency",   // No buffering
            "-pix_fmt", "yuv420p",
            "-g", "15",
            "-f", "mpegts",           // Transport stream format
            "udp://127.0.0.1:1234"    // Dashboard app address and port
        };

        ffmpeg->start("C:/Users/user/Downloads/ffmpeg-8.0.1-full_p30download.com/ffmpeg-8.0.1-full_build/bin/ffmpeg.exe", args);
        if (!ffmpeg->waitForStarted()) {
            qWarning() << "Failed to start FFmpeg! Is it installed and in PATH?";
        }
    }

    ~FFmpegStreamer() {
        if (ffmpeg->state() == QProcess::Running) {
            ffmpeg->closeWriteChannel();
            ffmpeg->waitForFinished(1000);
        }
    }

    Q_INVOKABLE void pushFrame(const QVariant &imageVariant) {
        QImage img = imageVariant.value<QImage>();
        if (img.isNull()) return;

        // Ensure the format matches what we told FFmpeg (-pixel_format rgba)
        img = img.convertToFormat(QImage::Format_RGBA8888);

        // Push raw pixels to FFmpeg's stdin
        ffmpeg->write(reinterpret_cast<const char*>(img.bits()), img.sizeInBytes());
    }

private:
    QProcess *ffmpeg;
};
