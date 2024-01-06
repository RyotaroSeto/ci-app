FROM golang:1.21.4-alpine3.18 as build
WORKDIR /build
COPY . .
RUN CGO_ENABLED=0 go build -ldflags '-s -w' -trimpath -o app -a main.go

FROM gcr.io/distroless/static-debian11:nonroot
COPY --chown=nonroot:nonroot --from=build /build/app /app

USER nonroot

EXPOSE 8080

ENTRYPOINT [ "/app" ]
