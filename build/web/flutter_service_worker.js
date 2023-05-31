'use strict';
const MANIFEST = 'flutter-app-manifest';
const TEMP = 'flutter-temp-cache';
const CACHE_NAME = 'flutter-app-cache';
const RESOURCES = {
  "version.json": "d02759b0d6b4a4f514a55e38da97314d",
"splash/img/light-2x.png": "722daceadc705fefd3d7a1a2959a62e2",
"splash/img/dark-4x.png": "76c073051c5e7210c673640f8584523d",
"splash/img/light-3x.png": "12e2006ccbec99536729da5c2ac489bb",
"splash/img/dark-3x.png": "b314474baff1b548eec152535dad1dbc",
"splash/img/light-4x.png": "e5a2bbf00d8ce11c67f767eb5a01d0e8",
"splash/img/dark-2x.png": "4fa37b67032e4d1e15cb2efc5ff657c6",
"splash/img/dark-1x.png": "ec1ce2d0b4150feb0d641a21574732d1",
"splash/img/light-1x.png": "94ba8fa14ea681cdb77dfb8cc85f8c02",
"splash/splash.js": "123c400b58bea74c1305ca3ac966748d",
"splash/style.css": "b0640fc6c03fe3a7e6d2f1d2de02349c",
"index.html": "70e3377545afe427b4881d5a85bf8738",
"/": "70e3377545afe427b4881d5a85bf8738",
"main.dart.js": "8d102ab8c8ce361223f5f3ca1ad3ca41",
".well-known/apple-app-site-association": "bda08a6d5ec9db358dab1e697df75298",
".well-known/assetlinks.json": "768c5dec63b05d4c684582be06574c1c",
"flutter.js": "a85fcf6324d3c4d3ae3be1ae4931e9c5",
"favicon.png": "207a237e4a806fb146a5d8cc646a9da6",
"icons/Icon-192.png": "9affe4ff3284edb182db2331e3a5cb1c",
"icons/Icon-512.png": "1b7aba23effbc92dc7c2aad81d5a0648",
"manifest.json": "829e7bc04aaa2122b0cfd79511ffabdd",
"assets/AssetManifest.json": "96d6464802813fef544ae91699d5742c",
"assets/NOTICES": "d94e055bb95143d50edf7f3e83bfc9f1",
"assets/FontManifest.json": "798aa6e3f3995a8650f228d2c148b3d2",
"assets/packages/cupertino_icons/assets/CupertinoIcons.ttf": "6d342eb68f170c97609e9da345464e5e",
"assets/packages/font_awesome_flutter/lib/fonts/fa-solid-900.ttf": "9cda082bd7cc5642096b56fa8db15b45",
"assets/packages/font_awesome_flutter/lib/fonts/fa-regular-400.ttf": "0a94bab8e306520dc6ae14c2573972ad",
"assets/packages/font_awesome_flutter/lib/fonts/fa-brands-400.ttf": "b00363533ebe0bfdb95f3694d7647f6d",
"assets/fonts/MaterialIcons-Regular.otf": "e7069dfd19b331be16bed984668fe080",
"assets/assets/images/google_icon.png": "8620289fcba16d4c5fc70e57ad524906",
"assets/assets/images/gitlab_icon.png": "2d778422344d370c25e7546f7364ea8b",
"assets/assets/images/app_icon.png": "ec95ad44de8ac0b1900ba6c09e6ca418",
"assets/assets/images/redmine_icon.png": "9e0456fdab8bcc72506384d00dde6b85",
"assets/assets/images/apple_icon.png": "6979c65521d2698024cc6ccc55c877a4",
"assets/assets/images/checkers.png": "4b10aa9787841763944e276def907d79",
"assets/assets/images/jira_icon.png": "ace43fd305a1388e29dba1f284a69e95",
"assets/assets/ca/lets-encrypt-r3.pem": "be77e5992c00fcd753d1b9c11d3768f2",
"assets/assets/fonts/Roboto-R.ttf": "c613ca81d36649b260700f3335d8f579",
"assets/assets/fonts/Roboto-T.ttf": "7faf23e11b3c2da59062fffc117e3a40",
"assets/assets/fonts/Roboto-M.ttf": "38aa81d461c299fa9f0cb27726401996",
"assets/assets/fonts/Roboto-L.ttf": "63d6f579b0db1fc75cc977a0539ce45f",
"canvaskit/canvaskit.js": "97937cb4c2c2073c968525a3e08c86a3",
"canvaskit/profiling/canvaskit.js": "c21852696bc1cc82e8894d851c01921a",
"canvaskit/profiling/canvaskit.wasm": "371bc4e204443b0d5e774d64a046eb99",
"canvaskit/canvaskit.wasm": "3de12d898ec208a5f31362cc00f09b9e"
};

// The application shell files that are downloaded before a service worker can
// start.
const CORE = [
  "main.dart.js",
"index.html",
"assets/AssetManifest.json",
"assets/FontManifest.json"];
// During install, the TEMP cache is populated with the application shell files.
self.addEventListener("install", (event) => {
  self.skipWaiting();
  return event.waitUntil(
    caches.open(TEMP).then((cache) => {
      return cache.addAll(
        CORE.map((value) => new Request(value, {'cache': 'reload'})));
    })
  );
});

