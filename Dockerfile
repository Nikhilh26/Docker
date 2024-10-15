FROM golang:1.20-alpine as build
WORKDIR /app
COPY . .
RUN go mod tidy && go build -o ./server.exe

#doesnt work with scratch 
FROM alpine
WORKDIR /app
COPY --from=build /app/server.exe ./
CMD ["./server.exe"]