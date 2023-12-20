'use strict';
const MANIFEST = 'flutter-app-manifest';
const TEMP = 'flutter-temp-cache';
const CACHE_NAME = 'flutter-app-cache';

const RESOURCES = {"version.json": "14d10a09e1e6a9f3e74f19324a9b0edf",
"splash/img/light-2x.png": "de04581de96618c7774eb07917cbb0b5",
"splash/img/dark-4x.png": "d23a48799930e68b79537f9521b54392",
"splash/img/light-3x.png": "0bd86804e97e7c72cff21b1d4bc703ca",
"splash/img/dark-3x.png": "561458e82ed400f83d45d88f79a97598",
"splash/img/light-4x.png": "24b77b0b48cc08787dfa78d8a9b02545",
"splash/img/dark-2x.png": "1de000216e9b5b35639dc772bdb23a54",
"splash/img/dark-1x.png": "efade7303c0cbca00b2a44781e1f4732",
"splash/img/light-1x.png": "de41a29d2394649c3b563d87703d1dcb",
"index.html": "8350b113dce359949ef11be8b486bbd1",
"/": "8350b113dce359949ef11be8b486bbd1",
"firebase-messaging-sw.js": "28562d3c6999025f15c6faa4e861b175",
"main.dart.js": "80f8e4ce25b94cce27467dafa994b428",
".well-known/apple-app-site-association": "bda08a6d5ec9db358dab1e697df75298",
".well-known/assetlinks.json": "768c5dec63b05d4c684582be06574c1c",
"flutter.js": "7d69e653079438abfbb24b82a655b0a4",
"favicon.png": "5e8b10bd566ea7630dff08bacde12129",
"icons/Icon-192.png": "6cabb58d3cda86b51390dca667b72191",
"icons/Icon-maskable-192.png": "ad3727398a480a7dab288bbdb8816c1d",
"icons/Icon-maskable-512.png": "c630886abedfca5e743cd6ecb1d8d9a6",
"icons/Icon-512.png": "76e510d767ca450ea6b0db715e72c4bb",
"manifest.json": "93e150baf71aefcc9993dea1e4ab903b",
"assets/AssetManifest.json": "90ba17db6cfac16a125a551172dfae2c",
"assets/NOTICES": "24541600af256677cd58ba5bd06b45c3",
"assets/FontManifest.json": "9d901035091a3daa459d862290c9ebc1",
"assets/AssetManifest.bin.json": "1f36205409576409f158abbc95b4d701",
"assets/packages/cupertino_icons/assets/CupertinoIcons.ttf": "728408311379a7a870f0780206bf77d5",
"assets/shaders/ink_sparkle.frag": "4096b5150bac93c41cbc9b45276bd90f",
"assets/AssetManifest.bin": "3e7ef4dcdc29aec12eb76f67009e8088",
"assets/fonts/MaterialIcons-Regular.otf": "2434447c259eaeba56709378ccee65e3",
"assets/assets/images/app_icon_dark.png": "36489ca766a7a0ad536971ed76283bff",
"assets/assets/images/purchase_dark.png": "d01adb93fc0a683f4acdbdc95d345470",
"assets/assets/images/fs_task_list.png": "c77e79d856c0ab755d0ad7e31c09f9c4",
"assets/assets/images/hello_dark.png": "f65c3784fce6248cee42c826a593e43b",
"assets/assets/images/goal.png": "14daed31765ea824132e6e3e61437942",
"assets/assets/images/3x/app_icon_dark.png": "36dede79996dcba1330834b9e65d8bd4",
"assets/assets/images/3x/purchase_dark.png": "bfb01194afbe807a3baacab68a46d84a",
"assets/assets/images/3x/fs_task_list.png": "d8c43cce1d306aa8fedc3a805746fe77",
"assets/assets/images/3x/hello_dark.png": "9a48316913b2004cdd863339c9e1faab",
"assets/assets/images/3x/goal.png": "c74e01aa0818db0c8f564568ff270a61",
"assets/assets/images/3x/tmpl_task_list_dark.png": "207eb439cac26643a9a677d758442f6a",
"assets/assets/images/3x/loading_dark.png": "6fa19908a48e1765f0bc781a228094df",
"assets/assets/images/3x/ok.png": "cf0911daea04b1cbb61b2e4044eecd57",
"assets/assets/images/3x/notifications_dark.png": "2e4f32ab4f7a3ae6726651954bf42468",
"assets/assets/images/3x/import.png": "261a2170cc2ba4263560e7cb897f843f",
"assets/assets/images/3x/empty_team.png": "aed92b5dbcb8bf4f7d763d4628088774",
"assets/assets/images/3x/fs_task_list_dark.png": "207eb439cac26643a9a677d758442f6a",
"assets/assets/images/3x/background_dark.png": "c74ae9e1b8e377dfb32b735d2c0c3a05",
"assets/assets/images/3x/network_error.png": "817b03c4d9190555aa1e201e4e019d3f",
"assets/assets/images/3x/app_icon.png": "f4bd972e85deffc8faf4f4de72150e41",
"assets/assets/images/3x/purchase.png": "6b026b76efc7e56644bb1ddfd6e414bf",
"assets/assets/images/3x/fs_team.png": "edef67b92a1cd3eccfbe3592189157f3",
"assets/assets/images/3x/overdue_dark.png": "ca1306a0b3aab12440525cc6d201db85",
"assets/assets/images/3x/tmpl_task_board.png": "a9510d4ff495e4b03eb01e177dfb0cc3",
"assets/assets/images/3x/no_info_dark.png": "fee0eca4bffc3887182b0bda05b2bb58",
"assets/assets/images/3x/no_info.png": "9c33399b4aaf3b050a2794706adeccd6",
"assets/assets/images/3x/fs_goals.png": "6d46fe523eaa8e977e44adcecef4a01f",
"assets/assets/images/3x/fs_task_board.png": "9c6e9a24b0e366cffba22157d2eb7f79",
"assets/assets/images/3x/privacy_dark.png": "0e8f1f1d5f06010b89c62b44b0f6455c",
"assets/assets/images/3x/import_dark.png": "0227cd863e2ac0b215b54321e5889e1d",
"assets/assets/images/3x/network_error_dark.png": "684f44a536d903b86316cd0531c8095e",
"assets/assets/images/3x/fs_analytics_dark.png": "8b431746a26c37e87c138b349c6ee976",
"assets/assets/images/3x/goal_done.png": "8a00506e6fdb9553097051b129fd1ebb",
"assets/assets/images/3x/risk_dark.png": "21a435bd850184cf96bd5eeb19f78423",
"assets/assets/images/3x/delete_dark.png": "27ce0e9a2186a37dd508bb29a6b4cce8",
"assets/assets/images/3x/sync_dark.png": "96d0e4dab73c2772c03798fdc3f8e3f5",
"assets/assets/images/3x/empty_team_dark.png": "b29ac7eebc6f7efe5a273d15cfde3f8f",
"assets/assets/images/3x/transfer.png": "d9b547e623a50aefc5c9749fcd66da27",
"assets/assets/images/3x/background.png": "28a6086f87bc704b8c9c00663a606592",
"assets/assets/images/3x/empty_tasks.png": "ba66e8e90bda943ae570c51e41dd36d0",
"assets/assets/images/3x/privacy.png": "04691f059c683f67f21b6c4a62db2875",
"assets/assets/images/3x/tmpl_task_board_dark.png": "4bff6b46019d54ce0437bae7aca35c99",
"assets/assets/images/3x/tmpl_retro_dark.png": "1177cb78b637e27f51d27f35eeb9ac76",
"assets/assets/images/3x/fs_estimates.png": "aefb374996c4dd3313ecd2e0c6c181e1",
"assets/assets/images/3x/done.png": "69471ffdb10edcbc930aafec8b13d7fb",
"assets/assets/images/3x/done_dark.png": "6bf60448eac27309c85f38e4f6f41e5b",
"assets/assets/images/3x/transfer_dark.png": "de47a13a666b758921deff5d4caf99b5",
"assets/assets/images/3x/notifications.png": "7d2c5c9d286d7a8a00f377e631e97069",
"assets/assets/images/3x/hello.png": "677c1043536e26454299c7e603acabf3",
"assets/assets/images/3x/fs_estimates_dark.png": "12b55b27e19adacff8af92f22c0b0d80",
"assets/assets/images/3x/tmpl_task_list.png": "d8c43cce1d306aa8fedc3a805746fe77",
"assets/assets/images/3x/empty_sources_dark.png": "1e16b258d85008f90b680080dcff51f5",
"assets/assets/images/3x/sync.png": "02ac8ee29bc79785d379f8c37b98db44",
"assets/assets/images/3x/delete.png": "521aac2e67a56f160eecf2b4428f531d",
"assets/assets/images/3x/empty_tasks_dark.png": "6e96fc32c2675d1057c049fcf914bcce",
"assets/assets/images/3x/fs_team_dark.png": "48c742fe1e16cf9222e36127d5eadfd9",
"assets/assets/images/3x/fs_task_board_dark.png": "c1acb54284a096fe68ea3afb57fc8bf1",
"assets/assets/images/3x/goal_done_dark.png": "308c020db98aaf88b07780241e1d7dd7",
"assets/assets/images/3x/server_error.png": "cf08d6e7b00c425277cb23be865ec903",
"assets/assets/images/3x/save_dark.png": "00a3a4ade60e0059e0d145d69646d66b",
"assets/assets/images/3x/goal_dark.png": "0669cccad369a8806d60201d91410bf3",
"assets/assets/images/3x/tmpl_holidays.png": "33bc9bd30368e5893a9e535391d6cba4",
"assets/assets/images/3x/tmpl_gifts_dark.png": "7738d7e49f52c2b0f5d2047f4549c9d2",
"assets/assets/images/3x/tmpl_goals.png": "6d46fe523eaa8e977e44adcecef4a01f",
"assets/assets/images/3x/risk.png": "8d922269302a04c149ca855b562fd283",
"assets/assets/images/3x/empty_sources.png": "7a7c5a61ed9dc080e9030a7ecadd6c7b",
"assets/assets/images/3x/fs_analytics.png": "f0e87c357cfc80c5124125821a179d20",
"assets/assets/images/3x/tmpl_gifts.png": "7b78a92311c0418daf166852b369504d",
"assets/assets/images/3x/overdue.png": "8490d5ea7a8776cdb25d8e79ea12255d",
"assets/assets/images/3x/loading.png": "4b5a8ba4eb67c255ce6f4b72d022b945",
"assets/assets/images/3x/fs_goals_dark.png": "e03b058f95efc941055c65884991269d",
"assets/assets/images/3x/save.png": "7b7e89d6e3ff6c1f8bf441c091442162",
"assets/assets/images/3x/ok_dark.png": "1bf1bdf793286f899aa239d76b7cacb4",
"assets/assets/images/3x/tmpl_goals_dark.png": "e03b058f95efc941055c65884991269d",
"assets/assets/images/3x/tmpl_retro.png": "0ea386f9a2d5bd9dd3482da900f18c48",
"assets/assets/images/3x/server_error_dark.png": "526b722f0139f4a83f71228b0b2b5a20",
"assets/assets/images/3x/tmpl_holidays_dark.png": "2e0e5e95f3a3097dc771ded43fe97307",
"assets/assets/images/tmpl_task_list_dark.png": "31adb76ff55307b4b7d3724cfcf0d09a",
"assets/assets/images/loading_dark.png": "fd0c962c3bcaa427c21c8a6c5c856a03",
"assets/assets/images/ok.png": "3cadc7eafa4d5150b4033d4e58548021",
"assets/assets/images/notifications_dark.png": "9ca46153c89da40c1e832fe69497e80f",
"assets/assets/images/import.png": "e06e73158e43ba84cfaf0fcedeb3c91b",
"assets/assets/images/empty_team.png": "dbedea41cf108f268d2533cfd2459543",
"assets/assets/images/fs_task_list_dark.png": "31adb76ff55307b4b7d3724cfcf0d09a",
"assets/assets/images/background_dark.png": "bccc0060a66568aa3d0333d871e3e538",
"assets/assets/images/network_error.png": "d29b7c309f19334681d408e9e6610174",
"assets/assets/images/app_icon.png": "f67bf0d59993e5bb170139dedfea762d",
"assets/assets/images/purchase.png": "8c129cae9378355de9c8960c9e4d3f8d",
"assets/assets/images/fs_team.png": "d86652617feeaa46182cfda2a6dc484d",
"assets/assets/images/overdue_dark.png": "5b5dbed0f7645bd3ed54abc6fe087771",
"assets/assets/images/tmpl_task_board.png": "d8b9aaeb5ce0d5c902b262fc315e583b",
"assets/assets/images/no_info_dark.png": "a0cbf403e07dbaaa2dacb9b06c891804",
"assets/assets/images/no_info.png": "1bca7d37da745994d1706fa377d19247",
"assets/assets/images/fs_goals.png": "f8d9e48b56032fd31cea08756d47912f",
"assets/assets/images/fs_task_board.png": "1b7ac722cad2eedf95043c987690c286",
"assets/assets/images/privacy_dark.png": "e5d0f64ee75e840a6a8187b39e3f3c32",
"assets/assets/images/import_dark.png": "27036e9493f0221759e49748685659a5",
"assets/assets/images/network_error_dark.png": "3abc4780ee6ba9e2b230064d1b6003fb",
"assets/assets/images/fs_analytics_dark.png": "ff7e50397be0102fdaabd429a599900d",
"assets/assets/images/goal_done.png": "debcd61a461174f612b8a8f3f75ff349",
"assets/assets/images/risk_dark.png": "f6833347bb1304612a4a7255a62580bb",
"assets/assets/images/delete_dark.png": "d9612ef04d140265dd2165a81cc70d27",
"assets/assets/images/sync_dark.png": "620facffc2a22371906527c18a505202",
"assets/assets/images/empty_team_dark.png": "a283b9ef3670a1eaf2a7b001c5d0bc5d",
"assets/assets/images/transfer.png": "368f39866ebc9c9b65632a55f5a27076",
"assets/assets/images/background.png": "7b9bdee9c7f51865356b8cd413bb6b85",
"assets/assets/images/empty_tasks.png": "410e3b6b1dcee9409cd7afea5c708a63",
"assets/assets/images/privacy.png": "5e32807280a132a7c033aa571cb9f49a",
"assets/assets/images/tmpl_task_board_dark.png": "1c8bcf94d27fed22043758ba6249177d",
"assets/assets/images/tmpl_retro_dark.png": "5c7053f5a8890e635a5ac987a0d0b27c",
"assets/assets/images/fs_estimates.png": "41e7b82f495c5443b5af9480c31b53f9",
"assets/assets/images/done.png": "1fea780efe14e35f2520584a915dacb1",
"assets/assets/images/done_dark.png": "b61a21de3443bbb000f17333ba95903e",
"assets/assets/images/transfer_dark.png": "1b749336bf7e12b1dca0210a59291d30",
"assets/assets/images/notifications.png": "45eed8798eacf4b1bc76f6ce797cc427",
"assets/assets/images/hello.png": "840138221c2c0b74224f6e276481e621",
"assets/assets/images/fs_estimates_dark.png": "a0e6c349aaa7d69e3b58ab05105441a1",
"assets/assets/images/tmpl_task_list.png": "c77e79d856c0ab755d0ad7e31c09f9c4",
"assets/assets/images/empty_sources_dark.png": "75718b3059b6d3f81d30f1a066922940",
"assets/assets/images/sync.png": "7b586d3973cb61bafcad0506b500ca9a",
"assets/assets/images/delete.png": "d969a67472602a669f665b5ad113f248",
"assets/assets/images/empty_tasks_dark.png": "ec33a223ba147dd61fe2ddfb9cfd0b21",
"assets/assets/images/fs_team_dark.png": "3bef28da4ed4469b361d8737ee3947ea",
"assets/assets/images/fs_task_board_dark.png": "169781b86302c732ae37fc9e65b58aee",
"assets/assets/images/goal_done_dark.png": "4f068857121c540ee340a438be8d8f18",
"assets/assets/images/server_error.png": "d463a351a975c75fffb7df8049fba1ed",
"assets/assets/images/save_dark.png": "7e6ccb69f3e19791b523175a05287bbb",
"assets/assets/images/goal_dark.png": "b519f18d74cdfb7d206aa4cd72c49079",
"assets/assets/images/tmpl_holidays.png": "d3e671b65165e2689dd2dd1a8ff08c8d",
"assets/assets/images/tmpl_gifts_dark.png": "6ff4211ef132a8e378d3df6321bb4ed8",
"assets/assets/images/tmpl_goals.png": "f8d9e48b56032fd31cea08756d47912f",
"assets/assets/images/risk.png": "1770c0e2298da506a694ed394c98403e",
"assets/assets/images/empty_sources.png": "235c6c75c34e719791580637686e972e",
"assets/assets/images/fs_analytics.png": "8971548b98e9fd2d5a31afa5b8bf4654",
"assets/assets/images/2x/background_dark.png": "ff7d6725bf714c63a65f5065ac61fd9c",
"assets/assets/images/2x/background.png": "46892776c30fc55989a9181917f32480",
"assets/assets/images/tmpl_gifts.png": "4cdbc07a4d9ae4dccfcb5fead4345751",
"assets/assets/images/overdue.png": "47718b12b40dad1cb01b708c94962130",
"assets/assets/images/loading.png": "ee23eb9f2f3b02f73d269f8de4e5e852",
"assets/assets/images/fs_goals_dark.png": "b405ca7df1b10f60add4606db43f050c",
"assets/assets/images/save.png": "0db38107e035641ea7749f752f9463e5",
"assets/assets/images/ok_dark.png": "5c0c406993acec8bf8cd169ae1c08dc7",
"assets/assets/images/tmpl_goals_dark.png": "b405ca7df1b10f60add4606db43f050c",
"assets/assets/images/tmpl_retro.png": "c9a95d0b1d7591d3283ebfbd71d9d14e",
"assets/assets/images/server_error_dark.png": "42884a971d7a35bba312c00e44c516c6",
"assets/assets/images/tmpl_holidays_dark.png": "56f2984af182fb50051553a8e90ed743",
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
"assets/assets/icons/trello_json_icon.png": "9b9b818c42ee452c58fe19c9b75dc66b",
"assets/assets/fonts/Roboto-R.ttf": "c613ca81d36649b260700f3335d8f579",
"assets/assets/fonts/Comfortaa-SB.ttf": "50c5468a51006a4b81d223cc28aa1790",
"assets/assets/fonts/Montserrat-M.ttf": "b3ba703c591edd4aad57f8f4561a287b",
"assets/assets/fonts/Roboto-M.ttf": "38aa81d461c299fa9f0cb27726401996",
"assets/assets/fonts/Roboto-L.ttf": "63d6f579b0db1fc75cc977a0539ce45f",
"assets/assets/fonts/Montserrat-B.ttf": "1f023b349af1d79a72740f4cc881a310",
"canvaskit/skwasm.js": "87063acf45c5e1ab9565dcf06b0c18b8",
"canvaskit/skwasm.wasm": "2fc47c0a0c3c7af8542b601634fe9674",
"canvaskit/chromium/canvaskit.js": "0ae8bbcc58155679458a0f7a00f66873",
"canvaskit/chromium/canvaskit.wasm": "143af6ff368f9cd21c863bfa4274c406",
"canvaskit/canvaskit.js": "eb8797020acdbdf96a12fb0405582c1b",
"canvaskit/canvaskit.wasm": "73584c1a3367e3eaf757647a8f5c5989",
"canvaskit/skwasm.worker.js": "bfb704a6c714a75da9ef320991e88b03"};
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
