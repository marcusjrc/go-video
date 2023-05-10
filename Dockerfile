# Build stage
FROM golang:1.20.3-alpine3.16 AS BuildStage

WORKDIR /app

COPY . ./

RUN go mod download     

EXPOSE 8080

RUN CGO_ENABLED=0 go build -o build .

# Deploy stage

FROM alpine:latest

WORKDIR /main

COPY --from=BuildStage /app/build .
COPY --from=BuildStage /app/migrations ./migrations
COPY --from=BuildStage /app/deploy.sh .

EXPOSE 8080

CMD ["sh", "./deploy.sh"]