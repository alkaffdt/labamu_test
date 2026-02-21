# Offline-First Product App (Flutter)

## Overview

This project is a Flutter application implementing an **offline-first
data architecture** using:

-   Flutter + Riverpod for state management & DI
-   SQLite for local persistence
-   REST API for synchronization
-   Infinite scroll pagination

Users can **create, update, and read products even without internet
connectivity**.\
Changes are stored locally first and synchronized automatically when the
network becomes available.

------------------------------------------------------------------------

# Architecture

The project follows a **feature-based layered architecture**.
## Architecture

The project follows a feature-based layered architecture.

```
lib/
├── core/
│   ├── config/
│   │   └── app_config.dart
│   ├── database/
│   │   └── database_service.dart
│   ├── network/
│   │   ├── dio_client.dart
│   ├── errors/
│   │   ├── failures.dart
│   │   └── exceptions.dart
│   └── utils/
│       └── date_utils.dart
│
├── features/
│   └── product/
│       ├── data/
│       │   ├── datasources/
│       │   │   ├── product_local_datasource.dart
│       │   │   └── product_remote_datasource.dart
│       │   ├── mappers/
│       │   │   └── product_db_mapper.dart
│       │   └── repositories/
│       │       └── product_repository_impl.dart
│       │
│       ├── domain/
│       │   ├── models/
│       │   │   └── product_model.dart
│       │   └── repositories/
│       │       └── product_repository.dart
│       │
│       └── presentation/
│           ├── providers/
│           │   ├── product_providers.dart
│           │   └── sync_manager_provider.dart
│           ├── pages/
│           │   └── product_list_page.dart
│           ├── widgets/
│           │   └── product_card.dart
│           └── utils/
│               └── paging_controller_ext.dart
│
└── main.dart
```
------------------------------------------------------------------------
# Core Features
```
✅ Product List with pagination or infinite scroll
✅ Product Detail view
✅ Create and Edit Product
✅ Offline-first support with local persistence
✅ Automatic sync when network is restored
✅ Clear loading, error, and offline states
```

# Technical spesifications
```
✅ Flutter (latest stable) : 3.41.1
✅ Clean Architecture (presentation, domain, data layers)
✅ Repository pattern and dependency injection
✅ State management : Riverpod
✅ Local persistence SQLite
✅ Network connectivity detection
✅ Proper error handling
```

------------------------------------------------------------------------

# Source of Truth Strategy

The application uses **local database as the primary source of truth**.

This means:

-   UI always reads from SQLite
-   Writes are saved locally first
-   Network is only used for synchronization
-   App works fully offline
-   Sync runs periodically every X seconds ( X = configured via `AppConfig.syncIntervalInSeconds`).

------------------------------------------------------------------------

# Offline-First Data Flow

## Read Flow

              UI → Provider\
                    ↓\
               remote fetch -> if fail then show the data from localDB
                    ↓\
             Local DB updated\ 
                    ↓\
              UI updates 

------------------------------------------------------------------------

## Create Product Flow

User creates product\
        ↓\
Saved immediately to SQLite\
        ↓\
Marked as pending sync (is_synced = 0)\
        ↓\
UI updates instantly\
        ↓\
When internet available → push to server\
        ↓\
Server response replaces local row\
        ↓\
Marked as synced

------------------------------------------------------------------------

## Update Product Flow

User edits product offline\
        ↓\
Local row updated immediately\
        ↓\
Marked pending sync\
        ↓\
Sync worker sends update later\
        ↓\
Local DB replaced with server version

------------------------------------------------------------------------

# Database Design

products( id TEXT PRIMARY KEY, name TEXT, price INTEGER, description
TEXT, status TEXT, updatedAt TEXT, is_synced INTEGER )

------------------------------------------------------------------------

# Pagination Strategy

Pagination is local-driven using:

LIMIT + OFFSET\
ORDER BY updatedAt DESC

This ensures stable scrolling and offline support.

------------------------------------------------------------------------

# Running the Project

flutter pub get
dart run build_runner build --delete-conflicting-outputs
flutter run

Ensure backend API is available if sync is required.

------------------------------------------------------------------------

# Summary

This project demonstrates a **true offline-first architecture** in
Flutter where:

-   local database is authoritative
-   UI never depends on network
-   writes are never blocked by connectivity
-   synchronization is eventual and deterministic
