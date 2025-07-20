'use strict';
const MANIFEST = 'flutter-app-manifest';
const TEMP = 'flutter-temp-cache';
const CACHE_NAME = 'flutter-app-cache';

const RESOURCES = {"flutter_bootstrap.js": "89f046956321319eaeb8236f813eca4a",
"version.json": "f14f8d80ca0f62f885205dcec892a175",
"splash/img/light-2x.png": "de04581de96618c7774eb07917cbb0b5",
"splash/img/dark-4x.png": "d23a48799930e68b79537f9521b54392",
"splash/img/light-3x.png": "0bd86804e97e7c72cff21b1d4bc703ca",
"splash/img/dark-3x.png": "561458e82ed400f83d45d88f79a97598",
"splash/img/light-4x.png": "24b77b0b48cc08787dfa78d8a9b02545",
"splash/img/dark-2x.png": "1de000216e9b5b35639dc772bdb23a54",
"splash/img/dark-1x.png": "efade7303c0cbca00b2a44781e1f4732",
"splash/img/light-1x.png": "de41a29d2394649c3b563d87703d1dcb",
"index.html": "6704d17be4802d5ad384b341c9f8a94b",
"/": "6704d17be4802d5ad384b341c9f8a94b",
"firebase-messaging-sw.js": "68402ccfd644171c5303eb9224ff121f",
"main.dart.js": "8c61c6b1a36c002a97d06fea723a687a",
".well-known/apple-app-site-association": "bda08a6d5ec9db358dab1e697df75298",
".well-known/assetlinks.json": "768c5dec63b05d4c684582be06574c1c",
"flutter.js": "83d881c1dbb6d6bcd6b42e274605b69c",
"favicon.png": "5e8b10bd566ea7630dff08bacde12129",
"icons/Icon-192.png": "6cabb58d3cda86b51390dca667b72191",
"icons/Icon-maskable-192.png": "ad3727398a480a7dab288bbdb8816c1d",
"icons/Icon-maskable-512.png": "c630886abedfca5e743cd6ecb1d8d9a6",
"icons/Icon-512.png": "76e510d767ca450ea6b0db715e72c4bb",
"manifest.json": "93e150baf71aefcc9993dea1e4ab903b",
"assets/AssetManifest.json": "56988179733c02ab21fbe4b9870c3d3c",
"assets/NOTICES": "1cba4c14c79a5807faa7b53e8042aece",
"assets/FontManifest.json": "c47e4ac504991a883b4e05019bfeade4",
"assets/AssetManifest.bin.json": "22cdafac7f1373326f6bbc1334a1e644",
"assets/packages/cupertino_icons/assets/CupertinoIcons.ttf": "e1f76fbfb4d140c8e0da9998089db9ac",
"assets/shaders/ink_sparkle.frag": "ecc85a2e95f5e9f53123dcaf8cb9b6ce",
"assets/AssetManifest.bin": "39089dbd3b9a4de27ee8c4d2ff70cc36",
"assets/fonts/MaterialIcons-Regular.otf": "76c8a4c5dda9500df6f29026418e79c3",
"assets/assets/images/team.png": "dbedea41cf108f268d2533cfd2459543",
"assets/assets/images/app_icon_dark.png": "36489ca766a7a0ad536971ed76283bff",
"assets/assets/images/purchase_dark.png": "d01adb93fc0a683f4acdbdc95d345470",
"assets/assets/images/relations.png": "992f17b59472fe6e31adf4e2bdb7c1d1",
"assets/assets/images/hello_dark.png": "f197280df11589d82a54ff86273b94b6",
"assets/assets/images/goal.png": "14daed31765ea824132e6e3e61437942",
"assets/assets/images/tmpl_task_list_dark.png": "dcafc8cd1603033b8717ce27797b9c7b",
"assets/assets/images/tmpl_businessplan.png": "e408a945c83584f3fea01e60c2d40034",
"assets/assets/images/loading_dark.png": "fd0c962c3bcaa427c21c8a6c5c856a03",
"assets/assets/images/telegram_icon.png": "36e2922c18d291f3181c5534bfdb36e6",
"assets/assets/images/notifications_dark.png": "9ca46153c89da40c1e832fe69497e80f",
"assets/assets/images/import.png": "e06e73158e43ba84cfaf0fcedeb3c91b",
"assets/assets/images/fs_tasks.png": "9057c812d0443cde1978149e9a4490b5",
"assets/assets/images/promo_team.png": "ca4d69c0911023ccfd0fba743082192b",
"assets/assets/images/app_icon.png": "f67bf0d59993e5bb170139dedfea762d",
"assets/assets/images/tmpl_businessplan_dark.png": "a16bf51c8b3c75c0b3a7c6ee1ccabcf3",
"assets/assets/images/upgrade_dark.png": "b09a16f4786f9a22ce42e92755ffb642",
"assets/assets/images/purchase.png": "8c129cae9378355de9c8960c9e4d3f8d",
"assets/assets/images/fs_team.png": "15f150c565d86ebf9c09e87bad6a99d1",
"assets/assets/images/web_icon_dark.png": "83e055c9688623ad52d4f4175d29d5a8",
"assets/assets/images/tmpl_task_board.png": "0da20e818572de030b7c614d70bc196e",
"assets/assets/images/no_info_dark.png": "a0cbf403e07dbaaa2dacb9b06c891804",
"assets/assets/images/no_info.png": "1bca7d37da745994d1706fa377d19247",
"assets/assets/images/vk_icon_dark.png": "8672475a9d8fdb1d76d160f89017a8cf",
"assets/assets/images/apple_icon_dark.png": "d3d6118d92a09e0b356506939b92769c",
"assets/assets/images/fs_goals.png": "e39fccd7747bc510442bfc1d0fd2a381",
"assets/assets/images/telegram_icon_dark.png": "4ea448ce0bf89fb30ebb371b9aef206a",
"assets/assets/images/web_icon.png": "e705349ddd623fc315f28ed7460e06d2",
"assets/assets/images/privacy_dark.png": "e5d0f64ee75e840a6a8187b39e3f3c32",
"assets/assets/images/import_dark.png": "27036e9493f0221759e49748685659a5",
"assets/assets/images/fs_analytics_dark.png": "d14337a8674b91e1d55e7ae931dc0ccf",
"assets/assets/images/goal_done.png": "debcd61a461174f612b8a8f3f75ff349",
"assets/assets/images/promo_finance_dark.png": "7c818d43cd72410416e4bb8ebd24622b",
"assets/assets/images/not_found_dark.png": "da3816785e57ef64daa141642dfb7e1d",
"assets/assets/images/3.0x/team.png": "aed92b5dbcb8bf4f7d763d4628088774",
"assets/assets/images/3.0x/app_icon_dark.png": "36dede79996dcba1330834b9e65d8bd4",
"assets/assets/images/3.0x/purchase_dark.png": "bfb01194afbe807a3baacab68a46d84a",
"assets/assets/images/3.0x/relations.png": "7d56d72653d31f6ff85221aee3f7f7b8",
"assets/assets/images/3.0x/hello_dark.png": "3b73bc97ba59d20528c6badbc6682449",
"assets/assets/images/3.0x/goal.png": "c74e01aa0818db0c8f564568ff270a61",
"assets/assets/images/3.0x/tmpl_task_list_dark.png": "e602791cb0352c9f0eb06494b1fcc166",
"assets/assets/images/3.0x/tmpl_businessplan.png": "22ffd2ab2b16d39e412fd9541d287e93",
"assets/assets/images/3.0x/loading_dark.png": "6fa19908a48e1765f0bc781a228094df",
"assets/assets/images/3.0x/telegram_icon.png": "b4d1b4f9f00165828dc3afe84ebaf9a0",
"assets/assets/images/3.0x/notifications_dark.png": "2e4f32ab4f7a3ae6726651954bf42468",
"assets/assets/images/3.0x/import.png": "261a2170cc2ba4263560e7cb897f843f",
"assets/assets/images/3.0x/fs_tasks.png": "5bfcfbb88f167b711b7696cd97d3252e",
"assets/assets/images/3.0x/promo_team.png": "73fc1746cf77475bf9260e3ef9798d8a",
"assets/assets/images/3.0x/app_icon.png": "f4bd972e85deffc8faf4f4de72150e41",
"assets/assets/images/3.0x/tmpl_businessplan_dark.png": "435a34aab30e1c2bb474d30ca4c2910b",
"assets/assets/images/3.0x/upgrade_dark.png": "8380970830d0ad97c8a6ba02763da579",
"assets/assets/images/3.0x/purchase.png": "6b026b76efc7e56644bb1ddfd6e414bf",
"assets/assets/images/3.0x/fs_team.png": "0f9dfc4ac53b2ce6c994b06a4b9a04f3",
"assets/assets/images/3.0x/web_icon_dark.png": "c78c98464c0f1809e120b7c81a590969",
"assets/assets/images/3.0x/tmpl_task_board.png": "e3558c10c49a03d527114f37f6d36c60",
"assets/assets/images/3.0x/no_info_dark.png": "fee0eca4bffc3887182b0bda05b2bb58",
"assets/assets/images/3.0x/no_info.png": "9c33399b4aaf3b050a2794706adeccd6",
"assets/assets/images/3.0x/vk_icon_dark.png": "956180a7c7634a4d835243c82b06af4c",
"assets/assets/images/3.0x/apple_icon_dark.png": "e51e3d58899f25eda9c85014e3ab05ac",
"assets/assets/images/3.0x/fs_goals.png": "422a0fd4a52bfce7873f6f03be5b246c",
"assets/assets/images/3.0x/telegram_icon_dark.png": "0ec33d24e2142118931fc331c02cae91",
"assets/assets/images/3.0x/web_icon.png": "c6dd463fdc7b43551bb00083092cce7b",
"assets/assets/images/3.0x/privacy_dark.png": "0e8f1f1d5f06010b89c62b44b0f6455c",
"assets/assets/images/3.0x/import_dark.png": "0227cd863e2ac0b215b54321e5889e1d",
"assets/assets/images/3.0x/fs_analytics_dark.png": "8a4e88fe2906196f968f73d8e547f145",
"assets/assets/images/3.0x/goal_done.png": "8a00506e6fdb9553097051b129fd1ebb",
"assets/assets/images/3.0x/promo_finance_dark.png": "a6272c41318cf7ce824ad8a954259081",
"assets/assets/images/3.0x/not_found_dark.png": "f5cff27444823b84d2306b5121a9e9cf",
"assets/assets/images/3.0x/delete_dark.png": "27ce0e9a2186a37dd508bb29a6b4cce8",
"assets/assets/images/3.0x/sync_dark.png": "96d0e4dab73c2772c03798fdc3f8e3f5",
"assets/assets/images/3.0x/transfer.png": "d9b547e623a50aefc5c9749fcd66da27",
"assets/assets/images/3.0x/upgrade.png": "96011fbc90e0faea1b5f7a0349a2f30e",
"assets/assets/images/3.0x/promo_team_dark.png": "51d61bf3a2db3c7c693f9ef58f9947e2",
"assets/assets/images/3.0x/empty_tasks.png": "ba66e8e90bda943ae570c51e41dd36d0",
"assets/assets/images/3.0x/privacy.png": "04691f059c683f67f21b6c4a62db2875",
"assets/assets/images/3.0x/tmpl_task_board_dark.png": "8fa085a61af586161c9d512bdb810c22",
"assets/assets/images/3.0x/google_calendar.png": "01819d9fff672942097f36572607a84b",
"assets/assets/images/3.0x/mail_icon.png": "180de1f181f0d1cf14118021b0a933b0",
"assets/assets/images/3.0x/tmpl_retro_dark.png": "885e13eb0e53f566c68177e9b4d3e0f8",
"assets/assets/images/3.0x/team_dark.png": "b29ac7eebc6f7efe5a273d15cfde3f8f",
"assets/assets/images/3.0x/google_calendar_dark.png": "01819d9fff672942097f36572607a84b",
"assets/assets/images/3.0x/vk_icon.png": "92cff0110e6621c786f96d7a70b8b5df",
"assets/assets/images/3.0x/mail_icon_dark.png": "06016daf73162af1d2d3e4b067bc31c2",
"assets/assets/images/3.0x/fs_tasks_dark.png": "e602791cb0352c9f0eb06494b1fcc166",
"assets/assets/images/3.0x/transfer_dark.png": "de47a13a666b758921deff5d4caf99b5",
"assets/assets/images/3.0x/fs_taskboard_dark.png": "8fa085a61af586161c9d512bdb810c22",
"assets/assets/images/3.0x/notifications.png": "7d2c5c9d286d7a8a00f377e631e97069",
"assets/assets/images/3.0x/apple_icon.png": "4445872307af7a91fc294709dd24c5f9",
"assets/assets/images/3.0x/hello.png": "9e2a8e29c53a9e7029bbee0a248255dc",
"assets/assets/images/3.0x/promo_analytics.png": "6da82f489537988f81bf3bd1220daacc",
"assets/assets/images/3.0x/fs_taskboard.png": "e3558c10c49a03d527114f37f6d36c60",
"assets/assets/images/3.0x/relations_dark.png": "263581cca8b433a5bc22e1036a6e7320",
"assets/assets/images/3.0x/tmpl_task_list.png": "5bfcfbb88f167b711b7696cd97d3252e",
"assets/assets/images/3.0x/empty_sources_dark.png": "1e16b258d85008f90b680080dcff51f5",
"assets/assets/images/3.0x/sync.png": "02ac8ee29bc79785d379f8c37b98db44",
"assets/assets/images/3.0x/delete.png": "521aac2e67a56f160eecf2b4428f531d",
"assets/assets/images/3.0x/fs_finance_dark.png": "238dbabcd89d816d476f35b71f3c3500",
"assets/assets/images/3.0x/promo_analytics_dark.png": "e6665fdff1860416d140beea5ca52d41",
"assets/assets/images/3.0x/empty_tasks_dark.png": "6e96fc32c2675d1057c049fcf914bcce",
"assets/assets/images/3.0x/fs_team_dark.png": "a87e13e400323bd3139f369b6db508b3",
"assets/assets/images/3.0x/finance_dark.png": "2864be10444d4b2b0e00640fde7fa56d",
"assets/assets/images/3.0x/promo_finance.png": "186fc1260b102731c1f0657632217acd",
"assets/assets/images/3.0x/goal_done_dark.png": "308c020db98aaf88b07780241e1d7dd7",
"assets/assets/images/3.0x/server_error.png": "cf08d6e7b00c425277cb23be865ec903",
"assets/assets/images/3.0x/save_dark.png": "00a3a4ade60e0059e0d145d69646d66b",
"assets/assets/images/3.0x/goal_dark.png": "0669cccad369a8806d60201d91410bf3",
"assets/assets/images/3.0x/tmpl_holidays.png": "8fd8385b3cad0bfd9794a991b2b830bd",
"assets/assets/images/3.0x/tmpl_gifts_dark.png": "ad4d9a1a25c277edb26fd238484c593b",
"assets/assets/images/3.0x/tmpl_repair_dark.png": "a02c50d11ee228026456f800162fcd97",
"assets/assets/images/3.0x/tmpl_goals.png": "422a0fd4a52bfce7873f6f03be5b246c",
"assets/assets/images/3.0x/empty_sources.png": "7a7c5a61ed9dc080e9030a7ecadd6c7b",
"assets/assets/images/3.0x/fs_analytics.png": "be1df7e8206f5c9cb90c7eca2ba42567",
"assets/assets/images/3.0x/fs_finance.png": "4de0c2e1c85bb57b557efa0b336186f9",
"assets/assets/images/3.0x/tmpl_gifts.png": "91ab7572782510cf5a09da6953f88ed5",
"assets/assets/images/3.0x/tmpl_repair.png": "461e38de4ee3228eb159918c660f7d5e",
"assets/assets/images/3.0x/loading.png": "4b5a8ba4eb67c255ce6f4b72d022b945",
"assets/assets/images/3.0x/fs_goals_dark.png": "889f2dbb30212421a302544318825a1f",
"assets/assets/images/3.0x/save.png": "7b7e89d6e3ff6c1f8bf441c091442162",
"assets/assets/images/3.0x/not_found.png": "a26707cce6594aa6e9fa39d438e69fba",
"assets/assets/images/3.0x/tmpl_goals_dark.png": "889f2dbb30212421a302544318825a1f",
"assets/assets/images/3.0x/tmpl_retro.png": "a6552f2dbab7d10d1429f9959b86ecc4",
"assets/assets/images/3.0x/finance.png": "a0190c07e8cd36a7b907c4e6fdc7cbea",
"assets/assets/images/3.0x/server_error_dark.png": "526b722f0139f4a83f71228b0b2b5a20",
"assets/assets/images/3.0x/tmpl_holidays_dark.png": "8357d8e086e3b71fc19867a360526630",
"assets/assets/images/delete_dark.png": "d9612ef04d140265dd2165a81cc70d27",
"assets/assets/images/sync_dark.png": "620facffc2a22371906527c18a505202",
"assets/assets/images/transfer.png": "368f39866ebc9c9b65632a55f5a27076",
"assets/assets/images/upgrade.png": "6850106be22f84e96671b51e0a99e7cb",
"assets/assets/images/promo_team_dark.png": "cc693be12e6797cd45aa07795db22737",
"assets/assets/images/empty_tasks.png": "410e3b6b1dcee9409cd7afea5c708a63",
"assets/assets/images/privacy.png": "5e32807280a132a7c033aa571cb9f49a",
"assets/assets/images/tmpl_task_board_dark.png": "de85824eee63d1f971b43beb578ec169",
"assets/assets/images/google_calendar.png": "de7384933b498723525ac50ffc1754bc",
"assets/assets/images/mail_icon.png": "a9fef0cbf19881b38b7482a012381568",
"assets/assets/images/tmpl_retro_dark.png": "69246dd56b52bb198bde82aafdb7eba0",
"assets/assets/images/team_dark.png": "a283b9ef3670a1eaf2a7b001c5d0bc5d",
"assets/assets/images/google_calendar_dark.png": "de7384933b498723525ac50ffc1754bc",
"assets/assets/images/vk_icon.png": "93b8c2af8a5b94275f8269176275499e",
"assets/assets/images/mail_icon_dark.png": "43fe19f5f8c594641e72457c72bf2fd7",
"assets/assets/images/fs_tasks_dark.png": "dcafc8cd1603033b8717ce27797b9c7b",
"assets/assets/images/transfer_dark.png": "1b749336bf7e12b1dca0210a59291d30",
"assets/assets/images/fs_taskboard_dark.png": "de85824eee63d1f971b43beb578ec169",
"assets/assets/images/notifications.png": "45eed8798eacf4b1bc76f6ce797cc427",
"assets/assets/images/apple_icon.png": "5cbf87013142d6a94a4d75d87e8ff1d0",
"assets/assets/images/hello.png": "479f7f36b800daae152fcdef51dbb9d7",
"assets/assets/images/promo_analytics.png": "4b4b1591bff852080e52af71e73ad61f",
"assets/assets/images/fs_taskboard.png": "0da20e818572de030b7c614d70bc196e",
"assets/assets/images/relations_dark.png": "10d2c5c826836d582199df5c44591e95",
"assets/assets/images/tmpl_task_list.png": "9057c812d0443cde1978149e9a4490b5",
"assets/assets/images/empty_sources_dark.png": "75718b3059b6d3f81d30f1a066922940",
"assets/assets/images/sync.png": "7b586d3973cb61bafcad0506b500ca9a",
"assets/assets/images/delete.png": "d969a67472602a669f665b5ad113f248",
"assets/assets/images/fs_finance_dark.png": "491a17d02a2a3a0109c6077977a475e3",
"assets/assets/images/promo_analytics_dark.png": "71731f2c6e773ea80d3e1af8b751e41b",
"assets/assets/images/empty_tasks_dark.png": "ec33a223ba147dd61fe2ddfb9cfd0b21",
"assets/assets/images/fs_team_dark.png": "73469f66d10dbce24af4f97b65c7ef28",
"assets/assets/images/finance_dark.png": "366b6276703738101519feee8da8ffd1",
"assets/assets/images/promo_finance.png": "11e742791ad1b871f57e9e473b2c2290",
"assets/assets/images/goal_done_dark.png": "4f068857121c540ee340a438be8d8f18",
"assets/assets/images/server_error.png": "d463a351a975c75fffb7df8049fba1ed",
"assets/assets/images/save_dark.png": "7e6ccb69f3e19791b523175a05287bbb",
"assets/assets/images/goal_dark.png": "b519f18d74cdfb7d206aa4cd72c49079",
"assets/assets/images/tmpl_holidays.png": "3bc3eb114cbdcc28f0d9ddc05fd942b8",
"assets/assets/images/tmpl_gifts_dark.png": "f40eb95d53d48df36ff53694e836f00a",
"assets/assets/images/tmpl_repair_dark.png": "ee3ef998b58e772c45a2cadc089fd6ae",
"assets/assets/images/tmpl_goals.png": "e39fccd7747bc510442bfc1d0fd2a381",
"assets/assets/images/empty_sources.png": "235c6c75c34e719791580637686e972e",
"assets/assets/images/fs_analytics.png": "f53259147ca03da0689e90e16720627a",
"assets/assets/images/fs_finance.png": "82bd2764bab4d2bdace79acf3cb69a6a",
"assets/assets/images/tmpl_gifts.png": "2faba97352d47ef4da3687582b9f9fad",
"assets/assets/images/tmpl_repair.png": "9e86b7ed63335eda9fd238ba3ed20304",
"assets/assets/images/loading.png": "ee23eb9f2f3b02f73d269f8de4e5e852",
"assets/assets/images/fs_goals_dark.png": "a4b57663cd5cf6c7e603adf7f110d8a5",
"assets/assets/images/save.png": "0db38107e035641ea7749f752f9463e5",
"assets/assets/images/not_found.png": "843ffc0e721ad8130ddcac7dae787ac4",
"assets/assets/images/tmpl_goals_dark.png": "a4b57663cd5cf6c7e603adf7f110d8a5",
"assets/assets/images/tmpl_retro.png": "13a315ed55f39e8129b51697af49badf",
"assets/assets/images/finance.png": "3237e652eba18d5e24d41d152a98a570",
"assets/assets/images/server_error_dark.png": "42884a971d7a35bba312c00e44c516c6",
"assets/assets/images/tmpl_holidays_dark.png": "8f9b9d894b2855a227e4ff465d97f0e9",
"assets/assets/ca/lets-encrypt-r3.pem": "be77e5992c00fcd753d1b9c11d3768f2",
"assets/assets/icons/google_icon.png": "646da438ffed833514774fca6a5ccf9f",
"assets/assets/icons/weeek_json_icon.png": "e00dff5a6321e8d585ca8c52169be3da",
"assets/assets/icons/gitlab_icon.png": "2d778422344d370c25e7546f7364ea8b",
"assets/assets/icons/yandex_tracker_icon.png": "26cfc7e5cbfd99b4a652746a83fae930",
"assets/assets/icons/yandex_icon.png": "70a4679341dc56fcf6f963a1c2c5847d",
"assets/assets/icons/redmine_icon.png": "9e0456fdab8bcc72506384d00dde6b85",
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
"canvaskit/skwasm.js": "ea559890a088fe28b4ddf70e17e60052",
"canvaskit/skwasm.js.symbols": "e72c79950c8a8483d826a7f0560573a1",
"canvaskit/canvaskit.js.symbols": "bdcd3835edf8586b6d6edfce8749fb77",
"canvaskit/skwasm.wasm": "39dd80367a4e71582d234948adc521c0",
"canvaskit/chromium/canvaskit.js.symbols": "b61b5f4673c9698029fa0a746a9ad581",
"canvaskit/chromium/canvaskit.js": "8191e843020c832c9cf8852a4b909d4c",
"canvaskit/chromium/canvaskit.wasm": "f504de372e31c8031018a9ec0a9ef5f0",
"canvaskit/canvaskit.js": "728b2d477d9b8c14593d4f9b82b484f3",
"canvaskit/canvaskit.wasm": "7a3f4ae7d65fc1de6a6e7ddd3224bc93"};
// The application shell files that are downloaded before a service worker can
// start.
const CORE = ["main.dart.js",
"index.html",
"flutter_bootstrap.js",
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
