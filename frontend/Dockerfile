#build
FROM node:16-alpine as build
# Create app directory
WORKDIR /usr/src/app
COPY . .
RUN npm install \    
     && npm run build

#release
# FROM node:16-alpine
# WORKDIR /app
# COPY --from=build /usr/src/app .
# RUN npm install -g http-server
# EXPOSE 80
# ENTRYPOINT ["http-server", "dist/frontend/", "-p", "80", "--proxy", "http://backend:8080"]
#release
FROM nginxproxy/nginx-proxy
WORKDIR /app
# RUN chmod -R 777 /usr/share/nginx/html
# RUN chmod -R 777 /app
COPY --from=build /usr/src/app/dist/frontend /usr/share/nginx/html
COPY ./nginx.tmpl /app
# RUN npm install -g http-server
EXPOSE 80
# ENTRYPOINT ["http-server", "dist/frontend/", "-p", "80", "--proxy", "http://backend:8080"]

#FROM node:16-alpine
# Create app directory
#WORKDIR /usr/src/app
#COPY . .
#RUN npm install \
#    && npm install -g http-server \ 
#    && npm run build
#EXPOSE 80
#ENTRYPOINT ["http-server", "dist/frontend/", "-p", "80", "--proxy", "http://backend:8080"]
