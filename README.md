# flutter_mason

Quick Start 💥

```
# 🎯 Activate from https://pub.dev
dart pub global activate mason_cli

# 📁 Initialize mason in the current workspace
mason init

# 📦 Install your first brick
mason add core --git-url https://github.com/mertcanerbasi/flutter_mason --git-path ./bricks/core
mason add repository --git-url https://github.com/mertcanerbasi/flutter_mason --git-path ./bricks/repository
mason add service --git-url https://github.com/mertcanerbasi/flutter_mason --git-path ./bricks/service
mason add page --git-url https://github.com/mertcanerbasi/flutter_mason --git-path ./bricks/page
mason get

# 📝 Code fix
dart fix --apply

# 🚧 Generate code from a brick
mason make core --name {app_name}
mason make page --name {page_name}
mason make repository --name {repository_name}
mason make service --name {service_name}
```
