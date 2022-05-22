# build environment
FROM node:lts-alpine as builder

# Make and set work folder ASK to Shannel

RUN mkdir -p /usr/src/app
WORKDIR /usr/src/app
# Setting PATH variable
ENV PATH /usr/src/app/node_modules/.bin:$PATH
# Copy as needed for app build
COPY package.json /usr/src/app/package.json
RUN npm install react-scripts@5.0.1 -g
COPY . /usr/src/app
RUN npm install --silent
RUN npm run build --silent

# production environment
FROM nginx:1.20.2-alpine
COPY --from=builder /usr/src/app/build /usr/share/nginx/html
EXPOSE 80
EXPOSE 3000
CMD ["nginx", "-g", "daemon off;"]
