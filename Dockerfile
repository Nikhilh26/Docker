# FROM ubuntu:latest as build

# RUN apt-get update && \
#     apt-get install -y curl && \
#     curl -fsSL https://deb.nodesource.com/setup_16.x | bash - && \
#     apt-get install -y nodejs && \
#     apt-get clean

# WORKDIR /app
# COPY ./client-react /app/
# RUN npm ci && npm run build

FROM node:alpine
WORKDIR /app/
COPY /index.js /app/
RUN npm i mongodb
CMD ["node","index.js"]