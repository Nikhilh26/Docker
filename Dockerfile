FROM golang:1.20-alpine
WORKDIR /app
COPY . .
RUN 
CMD ["go","run","main.go"]