'use strict';
const MANIFEST = 'flutter-app-manifest';
const TEMP = 'flutter-temp-cache';
const CACHE_NAME = 'flutter-app-cache';

const RESOURCES = {"version.json": "fb68a9bb8aded999171bc8a29a297a11",
"splash/img/light-2x.png": "de04581de96618c7774eb07917cbb0b5",
"splash/img/dark-4x.png": "d23a48799930e68b79537f9521b54392",
"splash/img/light-3x.png": "0bd86804e97e7c72cff21b1d4bc703ca",
"splash/img/dark-3x.png": "561458e82ed400f83d45d88f79a97598",
"splash/img/light-4x.png": "24b77b0b48cc08787dfa78d8a9b02545",
"splash/img/dark-2x.png": "1de000216e9b5b35639dc772bdb23a54",
"splash/img/dark-1x.png": "efade7303c0cbca00b2a44781e1f4732",
"splash/img/light-1x.png": "de41a29d2394649c3b563d87703d1dcb",
"index.html": "7f585932f293d6d9149e36b7d6622b42",
"/": "7f585932f293d6d9149e36b7d6622b42",
"main.dart.js": "199352b684a671ffaeb9149796415b9c",
".well-known/apple-app-site-association": "bda08a6d5ec9db358dab1e697df75298",
".well-known/assetlinks.json": "768c5dec63b05d4c684582be06574c1c",
"flutter.js": "6fef97aeca90b426343ba6c5c9dc5d4a",
"favicon.png": "313dc90bf1247b190625b5b881dd643e",
"icons/Icon-192.png": "6cabb58d3cda86b51390dca667b72191",
"icons/Icon-maskable-192.png": "ad3727398a480a7dab288bbdb8816c1d",
"icons/Icon-maskable-512.png": "c630886abedfca5e743cd6ecb1d8d9a6",
"icons/Icon-512.png": "76e510d767ca450ea6b0db715e72c4bb",
"manifest.json": "93e150baf71aefcc9993dea1e4ab903b",
"assets/AssetManifest.json": "460eb7299618a013f1f790cf4628ab7e",
"assets/NOTICES": "e96a8c501b35f7061ca8e02de07caeac",
"assets/FontManifest.json": "715402cc5b4eb84b0a01e50c28d8537a",
"assets/packages/cupertino_icons/assets/CupertinoIcons.ttf": "582c5fbc0421bb8a55cf9b3a33f6be41",
"assets/shaders/ink_sparkle.frag": "f8b80e740d33eb157090be4e995febdf",
"assets/AssetManifest.bin": "8229c219d562d1960d27638f717a6e7c",
"assets/fonts/MaterialIcons-Regular.otf": "2434447c259eaeba56709378ccee65e3",
"assets/assets/images/purchase_dark.png": "957c52f98845c3c90e12bc0281f2e22f",
"assets/assets/images/fs_task_list.png": "d8c43cce1d306aa8fedc3a805746fe77",
"assets/assets/images/hello_dark.png": "9a48316913b2004cdd863339c9e1faab",
"assets/assets/images/app_title_en.png": "779e19c9515fd7a931a4f14fef6ef17b",
"assets/assets/images/loading_dark.png": "dc174314d3e5f68efee2b8def8ff1f44",
"assets/assets/images/ok.png": "5696d1adb01e987630191c6b54b0b1eb",
"assets/assets/images/import.png": "62f8984c2a8327d0fdae0f2cf7c8f421",
"assets/assets/images/empty_team.png": "fdf65329c4b23fbbc5bd8ee1796a4206",
"assets/assets/images/app_title_ru.png": "4f73de34cdc32cf2c3a8fe0f76f0d89d",
"assets/assets/images/fs_task_list_dark.png": "207eb439cac26643a9a677d758442f6a",
"assets/assets/images/network_error.png": "b18259c560a7b7f2330f10ffb71c5454",
"assets/assets/images/purchase.png": "db5c359e0ccef1fc164c4404179bdbb6",
"assets/assets/images/fs_team.png": "edef67b92a1cd3eccfbe3592189157f3",
"assets/assets/images/overdue_dark.png": "d86de4e1c8d751071b583d9f029db201",
"assets/assets/images/no_info_dark.png": "aea8b7dd0dd9ce00e5a8f89250ae19d7",
"assets/assets/images/no_info.png": "9214746a7c4ad3b9f79cf991bd23c03d",
"assets/assets/images/fs_goals.png": "6d46fe523eaa8e977e44adcecef4a01f",
"assets/assets/images/fs_task_board.png": "9c6e9a24b0e366cffba22157d2eb7f79",
"assets/assets/images/privacy_dark.png": "45305663bc68dec0cf113be95e20dfad",
"assets/assets/images/import_dark.png": "b91dab5e98271305b1329246fbbda3e9",
"assets/assets/images/network_error_dark.png": "6889b3a0901b5afd4923f855f69ebfbb",
"assets/assets/images/fs_analytics_dark.png": "8b431746a26c37e87c138b349c6ee976",
"assets/assets/images/risk_dark.png": "195debb369a856b60ed144bf9e6e6bbd",
"assets/assets/images/delete_dark.png": "652a8157b48658264d236f96c4b97096",
"assets/assets/images/sync_dark.png": "e3c5061001bc2c8c7f23f0d81b53ddf1",
"assets/assets/images/empty_team_dark.png": "313ad143e116deccb9a999ffd4109c0a",
"assets/assets/images/transfer.png": "8b18381c6ab912782f78eb242613cecf",
"assets/assets/images/empty_tasks.png": "fa2280ade4aa20b6f68d020dff539c82",
"assets/assets/images/privacy.png": "75ef1f58fd2f8d149f6ae42308290d04",
"assets/assets/images/app_title_en_dark.png": "02a5157194210d801aa00144e13367e2",
"assets/assets/images/fs_estimates.png": "aefb374996c4dd3313ecd2e0c6c181e1",
"assets/assets/images/transfer_dark.png": "6a48fe62217e80e7c547ac6d394b037d",
"assets/assets/images/hello.png": "677c1043536e26454299c7e603acabf3",
"assets/assets/images/fs_estimates_dark.png": "12b55b27e19adacff8af92f22c0b0d80",
"assets/assets/images/empty_sources_dark.png": "25900005fd71f57b8f8d98253d3c87b1",
"assets/assets/images/sync.png": "33b6e285702d9f632a97b2f69d140f3b",
"assets/assets/images/delete.png": "30f59b1920d184642aaf59eb7ab13c8b",
"assets/assets/images/empty_tasks_dark.png": "17e3975fc400cf26081b9eb8e8419497",
"assets/assets/images/fs_team_dark.png": "48c742fe1e16cf9222e36127d5eadfd9",
"assets/assets/images/fs_task_board_dark.png": "c1acb54284a096fe68ea3afb57fc8bf1",
"assets/assets/images/server_error.png": "dfe0fa76eba47710cb89eb9de2e5694b",
"assets/assets/images/save_dark.png": "d9358192d64f8d96a1aa7caeaa046f0e",
"assets/assets/images/app_title_ru_dark.png": "3f72d1bb3a66281d120b429b03ea575b",
"assets/assets/images/risk.png": "241fa51625615ef868d1129d8aef5699",
"assets/assets/images/empty_sources.png": "fe0534ee9f638f2151a705dcfb858b5d",
"assets/assets/images/fs_analytics.png": "f0e87c357cfc80c5124125821a179d20",
"assets/assets/images/start_dark.png": "90705bb6cc3c5ee3d2f753da80d4cb35",
"assets/assets/images/overdue.png": "d64a3aea7f3548c09f63391568a21c96",
"assets/assets/images/loading.png": "8e91b9339ee204f8e26df8e5b10a2dba",
"assets/assets/images/fs_goals_dark.png": "e03b058f95efc941055c65884991269d",
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
"assets/assets/fonts/Montserrat-M.ttf": "b3ba703c591edd4aad57f8f4561a287b",
"assets/assets/fonts/Roboto-M.ttf": "38aa81d461c299fa9f0cb27726401996",
"assets/assets/fonts/Roboto-L.ttf": "63d6f579b0db1fc75cc977a0539ce45f",
"assets/assets/fonts/Montserrat-B.ttf": "1f023b349af1d79a72740f4cc881a310",
"canvaskit/skwasm.js": "95f16c6690f955a45b2317496983dbe9",
"canvaskit/skwasm.wasm": "d1fde2560be92c0b07ad9cf9acb10d05",
"canvaskit/chromium/canvaskit.js": "ffb2bb6484d5689d91f393b60664d530",
"canvaskit/chromium/canvaskit.wasm": "393ec8fb05d94036734f8104fa550a67",
"canvaskit/canvaskit.js": "5caccb235fad20e9b72ea6da5a0094e6",
"canvaskit/canvaskit.wasm": "d9f69e0f428f695dc3d66b3a83a4aa8e",
"canvaskit/skwasm.worker.js": "51253d3321b11ddb8d73fa8aa87d3b15"};
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
