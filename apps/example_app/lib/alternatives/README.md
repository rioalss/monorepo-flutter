# State management alternatives (reference only)

Folder ini berisi **contoh struktur** jika `example_app` memakai **GetX** atau **Riverpod**.
Semua file `.dart` di sini **seluruhnya di-comment** — tidak di-import dan tidak di-run.

App yang aktif tetap memakai **BLoC**. Baseline: `lib/main.dart`, `lib/router/app_router.dart`, `lib/features/**`.

## Perbandingan

| Lapisan | BLoC (aktif) | GetX | Riverpod |
|---------|--------------|------|----------|
| Bootstrap | `SetupBloc` + GetIt | `SetupGetX` + GetIt | `SetupRiverpod` (tanpa GetIt) |
| Session global | `SessionCubit` + `BlocProvider.value` | `SessionController` + `Get.put` | `sessionProvider` |
| Per-route DI | `BlocProvider` di `GoRoute.builder` | `Get.lazyPut` di builder | Provider global (tanpa wrapper) |
| Login UI | `BlocConsumer<LoginCubit>` | `Obx` + `LoginController` | `ref.listen` + `ref.watch(loginProvider)` |
| Dashboard | `SessionCubit` + `UserDetailCubit` | `SessionController` + `UserDetailController` | `sessionProvider` + `userDetailProvider` |
| Router refresh | `GoRouterRefreshStream(cubit.stream)` | `GoRouterRefreshStream` dari `Rx.stream` | `ref.listen(sessionProvider)` → `router.refresh()` |
| Splash / checkSession | `SplashPage` route → `SessionCubit.checkSession()` | `SplashPageGetX` → `SessionController.checkSession()` | `SplashPageRiverpod` → `sessionProvider.notifier.checkSession()` |

## Controllers / providers (`core_state`)

| Feature | BLoC | GetX | Riverpod |
|---------|------|------|----------|
| Session | `SessionCubit` | `SessionController` | `sessionProvider` |
| Login | `LoginCubit` | `LoginController` | `loginProvider` |
| Register | `RegisterCubit` | `RegisterController` | `registerProvider` |
| User detail | `UserDetailCubit` | `UserDetailController` | `userDetailProvider` |
| Users list | `UsersListCubit` | `UsersListController` | `usersListProvider` |

## Struktur folder

```
alternatives/
├── getx/          → mirror BLoC dengan GetX
└── riverpod/      → mirror BLoC dengan Riverpod

lib/features/splash/
├── splash_view.dart   → UI bersama (tanpa state management)
└── splash_page.dart   → BLoC: memanggil checkSession di initState
```

Cold start selalu buka `/splash`; setelah `checkSession` selesai, router redirect ke `/login` atau `/dashboard`.
UI splash (`SplashView`) dipakai ketiga framework.

## Jika mau switch framework

1. Ganti bootstrap (`SetupBloc` → `SetupGetX` / `SetupRiverpod`)
2. Ganti binding DI di router (hapus `BlocProvider`, pakai `Get.put` atau provider global)
3. Ganti widget bindings di pages (`BlocBuilder` → `Obx` / `Consumer`)
4. Tambah dependency di `pubspec.yaml` (`get` atau `flutter_riverpod`)
5. Uncomment & adapt file di folder alternatif ke `lib/`
