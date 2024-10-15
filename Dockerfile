FROM ubuntu:latest as build

RUN apt-get update && \
    apt-get install -y curl && \
    curl -fsSL https://deb.nodesource.com/setup_16.x | bash - && \
    apt-get install -y nodejs && \
    apt-get clean

WORKDIR /app
COPY ./client-react /app/
RUN npm ci && npm run build

FROM node:alpine
WORKDIR /app/
COPY --from=build /app/dist /app/dist
COPY /index.js /app/
CMD ["node","index.js"]