'use strict';
const MANIFEST = 'flutter-app-manifest';
const TEMP = 'flutter-temp-cache';
const CACHE_NAME = 'flutter-app-cache';

const RESOURCES = {"version.json": "ffc0aca8010d0690eef1cc5ba4a448b7",
"splash/img/light-2x.png": "de04581de96618c7774eb07917cbb0b5",
"splash/img/dark-4x.png": "d23a48799930e68b79537f9521b54392",
"splash/img/light-3x.png": "0bd86804e97e7c72cff21b1d4bc703ca",
"splash/img/dark-3x.png": "561458e82ed400f83d45d88f79a97598",
"splash/img/light-4x.png": "24b77b0b48cc08787dfa78d8a9b02545",
"splash/img/dark-2x.png": "1de000216e9b5b35639dc772bdb23a54",
"splash/img/dark-1x.png": "efade7303c0cbca00b2a44781e1f4732",
"splash/img/light-1x.png": "de41a29d2394649c3b563d87703d1dcb",
"index.html": "bd278e063468f137213ddcd315329f02",
"/": "bd278e063468f137213ddcd315329f02",
"main.dart.js": "d107a3d142203d4d705196fbc8ac2139",
".well-known/apple-app-site-association": "bda08a6d5ec9db358dab1e697df75298",
".well-known/assetlinks.json": "768c5dec63b05d4c684582be06574c1c",
"flutter.js": "6fef97aeca90b426343ba6c5c9dc5d4a",
"favicon.png": "5e8b10bd566ea7630dff08bacde12129",
"icons/Icon-192.png": "6cabb58d3cda86b51390dca667b72191",
"icons/Icon-maskable-192.png": "ad3727398a480a7dab288bbdb8816c1d",
"icons/Icon-maskable-512.png": "c630886abedfca5e743cd6ecb1d8d9a6",
"icons/Icon-512.png": "76e510d767ca450ea6b0db715e72c4bb",
"manifest.json": "93e150baf71aefcc9993dea1e4ab903b",
"assets/AssetManifest.json": "1f42486b5c26ebc962e658e43904d8c2",
"assets/NOTICES": "aa5b01ca916daefa9730fc1c8a497e3e",
"assets/FontManifest.json": "0f5bd308d82f2167d7e57b4a760a546b",
"assets/packages/cupertino_icons/assets/CupertinoIcons.ttf": "0bd9844d40c7080a4132a4ffb6d21cdc",
"assets/shaders/ink_sparkle.frag": "f8b80e740d33eb157090be4e995febdf",
"assets/AssetManifest.bin": "063bc4b2f80a02bb01d909681a419333",
"assets/fonts/MaterialIcons-Regular.otf": "2434447c259eaeba56709378ccee65e3",
"assets/assets/images/app_icon_dark.png": "36dede79996dcba1330834b9e65d8bd4",
"assets/assets/images/purchase_dark.png": "bfb01194afbe807a3baacab68a46d84a",
"assets/assets/images/fs_task_list.png": "d8c43cce1d306aa8fedc3a805746fe77",
"assets/assets/images/hello_dark.png": "9a48316913b2004cdd863339c9e1faab",
"assets/assets/images/loading_dark.png": "6fa19908a48e1765f0bc781a228094df",
"assets/assets/images/ok.png": "cf0911daea04b1cbb61b2e4044eecd57",
"assets/assets/images/notifications_dark.png": "2e4f32ab4f7a3ae6726651954bf42468",
"assets/assets/images/import.png": "261a2170cc2ba4263560e7cb897f843f",
"assets/assets/images/empty_team.png": "aed92b5dbcb8bf4f7d763d4628088774",
"assets/assets/images/fs_task_list_dark.png": "207eb439cac26643a9a677d758442f6a",
"assets/assets/images/network_error.png": "817b03c4d9190555aa1e201e4e019d3f",
"assets/assets/images/app_icon.png": "f4bd972e85deffc8faf4f4de72150e41",
"assets/assets/images/purchase.png": "6b026b76efc7e56644bb1ddfd6e414bf",
"assets/assets/images/fs_team.png": "edef67b92a1cd3eccfbe3592189157f3",
"assets/assets/images/overdue_dark.png": "ca1306a0b3aab12440525cc6d201db85",
"assets/assets/images/no_info_dark.png": "fee0eca4bffc3887182b0bda05b2bb58",
"assets/assets/images/no_info.png": "9c33399b4aaf3b050a2794706adeccd6",
"assets/assets/images/fs_goals.png": "6d46fe523eaa8e977e44adcecef4a01f",
"assets/assets/images/fs_task_board.png": "9c6e9a24b0e366cffba22157d2eb7f79",
"assets/assets/images/privacy_dark.png": "0e8f1f1d5f06010b89c62b44b0f6455c",
"assets/assets/images/import_dark.png": "0227cd863e2ac0b215b54321e5889e1d",
"assets/assets/images/network_error_dark.png": "684f44a536d903b86316cd0531c8095e",
"assets/assets/images/fs_analytics_dark.png": "8b431746a26c37e87c138b349c6ee976",
"assets/assets/images/risk_dark.png": "21a435bd850184cf96bd5eeb19f78423",
"assets/assets/images/delete_dark.png": "27ce0e9a2186a37dd508bb29a6b4cce8",
"assets/assets/images/sync_dark.png": "96d0e4dab73c2772c03798fdc3f8e3f5",
"assets/assets/images/empty_team_dark.png": "b29ac7eebc6f7efe5a273d15cfde3f8f",
"assets/assets/images/transfer.png": "d9b547e623a50aefc5c9749fcd66da27",
"assets/assets/images/empty_tasks.png": "ba66e8e90bda943ae570c51e41dd36d0",
"assets/assets/images/privacy.png": "04691f059c683f67f21b6c4a62db2875",
"assets/assets/images/fs_estimates.png": "aefb374996c4dd3313ecd2e0c6c181e1",
"assets/assets/images/done.png": "69471ffdb10edcbc930aafec8b13d7fb",
"assets/assets/images/done_dark.png": "6bf60448eac27309c85f38e4f6f41e5b",
"assets/assets/images/transfer_dark.png": "de47a13a666b758921deff5d4caf99b5",
"assets/assets/images/notifications.png": "7d2c5c9d286d7a8a00f377e631e97069",
"assets/assets/images/hello.png": "677c1043536e26454299c7e603acabf3",
"assets/assets/images/fs_estimates_dark.png": "12b55b27e19adacff8af92f22c0b0d80",
"assets/assets/images/empty_sources_dark.png": "1e16b258d85008f90b680080dcff51f5",
"assets/assets/images/sync.png": "02ac8ee29bc79785d379f8c37b98db44",
"assets/assets/images/delete.png": "521aac2e67a56f160eecf2b4428f531d",
"assets/assets/images/empty_tasks_dark.png": "6e96fc32c2675d1057c049fcf914bcce",
"assets/assets/images/fs_team_dark.png": "48c742fe1e16cf9222e36127d5eadfd9",
"assets/assets/images/fs_task_board_dark.png": "c1acb54284a096fe68ea3afb57fc8bf1",
"assets/assets/images/server_error.png": "cf08d6e7b00c425277cb23be865ec903",
"assets/assets/images/save_dark.png": "00a3a4ade60e0059e0d145d69646d66b",
"assets/assets/images/risk.png": "8d922269302a04c149ca855b562fd283",
"assets/assets/images/empty_sources.png": "7a7c5a61ed9dc080e9030a7ecadd6c7b",
"assets/assets/images/fs_analytics.png": "f0e87c357cfc80c5124125821a179d20",
"assets/assets/images/start_dark.png": "28fc3003f6975c74d8a9b00bc9c30044",
"assets/assets/images/overdue.png": "8490d5ea7a8776cdb25d8e79ea12255d",
"assets/assets/images/loading.png": "4b5a8ba4eb67c255ce6f4b72d022b945",
"assets/assets/images/fs_goals_dark.png": "e03b058f95efc941055c65884991269d",
"assets/assets/images/save.png": "7b7e89d6e3ff6c1f8bf441c091442162",
"assets/assets/images/start.png": "38bd1db28b876083be506e3b3119cc7a",
"assets/assets/images/ok_dark.png": "1bf1bdf793286f899aa239d76b7cacb4",
"assets/assets/images/server_error_dark.png": "526b722f0139f4a83f71228b0b2b5a20",
"assets/assets/ca/lets-encrypt-r3.pem": "be77e5992c00fcd753d1b9c11d3768f2",
"assets/assets/icons/google_icon.png": "8620289fcba16d4c5fc70e57ad524906",
"assets/assets/icons/gitlab_icon.png": "2d778422344d370c25e7546f7364ea8b",
"assets/assets/icons/yandex_tracker_icon.png": "26cfc7e5cbfd99b4a652746a83fae930",
"assets/assets/icons/redmine_icon.png": "9e0456fdab8bcc72506384d00dde6b85",
"assets/assets/icons/apple_icon.png": "6979c65521d2698024cc6ccc55c877a4",
"assets/assets/icons/trello_icon.png": "9b9b818c42ee452c58fe19c9b75dc66b",
"assets/assets/icons/notion_icon.png": "6d5a5dfb54350b816fdc13aaa801ff85",
"assets/assets/icons/checkers.png": "4b10aa9787841763944e276def907d79",
"assets/assets/icons/github_icon.png": "3c108b9bc0589487937a75a237f04409",
"assets/assets/icons/jira_icon.png": "5e25b9d8cd0a681b59f810f0a3f4e18a",
"assets/assets/fonts/Roboto-R.ttf": "c613ca81d36649b260700f3335d8f579",
"assets/assets/fonts/Comfortaa-SB.ttf": "50c5468a51006a4b81d223cc28aa1790",
"assets/assets/fonts/Montserrat-M.ttf": "b3ba703c591edd4aad57f8f4561a287b",
"assets/assets/fonts/Roboto-M.ttf": "38aa81d461c299fa9f0cb27726401996",
"assets/assets/fonts/Roboto-L.ttf": "63d6f579b0db1fc75cc977a0539ce45f",
"assets/assets/fonts/Montserrat-B.ttf": "1f023b349af1d79a72740f4cc881a310",
"canvaskit/skwasm.js": "95f16c6690f955a45b2317496983dbe9",
"canvaskit/skwasm.wasm": "d1fde2560be92c0b07ad9cf9acb10d05",
"canvaskit/chromium/canvaskit.js": "96ae916cd2d1b7320fff853ee22aebb0",
"canvaskit/chromium/canvaskit.wasm": "1165572f59d51e963a5bf9bdda61e39b",
"canvaskit/canvaskit.js": "bbf39143dfd758d8d847453b120c8ebb",
"canvaskit/canvaskit.wasm": "19d8b35640d13140fe4e6f3b8d450f04",
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
