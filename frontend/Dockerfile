#build
FROM node:16-alpine as build
# Create app directory
WORKDIR /usr/src/app
COPY . .
RUN npm install \
    && npm run build

#release
FROM node:16-alpine
WORKDIR ./app
COPY --from=build /usr/src/app ./dist
RUN npm install -g http-server
EXPOSE 80
ENTRYPOINT ["http-server", "dist/frontend/", "-p", "80", "--proxy", "http://sausage-backend:8080"]

