'use strict';
const MANIFEST = 'flutter-app-manifest';
const TEMP = 'flutter-temp-cache';
const CACHE_NAME = 'flutter-app-cache';

const RESOURCES = {"version.json": "b84a672305dea548cd84914f0da481c2",
"splash/img/light-2x.png": "de04581de96618c7774eb07917cbb0b5",
"splash/img/dark-4x.png": "d23a48799930e68b79537f9521b54392",
"splash/img/light-3x.png": "0bd86804e97e7c72cff21b1d4bc703ca",
"splash/img/dark-3x.png": "561458e82ed400f83d45d88f79a97598",
"splash/img/light-4x.png": "24b77b0b48cc08787dfa78d8a9b02545",
"splash/img/dark-2x.png": "1de000216e9b5b35639dc772bdb23a54",
"splash/img/dark-1x.png": "efade7303c0cbca00b2a44781e1f4732",
"splash/img/light-1x.png": "de41a29d2394649c3b563d87703d1dcb",
"index.html": "41f7036892b10dbec9077cc6ad3c4bcd",
"/": "41f7036892b10dbec9077cc6ad3c4bcd",
"firebase-messaging-sw.js": "28562d3c6999025f15c6faa4e861b175",
"main.dart.js": "80328cd8689cd956ec4d6d914dbf0f95",
".well-known/apple-app-site-association": "bda08a6d5ec9db358dab1e697df75298",
".well-known/assetlinks.json": "768c5dec63b05d4c684582be06574c1c",
"flutter.js": "c71a09214cb6f5f8996a531350400a9a",
"favicon.png": "5e8b10bd566ea7630dff08bacde12129",
"icons/Icon-192.png": "6cabb58d3cda86b51390dca667b72191",
"icons/Icon-maskable-192.png": "ad3727398a480a7dab288bbdb8816c1d",
"icons/Icon-maskable-512.png": "c630886abedfca5e743cd6ecb1d8d9a6",
"icons/Icon-512.png": "76e510d767ca450ea6b0db715e72c4bb",
"manifest.json": "93e150baf71aefcc9993dea1e4ab903b",
"assets/AssetManifest.json": "e3d9627610382ad160750f25a571c909",
"assets/NOTICES": "b20257882d598328350490994f7b7585",
"assets/FontManifest.json": "c47e4ac504991a883b4e05019bfeade4",
"assets/AssetManifest.bin.json": "906411527a23676c7cd4a835b36449a7",
"assets/packages/cupertino_icons/assets/CupertinoIcons.ttf": "a16e6fae514a35c4f49622a1e2433388",
"assets/shaders/ink_sparkle.frag": "ecc85a2e95f5e9f53123dcaf8cb9b6ce",
"assets/AssetManifest.bin": "7043ddc5a060f8472af141dba8bee78c",
"assets/fonts/MaterialIcons-Regular.otf": "ca42382653689e3def34ab9a8e3ff7fc",
"assets/assets/images/team.png": "dbedea41cf108f268d2533cfd2459543",
"assets/assets/images/app_icon_dark.png": "36489ca766a7a0ad536971ed76283bff",
"assets/assets/images/promo_features.png": "32bec4d6124ff7a7e7c8871d252dc344",
"assets/assets/images/purchase_dark.png": "d01adb93fc0a683f4acdbdc95d345470",
"assets/assets/images/milestone.png": "7483ba9fc71499ea5075497a2cd8e107",
"assets/assets/images/hello_dark.png": "f65c3784fce6248cee42c826a593e43b",
"assets/assets/images/goal.png": "14daed31765ea824132e6e3e61437942",
"assets/assets/images/tmpl_task_list_dark.png": "dcafc8cd1603033b8717ce27797b9c7b",
"assets/assets/images/tmpl_businessplan.png": "e408a945c83584f3fea01e60c2d40034",
"assets/assets/images/loading_dark.png": "fd0c962c3bcaa427c21c8a6c5c856a03",
"assets/assets/images/telegram_icon.png": "36e2922c18d291f3181c5534bfdb36e6",
"assets/assets/images/ok.png": "3cadc7eafa4d5150b4033d4e58548021",
"assets/assets/images/notifications_dark.png": "9ca46153c89da40c1e832fe69497e80f",
"assets/assets/images/import.png": "e06e73158e43ba84cfaf0fcedeb3c91b",
"assets/assets/images/fs_tasks.png": "9057c812d0443cde1978149e9a4490b5",
"assets/assets/images/network_error.png": "d29b7c309f19334681d408e9e6610174",
"assets/assets/images/app_icon.png": "f67bf0d59993e5bb170139dedfea762d",
"assets/assets/images/tmpl_businessplan_dark.png": "a16bf51c8b3c75c0b3a7c6ee1ccabcf3",
"assets/assets/images/upgrade_dark.png": "b09a16f4786f9a22ce42e92755ffb642",
"assets/assets/images/purchase.png": "8c129cae9378355de9c8960c9e4d3f8d",
"assets/assets/images/fs_team.png": "15f150c565d86ebf9c09e87bad6a99d1",
"assets/assets/images/web_icon_dark.png": "83e055c9688623ad52d4f4175d29d5a8",
"assets/assets/images/overdue_dark.png": "5b5dbed0f7645bd3ed54abc6fe087771",
"assets/assets/images/tmpl_task_board.png": "0da20e818572de030b7c614d70bc196e",
"assets/assets/images/no_info_dark.png": "a0cbf403e07dbaaa2dacb9b06c891804",
"assets/assets/images/no_info.png": "1bca7d37da745994d1706fa377d19247",
"assets/assets/images/vk_icon_dark.png": "8672475a9d8fdb1d76d160f89017a8cf",
"assets/assets/images/milestone_dark.png": "5149c0ea7ce4454e284dba05e5a99986",
"assets/assets/images/fs_goals.png": "e39fccd7747bc510442bfc1d0fd2a381",
"assets/assets/images/telegram_icon_dark.png": "4ea448ce0bf89fb30ebb371b9aef206a",
"assets/assets/images/web_icon.png": "e705349ddd623fc315f28ed7460e06d2",
"assets/assets/images/privacy_dark.png": "e5d0f64ee75e840a6a8187b39e3f3c32",
"assets/assets/images/import_dark.png": "27036e9493f0221759e49748685659a5",
"assets/assets/images/network_error_dark.png": "3abc4780ee6ba9e2b230064d1b6003fb",
"assets/assets/images/fs_analytics_dark.png": "d14337a8674b91e1d55e7ae931dc0ccf",
"assets/assets/images/goal_done.png": "debcd61a461174f612b8a8f3f75ff349",
"assets/assets/images/risk_dark.png": "f6833347bb1304612a4a7255a62580bb",
"assets/assets/images/3.0x/team.png": "aed92b5dbcb8bf4f7d763d4628088774",
"assets/assets/images/3.0x/app_icon_dark.png": "36dede79996dcba1330834b9e65d8bd4",
"assets/assets/images/3.0x/promo_features.png": "3956973369c9cb0367fadfd3b1846096",
"assets/assets/images/3.0x/purchase_dark.png": "bfb01194afbe807a3baacab68a46d84a",
"assets/assets/images/3.0x/milestone.png": "d6442c5169a5a7927d6d703fcb127b11",
"assets/assets/images/3.0x/hello_dark.png": "9a48316913b2004cdd863339c9e1faab",
"assets/assets/images/3.0x/goal.png": "c74e01aa0818db0c8f564568ff270a61",
"assets/assets/images/3.0x/tmpl_task_list_dark.png": "e602791cb0352c9f0eb06494b1fcc166",
"assets/assets/images/3.0x/tmpl_businessplan.png": "22ffd2ab2b16d39e412fd9541d287e93",
"assets/assets/images/3.0x/loading_dark.png": "6fa19908a48e1765f0bc781a228094df",
"assets/assets/images/3.0x/telegram_icon.png": "b4d1b4f9f00165828dc3afe84ebaf9a0",
"assets/assets/images/3.0x/ok.png": "cf0911daea04b1cbb61b2e4044eecd57",
"assets/assets/images/3.0x/notifications_dark.png": "2e4f32ab4f7a3ae6726651954bf42468",
"assets/assets/images/3.0x/import.png": "261a2170cc2ba4263560e7cb897f843f",
"assets/assets/images/3.0x/fs_tasks.png": "5bfcfbb88f167b711b7696cd97d3252e",
"assets/assets/images/3.0x/network_error.png": "817b03c4d9190555aa1e201e4e019d3f",
"assets/assets/images/3.0x/app_icon.png": "f4bd972e85deffc8faf4f4de72150e41",
"assets/assets/images/3.0x/tmpl_businessplan_dark.png": "435a34aab30e1c2bb474d30ca4c2910b",
"assets/assets/images/3.0x/upgrade_dark.png": "8380970830d0ad97c8a6ba02763da579",
"assets/assets/images/3.0x/purchase.png": "6b026b76efc7e56644bb1ddfd6e414bf",
"assets/assets/images/3.0x/fs_team.png": "0f9dfc4ac53b2ce6c994b06a4b9a04f3",
"assets/assets/images/3.0x/web_icon_dark.png": "c78c98464c0f1809e120b7c81a590969",
"assets/assets/images/3.0x/overdue_dark.png": "ca1306a0b3aab12440525cc6d201db85",
"assets/assets/images/3.0x/tmpl_task_board.png": "e3558c10c49a03d527114f37f6d36c60",
"assets/assets/images/3.0x/no_info_dark.png": "fee0eca4bffc3887182b0bda05b2bb58",
"assets/assets/images/3.0x/no_info.png": "9c33399b4aaf3b050a2794706adeccd6",
"assets/assets/images/3.0x/vk_icon_dark.png": "956180a7c7634a4d835243c82b06af4c",
"assets/assets/images/3.0x/milestone_dark.png": "bbe29cea4ae8393718201cc2e287ad7f",
"assets/assets/images/3.0x/fs_goals.png": "422a0fd4a52bfce7873f6f03be5b246c",
"assets/assets/images/3.0x/telegram_icon_dark.png": "0ec33d24e2142118931fc331c02cae91",
"assets/assets/images/3.0x/web_icon.png": "c6dd463fdc7b43551bb00083092cce7b",
"assets/assets/images/3.0x/privacy_dark.png": "0e8f1f1d5f06010b89c62b44b0f6455c",
"assets/assets/images/3.0x/import_dark.png": "0227cd863e2ac0b215b54321e5889e1d",
"assets/assets/images/3.0x/network_error_dark.png": "684f44a536d903b86316cd0531c8095e",
"assets/assets/images/3.0x/fs_analytics_dark.png": "8a4e88fe2906196f968f73d8e547f145",
"assets/assets/images/3.0x/goal_done.png": "8a00506e6fdb9553097051b129fd1ebb",
"assets/assets/images/3.0x/risk_dark.png": "21a435bd850184cf96bd5eeb19f78423",
"assets/assets/images/3.0x/delete_dark.png": "27ce0e9a2186a37dd508bb29a6b4cce8",
"assets/assets/images/3.0x/sync_dark.png": "96d0e4dab73c2772c03798fdc3f8e3f5",
"assets/assets/images/3.0x/transfer.png": "d9b547e623a50aefc5c9749fcd66da27",
"assets/assets/images/3.0x/upgrade.png": "96011fbc90e0faea1b5f7a0349a2f30e",
"assets/assets/images/3.0x/empty_tasks.png": "ba66e8e90bda943ae570c51e41dd36d0",
"assets/assets/images/3.0x/privacy.png": "04691f059c683f67f21b6c4a62db2875",
"assets/assets/images/3.0x/tmpl_task_board_dark.png": "8fa085a61af586161c9d512bdb810c22",
"assets/assets/images/3.0x/google_calendar.png": "01819d9fff672942097f36572607a84b",
"assets/assets/images/3.0x/ok_blue.png": "e5b6e32c408445498bbfc33273ae1c2e",
"assets/assets/images/3.0x/mail_icon.png": "180de1f181f0d1cf14118021b0a933b0",
"assets/assets/images/3.0x/tmpl_retro_dark.png": "885e13eb0e53f566c68177e9b4d3e0f8",
"assets/assets/images/3.0x/team_dark.png": "b29ac7eebc6f7efe5a273d15cfde3f8f",
"assets/assets/images/3.0x/google_calendar_dark.png": "01819d9fff672942097f36572607a84b",
"assets/assets/images/3.0x/done.png": "69471ffdb10edcbc930aafec8b13d7fb",
"assets/assets/images/3.0x/done_dark.png": "6bf60448eac27309c85f38e4f6f41e5b",
"assets/assets/images/3.0x/vk_icon.png": "92cff0110e6621c786f96d7a70b8b5df",
"assets/assets/images/3.0x/mail_icon_dark.png": "06016daf73162af1d2d3e4b067bc31c2",
"assets/assets/images/3.0x/fs_tasks_dark.png": "e602791cb0352c9f0eb06494b1fcc166",
"assets/assets/images/3.0x/transfer_dark.png": "de47a13a666b758921deff5d4caf99b5",
"assets/assets/images/3.0x/fs_taskboard_dark.png": "8fa085a61af586161c9d512bdb810c22",
"assets/assets/images/3.0x/devices_sync.png": "90b0644b6f48c3debae8e70154570876",
"assets/assets/images/3.0x/notifications.png": "7d2c5c9d286d7a8a00f377e631e97069",
"assets/assets/images/3.0x/hello.png": "677c1043536e26454299c7e603acabf3",
"assets/assets/images/3.0x/fs_taskboard.png": "e3558c10c49a03d527114f37f6d36c60",
"assets/assets/images/3.0x/tmpl_task_list.png": "5bfcfbb88f167b711b7696cd97d3252e",
"assets/assets/images/3.0x/empty_sources_dark.png": "1e16b258d85008f90b680080dcff51f5",
"assets/assets/images/3.0x/sync.png": "02ac8ee29bc79785d379f8c37b98db44",
"assets/assets/images/3.0x/delete.png": "521aac2e67a56f160eecf2b4428f531d",
"assets/assets/images/3.0x/fs_finance_dark.png": "238dbabcd89d816d476f35b71f3c3500",
"assets/assets/images/3.0x/empty_tasks_dark.png": "6e96fc32c2675d1057c049fcf914bcce",
"assets/assets/images/3.0x/devices_sync_dark.png": "f755b51b72ad12c3e7337b04716cba67",
"assets/assets/images/3.0x/fs_team_dark.png": "a87e13e400323bd3139f369b6db508b3",
"assets/assets/images/3.0x/finance_dark.png": "2864be10444d4b2b0e00640fde7fa56d",
"assets/assets/images/3.0x/goal_done_dark.png": "308c020db98aaf88b07780241e1d7dd7",
"assets/assets/images/3.0x/server_error.png": "cf08d6e7b00c425277cb23be865ec903",
"assets/assets/images/3.0x/save_dark.png": "00a3a4ade60e0059e0d145d69646d66b",
"assets/assets/images/3.0x/goal_dark.png": "0669cccad369a8806d60201d91410bf3",
"assets/assets/images/3.0x/tmpl_holidays.png": "8fd8385b3cad0bfd9794a991b2b830bd",
"assets/assets/images/3.0x/promo_features_dark.png": "355d12733e6f550c6b3393bbe48ec780",
"assets/assets/images/3.0x/tmpl_gifts_dark.png": "ad4d9a1a25c277edb26fd238484c593b",
"assets/assets/images/3.0x/ok_blue_dark.png": "c806eac29f35c23ef904d404d8d1fa9b",
"assets/assets/images/3.0x/tmpl_goals.png": "422a0fd4a52bfce7873f6f03be5b246c",
"assets/assets/images/3.0x/risk.png": "8d922269302a04c149ca855b562fd283",
"assets/assets/images/3.0x/empty_sources.png": "7a7c5a61ed9dc080e9030a7ecadd6c7b",
"assets/assets/images/3.0x/fs_analytics.png": "be1df7e8206f5c9cb90c7eca2ba42567",
"assets/assets/images/3.0x/fs_finance.png": "4de0c2e1c85bb57b557efa0b336186f9",
"assets/assets/images/3.0x/tmpl_gifts.png": "91ab7572782510cf5a09da6953f88ed5",
"assets/assets/images/3.0x/overdue.png": "8490d5ea7a8776cdb25d8e79ea12255d",
"assets/assets/images/3.0x/loading.png": "4b5a8ba4eb67c255ce6f4b72d022b945",
"assets/assets/images/3.0x/fs_goals_dark.png": "889f2dbb30212421a302544318825a1f",
"assets/assets/images/3.0x/save.png": "7b7e89d6e3ff6c1f8bf441c091442162",
"assets/assets/images/3.0x/ok_dark.png": "1bf1bdf793286f899aa239d76b7cacb4",
"assets/assets/images/3.0x/tmpl_goals_dark.png": "889f2dbb30212421a302544318825a1f",
"assets/assets/images/3.0x/tmpl_retro.png": "a6552f2dbab7d10d1429f9959b86ecc4",
"assets/assets/images/3.0x/finance.png": "a0190c07e8cd36a7b907c4e6fdc7cbea",
"assets/assets/images/3.0x/server_error_dark.png": "526b722f0139f4a83f71228b0b2b5a20",
"assets/assets/images/3.0x/tmpl_holidays_dark.png": "8357d8e086e3b71fc19867a360526630",
"assets/assets/images/delete_dark.png": "d9612ef04d140265dd2165a81cc70d27",
"assets/assets/images/sync_dark.png": "620facffc2a22371906527c18a505202",
"assets/assets/images/transfer.png": "368f39866ebc9c9b65632a55f5a27076",
"assets/assets/images/upgrade.png": "6850106be22f84e96671b51e0a99e7cb",
"assets/assets/images/empty_tasks.png": "410e3b6b1dcee9409cd7afea5c708a63",
"assets/assets/images/privacy.png": "5e32807280a132a7c033aa571cb9f49a",
"assets/assets/images/tmpl_task_board_dark.png": "de85824eee63d1f971b43beb578ec169",
"assets/assets/images/google_calendar.png": "de7384933b498723525ac50ffc1754bc",
"assets/assets/images/ok_blue.png": "c511743cf17e91deb9e491d3aa8ee93c",
"assets/assets/images/mail_icon.png": "a9fef0cbf19881b38b7482a012381568",
"assets/assets/images/tmpl_retro_dark.png": "69246dd56b52bb198bde82aafdb7eba0",
"assets/assets/images/team_dark.png": "a283b9ef3670a1eaf2a7b001c5d0bc5d",
"assets/assets/images/google_calendar_dark.png": "de7384933b498723525ac50ffc1754bc",
"assets/assets/images/done.png": "1fea780efe14e35f2520584a915dacb1",
"assets/assets/images/done_dark.png": "b61a21de3443bbb000f17333ba95903e",
"assets/assets/images/vk_icon.png": "93b8c2af8a5b94275f8269176275499e",
"assets/assets/images/mail_icon_dark.png": "43fe19f5f8c594641e72457c72bf2fd7",
"assets/assets/images/fs_tasks_dark.png": "dcafc8cd1603033b8717ce27797b9c7b",
"assets/assets/images/transfer_dark.png": "1b749336bf7e12b1dca0210a59291d30",
"assets/assets/images/fs_taskboard_dark.png": "de85824eee63d1f971b43beb578ec169",
"assets/assets/images/devices_sync.png": "5a389e02de407db65ab7f6f85e3070f0",
"assets/assets/images/notifications.png": "45eed8798eacf4b1bc76f6ce797cc427",
"assets/assets/images/hello.png": "840138221c2c0b74224f6e276481e621",
"assets/assets/images/fs_taskboard.png": "0da20e818572de030b7c614d70bc196e",
"assets/assets/images/tmpl_task_list.png": "9057c812d0443cde1978149e9a4490b5",
"assets/assets/images/empty_sources_dark.png": "75718b3059b6d3f81d30f1a066922940",
"assets/assets/images/sync.png": "7b586d3973cb61bafcad0506b500ca9a",
"assets/assets/images/delete.png": "d969a67472602a669f665b5ad113f248",
"assets/assets/images/fs_finance_dark.png": "491a17d02a2a3a0109c6077977a475e3",
"assets/assets/images/empty_tasks_dark.png": "ec33a223ba147dd61fe2ddfb9cfd0b21",
"assets/assets/images/devices_sync_dark.png": "4abd4c3c7e3e92438f0d3639a41974da",
"assets/assets/images/fs_team_dark.png": "73469f66d10dbce24af4f97b65c7ef28",
"assets/assets/images/finance_dark.png": "366b6276703738101519feee8da8ffd1",
"assets/assets/images/goal_done_dark.png": "4f068857121c540ee340a438be8d8f18",
"assets/assets/images/server_error.png": "d463a351a975c75fffb7df8049fba1ed",
"assets/assets/images/save_dark.png": "7e6ccb69f3e19791b523175a05287bbb",
"assets/assets/images/goal_dark.png": "b519f18d74cdfb7d206aa4cd72c49079",
"assets/assets/images/tmpl_holidays.png": "3bc3eb114cbdcc28f0d9ddc05fd942b8",
"assets/assets/images/promo_features_dark.png": "c5e824fba53e6dbf123f007b3eddb195",
"assets/assets/images/tmpl_gifts_dark.png": "f40eb95d53d48df36ff53694e836f00a",
"assets/assets/images/ok_blue_dark.png": "05eb4190ca3a55be5312029d6073442e",
"assets/assets/images/tmpl_goals.png": "e39fccd7747bc510442bfc1d0fd2a381",
"assets/assets/images/risk.png": "1770c0e2298da506a694ed394c98403e",
"assets/assets/images/empty_sources.png": "235c6c75c34e719791580637686e972e",
"assets/assets/images/fs_analytics.png": "f53259147ca03da0689e90e16720627a",
"assets/assets/images/fs_finance.png": "82bd2764bab4d2bdace79acf3cb69a6a",
"assets/assets/images/tmpl_gifts.png": "2faba97352d47ef4da3687582b9f9fad",
"assets/assets/images/overdue.png": "47718b12b40dad1cb01b708c94962130",
"assets/assets/images/loading.png": "ee23eb9f2f3b02f73d269f8de4e5e852",
"assets/assets/images/fs_goals_dark.png": "a4b57663cd5cf6c7e603adf7f110d8a5",
"assets/assets/images/save.png": "0db38107e035641ea7749f752f9463e5",
"assets/assets/images/ok_dark.png": "5c0c406993acec8bf8cd169ae1c08dc7",
"assets/assets/images/tmpl_goals_dark.png": "a4b57663cd5cf6c7e603adf7f110d8a5",
"assets/assets/images/tmpl_retro.png": "13a315ed55f39e8129b51697af49badf",
"assets/assets/images/finance.png": "3237e652eba18d5e24d41d152a98a570",
"assets/assets/images/server_error_dark.png": "42884a971d7a35bba312c00e44c516c6",
"assets/assets/images/tmpl_holidays_dark.png": "8f9b9d894b2855a227e4ff465d97f0e9",
"assets/assets/ca/lets-encrypt-r3.pem": "be77e5992c00fcd753d1b9c11d3768f2",
"assets/assets/icons/google_icon.png": "8620289fcba16d4c5fc70e57ad524906",
"assets/assets/icons/weeek_json_icon.png": "e00dff5a6321e8d585ca8c52169be3da",
"assets/assets/icons/gitlab_icon.png": "2d778422344d370c25e7546f7364ea8b",
"assets/assets/icons/yandex_tracker_icon.png": "26cfc7e5cbfd99b4a652746a83fae930",
"assets/assets/icons/yandex_icon.png": "c06ed17cbb60bad19abc5b2f5b201626",
"assets/assets/icons/redmine_icon.png": "9e0456fdab8bcc72506384d00dde6b85",
"assets/assets/icons/apple_icon.png": "6979c65521d2698024cc6ccc55c877a4",
"assets/assets/icons/trello_icon.png": "9b9b818c42ee452c58fe19c9b75dc66b",
"assets/assets/icons/notion_icon.png": "6d5a5dfb54350b816fdc13aaa801ff85",
"assets/assets/icons/asana_icon.png": "c8df30e5b1c49b7a0be5487d4a449b3c",
"assets/assets/icons/weeek_icon.png": "e00dff5a6321e8d585ca8c52169be3da",
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
"assets/assets/fonts/Montserrat-R.ttf": "3fe868a1a9930b59d94d2c1d79461e3c",
"canvaskit/skwasm.js": "445e9e400085faead4493be2224d95aa",
"canvaskit/skwasm.js.symbols": "741d50ffba71f89345996b0aa8426af8",
"canvaskit/canvaskit.js.symbols": "38cba9233b92472a36ff011dc21c2c9f",
"canvaskit/skwasm.wasm": "e42815763c5d05bba43f9d0337fa7d84",
"canvaskit/chromium/canvaskit.js.symbols": "4525682ef039faeb11f24f37436dca06",
"canvaskit/chromium/canvaskit.js": "43787ac5098c648979c27c13c6f804c3",
"canvaskit/chromium/canvaskit.wasm": "f5934e694f12929ed56a671617acd254",
"canvaskit/canvaskit.js": "c86fbd9e7b17accae76e5ad116583dc4",
"canvaskit/canvaskit.wasm": "3d2a2d663e8c5111ac61a46367f751ac",
"canvaskit/skwasm.worker.js": "bfb704a6c714a75da9ef320991e88b03"};
// The application shell files that are downloaded before a service worker can
// start.
const CORE = ["main.dart.js",
"index.html",
"assets/AssetManifest.bin.json",
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
