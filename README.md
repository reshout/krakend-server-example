# Build and run on Intel MacBook Pro

The plugin is not loaded.

```bash
$ uname -a
Darwin reshout-mbp13 22.2.0 Darwin Kernel Version 22.2.0: Fri Nov 11 02:08:47 PST 2022; root:xnu-8792.61.2~4/RELEASE_X86_64 x86_64
```

```bash
$ mkdir -p plugins
docker run --rm -it -v "/Users/reshout/Projects/krakend-server-example:/app" -w /app \
	-e CGO_ENABLED=1 \
	-e CC=aarch64-linux-musl-gcc \
	-e GOARCH=arm64 \
	-e GOHOSTARCH=amd64 \
	-e EXTRA_LDFLAGS='-extldflags=-fuse-ld=bfd -extld=aarch64-linux-musl-gcc' \
	krakend/builder:2.1.4 \
	go build -ldflags="" -buildmode=plugin -o plugins/krakend-server-example.so .
docker run --platform linux/arm64 --rm -p "8080:8080" -v /Users/reshout/Projects/krakend-server-example:/etc/krakend/ devopsfaith/krakend:2.1.4
Parsing configuration file: /etc/krakend/krakend.json
2023/02/05 08:29:48 KRAKEND INFO: Starting KrakenD v2.1.4
2023/02/05 08:29:48 KRAKEND DEBUG: [SERVICE: Plugin Loader] Starting loading process
2023/02/05 08:29:48 KRAKEND DEBUG: [SERVICE: Executor Plugin] plugin #0 (/etc/krakend/plugins/krakend-server-example.so): plugin: not implemented
2023/02/05 08:29:48 KRAKEND DEBUG: [SERVICE: Handler Plugin] plugin #0 (/etc/krakend/plugins/krakend-server-example.so): plugin: not implemented
2023/02/05 08:29:48 KRAKEND DEBUG: [SERVICE: Modifier Plugin] plugin #0 (/etc/krakend/plugins/krakend-server-example.so): plugin: not implemented
2023/02/05 08:29:48 KRAKEND DEBUG: [SERVICE: Plugin Loader] Loading process completed
2023/02/05 08:29:48 KRAKEND INFO: Starting the KrakenD instance
2023/02/05 08:29:48 KRAKEND DEBUG: [ENDPOINT: /test/:id] Building the proxy pipe
2023/02/05 08:29:48 KRAKEND DEBUG: [BACKEND: /__health] Building the backend pipe
2023/02/05 08:29:48 KRAKEND DEBUG: [ENDPOINT: /test/:id] Building the http handler
2023/02/05 08:29:48 KRAKEND DEBUG: [ENDPOINT: /test/:id][JWTSigner] Signer disabled
2023/02/05 08:29:48 KRAKEND INFO: [ENDPOINT: /test/:id][JWTValidator] Validator disabled for this endpoint
2023/02/05 08:29:48 KRAKEND INFO: [SERVICE: Gin] Listening on port: 8080
2023/02/05 08:29:48 KRAKEND DEBUG: [PLUGIN: Server] No plugins registered for the module
2023/02/05 08:29:53 KRAKEND DEBUG: [SERVICE: Telemetry] Registering usage stats for Cluster ID X1Gcqgq8UaWe3Ty9izrddpt+jos3kc1Qh6Wo1Jrfsdc=
```

# Build and run on Intel Ubuntu Server

It works!

```bash
$ uname -a
Linux reshout.com 5.4.0-137-generic #154-Ubuntu SMP Thu Jan 5 17:03:22 UTC 2023 x86_64 x86_64 x86_64 GNU/Linux
```

```bash
make
mkdir -p plugins
docker run -it -v "/home/reshout/workspace/krakend-server-example:/app" -w /app \
-e CGO_ENABLED=1 \
-e CC=aarch64-linux-musl-gcc \
-e GOARCH=arm64 \
-e GOHOSTARCH=amd64 \
-e EXTRA_LDFLAGS='-extldflags=-fuse-ld=bfd -extld=aarch64-linux-musl-gcc' \
krakend/builder:2.1.4 \
go build -ldflags="" -buildmode=plugin -o plugins/krakend-server-example.so .
docker run --platform linux/arm64 --rm -p "8080:8080" -v /home/reshout/workspace/krakend-server-example:/etc/krakend/ devopsfaith/krakend:2.1.4
Parsing configuration file: /etc/krakend/krakend.json
2023/02/05 08:33:56 KRAKEND INFO: Starting KrakenD v2.1.4
2023/02/05 08:33:56 KRAKEND DEBUG: [SERVICE: Plugin Loader] Starting loading process
2023/02/05 08:33:57 KRAKEND DEBUG: [SERVICE: Executor Plugin] plugin #0 (/etc/krakend/plugins/krakend-server-example.so): plugin: symbol ClientRegisterer not found in plugin krakend-server-example
2023/02/05 08:33:57 KRAKEND DEBUG: [PLUGIN: krakend-server-example] Logger loaded
2023/02/05 08:33:57 KRAKEND INFO: [SERVICE: Handler Plugin] Total plugins loaded: 1
2023/02/05 08:33:57 KRAKEND DEBUG: [SERVICE: Modifier Plugin] plugin #0 (/etc/krakend/plugins/krakend-server-example.so): plugin: symbol ModifierRegisterer not found in plugin krakend-server-example
2023/02/05 08:33:57 KRAKEND DEBUG: [SERVICE: Plugin Loader] Loading process completed
2023/02/05 08:33:57 KRAKEND INFO: Starting the KrakenD instance
2023/02/05 08:33:57 KRAKEND DEBUG: [ENDPOINT: /test/:id] Building the proxy pipe
2023/02/05 08:33:57 KRAKEND DEBUG: [BACKEND: /__health] Building the backend pipe
2023/02/05 08:33:57 KRAKEND DEBUG: [ENDPOINT: /test/:id] Building the http handler
2023/02/05 08:33:57 KRAKEND DEBUG: [ENDPOINT: /test/:id][JWTSigner] Signer disabled
2023/02/05 08:33:57 KRAKEND INFO: [ENDPOINT: /test/:id][JWTValidator] Validator disabled for this endpoint
2023/02/05 08:33:57 KRAKEND INFO: [SERVICE: Gin] Listening on port: 8080
2023/02/05 08:33:57 KRAKEND DEBUG: The plugin is now hijacking the path /hijack-me
2023/02/05 08:33:58 KRAKEND DEBUG: [PLUGIN: Server] Injecting plugin krakend-server-example
2023/02/05 08:34:01 KRAKEND DEBUG: [SERVICE: Telemetry] Registering usage stats for Cluster ID X1Gcqgq8UaWe3Ty9izrddpt+jos3kc1Qh6Wo1Jrfsdc=
```
