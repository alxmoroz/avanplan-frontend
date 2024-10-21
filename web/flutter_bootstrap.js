{{flutter_js}}
{{flutter_build_config}}

_flutter.loader.load({
  serviceWorkerSettings: {
    serviceWorkerVersion: {{flutter_service_worker_version}},
  },
  onEntrypointLoaded: async function(engineInitializer) {
    // Firebase
    navigator.serviceWorker.register('/firebase-messaging-sw.js');

    const appRunner = await engineInitializer.initializeEngine();

    // Splash
    const splash = document.getElementById("splash");
    if (splash) {
      splash.style.opacity = 0;
      setTimeout(() => {splash.remove();}, 500);
    }

    // Запуск приложения
    await appRunner.runApp();
  }
});
