# BUILD PHASE
FROM node:22.16.0-alpine3.21 AS build

WORKDIR /app

COPY package.json yarn.lock ./

RUN yarn --frozen-lockfile

COPY . .

RUN yarn build

# RUN PHASE
FROM nginx
EXPOSE 80
COPY --from=build /app/dist /usr/share/nginx/html

