// #include <QGuiApplication>
// #include <QQmlApplicationEngine>

// int main(int argc, char *argv[])
// {
//     // Force background texture/mesh preparation
//     qputenv("QSG_RENDER_LOOP", "threaded");
//     QGuiApplication app(argc, argv);

//     QQmlApplicationEngine engine;
//     QObject::connect(
//         &engine,
//         &QQmlApplicationEngine::objectCreationFailed,
//         &app,
//         []() { QCoreApplication::exit(-1); },
//         Qt::QueuedConnection);
//     engine.loadFromModule("Home3d", "Main");

//     return app.exec();
// }



#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QQmlAbstractUrlInterceptor>
#include <QCoreApplication>
#include <QUrl>
#include <QDir>

// Create a custom URL interceptor
class AssetUrlInterceptor : public QQmlAbstractUrlInterceptor {
public:
    QUrl intercept(const QUrl &path, DataType type) override {
        QString urlString = path.toString();

        // If the runtime tries to load a mesh or map from the resource system
        if (urlString.startsWith("qrc:/") && (urlString.endsWith(".mesh") || urlString.endsWith(".png") || urlString.endsWith(".jpg"))) {

            // Extract everything after the module name (e.g., "exterior/meshes/...")
            // You may need to adjust the split string based on your exact QRC structure
            QString relativeAssetPath = urlString.split("Home3d/").last();

            // Point it directly to the physical files copied by CMake in the build folder
            QString physicalPath = QCoreApplication::applicationDirPath() + "/" + relativeAssetPath;

            return QUrl::fromLocalFile(physicalPath);
        }

        return path;
    }
};

int main(int argc, char *argv[])
{
    QGuiApplication app(argc, argv);
    QQmlApplicationEngine engine;

    // Attach the interceptor BEFORE loading the QML
    AssetUrlInterceptor *interceptor = new AssetUrlInterceptor();
    engine.addUrlInterceptor(interceptor);

    // Standard Qt 6 module loading
    QObject::connect(&engine, &QQmlApplicationEngine::objectCreationFailed,
                     &app, []() { QCoreApplication::exit(-1); },
                     Qt::QueuedConnection);

    engine.loadFromModule("Home3d", "Main");

    return app.exec();
}
