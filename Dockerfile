FROM node:18.4.0 AS build
COPY . /usr/src/app/
WORKDIR /usr/src/app/
RUN npm config set proxy http://161.27.213.250:8080
RUN npm config set https-proxy http://161.27.213.250:8080
RUN npm install
RUN node --max-old-space-size=5120 ./node_modules/@angular/cli/bin/ng build  

FROM nginx:alpine
EXPOSE 80
COPY --from=build /usr/src/app/dist/test-fe/. /usr/share/nginx/html/
