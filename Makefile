default: plugins/krakend-server-example.so
	docker run --platform linux/arm64 --rm -p "8080:8080" -v ${PWD}:/etc/krakend/ krakend/krakend-ee:2.2.1

EXTRA_LDFLAGS := "-extldflags=-fuse-ld=bfd -extld=aarch64-linux-musl-gcc"
plugins/krakend-server-example.so: 
	mkdir -p plugins
	docker run --rm -it -v "${PWD}:/app" -w /app \
	-e CGO_ENABLED=1 \
	-e CC=aarch64-linux-musl-gcc \
	-e GOARCH=arm64 \
	-e GOHOSTARCH=amd64 \
	krakend/builder-ee:2.2.1 \
	go build -ldflags=${EXTRA_LDFLAGS} -buildmode=plugin -o plugins/krakend-server-example.so .

clean:
	-rm -rf plugins
