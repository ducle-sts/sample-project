FROM node:latest as build
WORKDIR /app
COPY *.json /app
RUN yarn install
COPY . /app
RUN ng build

FROM nginx:latest
COPY --from=build /app/dist/sample-angular-app /usr/share/nginx/html
EXPOSE 80