// During activate, the cache is populated with the temp files downloaded in
// install. If this service worker is upgrading from one with a saved
// MANIFEST, then use this to retain unchanged resource files.
self.addEventListener("activate", function(event) {
  return event.waitUntil(async function() {
    try {
      var contentCache = await caches.open(CACHE_NAME);
      var tempCache = await caches.open(TEMP);
      var manifestCache = await caches.open(MANIFEST);
      var manifest = await manifestCache.match('manifest');
      // When there is no prior manifest, clear the entire cache.
      if (!manifest) {
        await caches.delete(CACHE_NAME);
        contentCache = await caches.open(CACHE_NAME);
        for (var request of await tempCache.keys()) {
          var response = await tempCache.match(request);
          await contentCache.put(request, response);
        }
        await caches.delete(TEMP);
        // Save the manifest to make future upgrades efficient.
        await manifestCache.put('manifest', new Response(JSON.stringify(RESOURCES)));
        return;
      }
      var oldManifest = await manifest.json();
      var origin = self.location.origin;
      for (var request of await contentCache.keys()) {
        var key = request.url.substring(origin.length + 1);
        if (key == "") {
          key = "/";
        }
        // If a resource from the old manifest is not in the new cache, or if
        // the MD5 sum has changed, delete it. Otherwise the resource is left
        // in the cache and can be reused by the new service worker.
        if (!RESOURCES[key] || RESOURCES[key] != oldManifest[key]) {
          await contentCache.delete(request);
        }
      }
      // Populate the cache with the app shell TEMP files, potentially overwriting
      // cache files preserved above.
      for (var request of await tempCache.keys()) {
        var response = await tempCache.match(request);
        await contentCache.put(request, response);
      }
      await caches.delete(TEMP);
      // Save the manifest to make future upgrades efficient.
      await manifestCache.put('manifest', new Response(JSON.stringify(RESOURCES)));
      return;
    } catch (err) {
      // On an unhandled exception the state of the cache cannot be guaranteed.
      console.error('Failed to upgrade service worker: ' + err);
      await caches.delete(CACHE_NAME);
      await caches.delete(TEMP);
      await caches.delete(MANIFEST);
    }
  }());
});

// The fetch handler redirects requests for RESOURCE files to the service
// worker cache.
self.addEventListener("fetch", (event) => {
  if (event.request.method !== 'GET') {
    return;
  }
  var origin = self.location.origin;
  var key = event.request.url.substring(origin.length + 1);
  // Redirect URLs to the index.html
  if (key.indexOf('?v=') != -1) {
    key = key.split('?v=')[0];
  }
  if (event.request.url == origin || event.request.url.startsWith(origin + '/#') || key == '') {
    key = '/';
  }
  // If the URL is not the RESOURCE list then return to signal that the
  // browser should take over.
  if (!RESOURCES[key]) {
    return;
  }
  // If the URL is the index.html, perform an online-first request.
  if (key == '/') {
    return onlineFirst(event);
  }
  event.respondWith(caches.open(CACHE_NAME)
    .then((cache) =>  {
      return cache.match(event.request).then((response) => {
        // Either respond with the cached resource, or perform a fetch and
        // lazily populate the cache only if the resource was successfully fetched.
        return response || fetch(event.request).then((response) => {
          if (response && Boolean(response.ok)) {
            cache.put(event.request, response.clone());
          }
          return response;
        });
      })
    })
  );
});

self.addEventListener('message', (event) => {
  // SkipWaiting can be used to immediately activate a waiting service worker.
  // This will also require a page refresh triggered by the main worker.
  if (event.data === 'skipWaiting') {
    self.skipWaiting();
    return;
  }
  if (event.data === 'downloadOffline') {
    downloadOffline();
    return;
  }
});

// Download offline will check the RESOURCES for all files not in the cache
// and populate them.
async function downloadOffline() {
  var resources = [];
  var contentCache = await caches.open(CACHE_NAME);
  var currentContent = {};
  for (var request of await contentCache.keys()) {
    var key = request.url.substring(origin.length + 1);
    if (key == "") {
      key = "/";
    }
    currentContent[key] = true;
  }
  for (var resourceKey of Object.keys(RESOURCES)) {
    if (!currentContent[resourceKey]) {
      resources.push(resourceKey);
    }
  }
  return contentCache.addAll(resources);
}

// Attempt to download the resource online before falling back to
// the offline cache.
function onlineFirst(event) {
  return event.respondWith(
    fetch(event.request).then((response) => {
      return caches.open(CACHE_NAME).then((cache) => {
        cache.put(event.request, response.clone());
        return response;
      });
    }).catch((error) => {
      return caches.open(CACHE_NAME).then((cache) => {
        return cache.match(event.request).then((response) => {
          if (response != null) {
            return response;
          }
          throw error;
        });
      });
    })
  );
}
