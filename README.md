# Flutter Base
## Flutter app with all the basics ready to go

### Includes:
- Routing using Go Router
    - Simple centralised config file for quickly setting up routes
- Bottom Navigation Bar for root pages
- Top App Bar for page titles
    - Back button is visible for subpages
- TODO: state management
    - with persistent storage
- TODO: simplified form creation?
    - with validation
- TODO: config for app settings
    - enable/disable app/nav bar

### Quick Start:
1. Add pages to `/lib/pages`
2. Setup routes in `/lib/routing/routes.dart`
    - `includeInNav` to show in bottom navigation bar
    - `icon` controls nav bar icon
    - `label` controls nav bar text
    - `title` controls app bar text