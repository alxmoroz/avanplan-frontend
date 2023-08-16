'use strict';
const MANIFEST = 'flutter-app-manifest';
const TEMP = 'flutter-temp-cache';
const CACHE_NAME = 'flutter-app-cache';

const RESOURCES = {"version.json": "3750090c823d3af20761e4762b3c4845",
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
"index.html": "af25466ef060e7e7b3735b69b717acf9",
"/": "af25466ef060e7e7b3735b69b717acf9",
"main.dart.js": "531e360a917e10b134e8b15f5fb0fd51",
".well-known/apple-app-site-association": "bda08a6d5ec9db358dab1e697df75298",
".well-known/assetlinks.json": "768c5dec63b05d4c684582be06574c1c",
"flutter.js": "6fef97aeca90b426343ba6c5c9dc5d4a",
"favicon.png": "207a237e4a806fb146a5d8cc646a9da6",
"icons/Icon-192.png": "9affe4ff3284edb182db2331e3a5cb1c",
"icons/Icon-512.png": "1b7aba23effbc92dc7c2aad81d5a0648",
"manifest.json": "829e7bc04aaa2122b0cfd79511ffabdd",
"assets/AssetManifest.json": "6d5b9327b54da37c59b8c4c8f423d5af",
"assets/NOTICES": "ae51f01884ecd07bd8a4c4a3c05753b4",
"assets/FontManifest.json": "798aa6e3f3995a8650f228d2c148b3d2",
"assets/packages/cupertino_icons/assets/CupertinoIcons.ttf": "aaa230dfbe489974743a6d7bff2ab420",
"assets/packages/font_awesome_flutter/lib/fonts/fa-solid-900.ttf": "658b490c9da97710b01bd0f8825fce94",
"assets/packages/font_awesome_flutter/lib/fonts/fa-regular-400.ttf": "5070443340d1d8cceb516d02c3d6dee7",
"assets/packages/font_awesome_flutter/lib/fonts/fa-brands-400.ttf": "d7791ef376c159f302b8ad90a748d2ab",
"assets/shaders/ink_sparkle.frag": "f8b80e740d33eb157090be4e995febdf",
"assets/AssetManifest.bin": "b5b4a671c59ee7349ac2ef63c89f7908",
"assets/fonts/MaterialIcons-Regular.otf": "62ec8220af1fb03e1c20cfa38781e17e",
"assets/assets/images/purchase_dark.png": "957c52f98845c3c90e12bc0281f2e22f",
"assets/assets/images/loading_dark.png": "dc174314d3e5f68efee2b8def8ff1f44",
"assets/assets/images/ok.png": "5696d1adb01e987630191c6b54b0b1eb",
"assets/assets/images/import.png": "62f8984c2a8327d0fdae0f2cf7c8f421",
"assets/assets/images/empty_team.png": "fdf65329c4b23fbbc5bd8ee1796a4206",
"assets/assets/images/network_error.png": "b18259c560a7b7f2330f10ffb71c5454",
"assets/assets/images/purchase.png": "db5c359e0ccef1fc164c4404179bdbb6",
"assets/assets/images/overdue_dark.png": "d86de4e1c8d751071b583d9f029db201",
"assets/assets/images/no_info_dark.png": "aea8b7dd0dd9ce00e5a8f89250ae19d7",
"assets/assets/images/no_info.png": "9214746a7c4ad3b9f79cf991bd23c03d",
"assets/assets/images/privacy_dark.png": "45305663bc68dec0cf113be95e20dfad",
"assets/assets/images/import_dark.png": "b91dab5e98271305b1329246fbbda3e9",
"assets/assets/images/network_error_dark.png": "6889b3a0901b5afd4923f855f69ebfbb",
"assets/assets/images/risk_dark.png": "195debb369a856b60ed144bf9e6e6bbd",
"assets/assets/images/delete_dark.png": "652a8157b48658264d236f96c4b97096",
"assets/assets/images/sync_dark.png": "e3c5061001bc2c8c7f23f0d81b53ddf1",
"assets/assets/images/empty_team_dark.png": "313ad143e116deccb9a999ffd4109c0a",
"assets/assets/images/transfer.png": "8b18381c6ab912782f78eb242613cecf",
"assets/assets/images/empty_tasks.png": "fa2280ade4aa20b6f68d020dff539c82",
"assets/assets/images/privacy.png": "75ef1f58fd2f8d149f6ae42308290d04",
"assets/assets/images/transfer_dark.png": "6a48fe62217e80e7c547ac6d394b037d",
"assets/assets/images/empty_sources_dark.png": "25900005fd71f57b8f8d98253d3c87b1",
"assets/assets/images/sync.png": "33b6e285702d9f632a97b2f69d140f3b",
"assets/assets/images/delete.png": "30f59b1920d184642aaf59eb7ab13c8b",
"assets/assets/images/empty_tasks_dark.png": "17e3975fc400cf26081b9eb8e8419497",
"assets/assets/images/server_error.png": "dfe0fa76eba47710cb89eb9de2e5694b",
"assets/assets/images/save_dark.png": "d9358192d64f8d96a1aa7caeaa046f0e",
"assets/assets/images/risk.png": "241fa51625615ef868d1129d8aef5699",
"assets/assets/images/empty_sources.png": "fe0534ee9f638f2151a705dcfb858b5d",
"assets/assets/images/start_dark.png": "90705bb6cc3c5ee3d2f753da80d4cb35",
"assets/assets/images/overdue.png": "d64a3aea7f3548c09f63391568a21c96",
"assets/assets/images/loading.png": "8e91b9339ee204f8e26df8e5b10a2dba",
"assets/assets/images/save.png": "ac8084ab07a84140f9816ac30dc4d839",
"assets/assets/images/start.png": "adfc519fda5f449c88992b989d0d787b",
"assets/assets/images/ok_dark.png": "b3307a5b0600387e365d479593ea893d",
"assets/assets/images/server_error_dark.png": "de6851464c57fdda43e1d7a1218cf70d",
"assets/assets/ca/lets-encrypt-r3.pem": "be77e5992c00fcd753d1b9c11d3768f2",
"assets/assets/icons/google_icon.png": "8620289fcba16d4c5fc70e57ad524906",
"assets/assets/icons/gitlab_icon.png": "2d778422344d370c25e7546f7364ea8b",
"assets/assets/icons/app_icon.png": "ec95ad44de8ac0b1900ba6c09e6ca418",
"assets/assets/icons/redmine_icon.png": "9e0456fdab8bcc72506384d00dde6b85",
"assets/assets/icons/apple_icon.png": "6979c65521d2698024cc6ccc55c877a4",
"assets/assets/icons/trello_icon.png": "a03bc775e9b4954271dd1f0ae7a16967",
"assets/assets/icons/checkers.png": "4b10aa9787841763944e276def907d79",
"assets/assets/icons/jira_icon.png": "ace43fd305a1388e29dba1f284a69e95",
"assets/assets/fonts/Roboto-R.ttf": "c613ca81d36649b260700f3335d8f579",
"assets/assets/fonts/Roboto-T.ttf": "7faf23e11b3c2da59062fffc117e3a40",
"assets/assets/fonts/Roboto-M.ttf": "38aa81d461c299fa9f0cb27726401996",
"assets/assets/fonts/Roboto-L.ttf": "63d6f579b0db1fc75cc977a0539ce45f",
"canvaskit/skwasm.js": "1df4d741f441fa1a4d10530ced463ef8",
"canvaskit/skwasm.wasm": "6711032e17bf49924b2b001cef0d3ea3",
"canvaskit/chromium/canvaskit.js": "8c8392ce4a4364cbb240aa09b5652e05",
"canvaskit/chromium/canvaskit.wasm": "fc18c3010856029414b70cae1afc5cd9",
"canvaskit/canvaskit.js": "76f7d822f42397160c5dfc69cbc9b2de",
"canvaskit/canvaskit.wasm": "f48eaf57cada79163ec6dec7929486ea",
"canvaskit/skwasm.worker.js": "19659053a277272607529ef87acf9d8a"};
// The application shell files that are downloaded before a service worker can
// start.
const CORE = ["main.dart.js",
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
        // Claim client to enable caching on first launch
        self.clients.claim();
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
      // Claim client to enable caching on first launch
      self.clients.claim();
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
