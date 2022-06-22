FROM jekyll/minimal AS build

WORKDIR /src

COPY _includes /src/_includes
COPY _layouts /src/_layouts
COPY _posts /src/_posts
COPY _sass /src/_sass
COPY assets /src/assets
COPY _config.yml /src/_config.yml
COPY docker/Gemfile /src/Gemfile
COPY index.html /src

RUN chown -R jekyll . && jekyll build -s /src -d /src/build

FROM nginx:latest

# Copy contents of site to container
COPY --from=build /src/build /usr/share/nginx/html/blog/

EXPOSE 80/tcp

# Setup nginx
RUN rm /etc/nginx/conf.d/default.conf && rm /usr/share/nginx/html/index.html
COPY docker/adaxisoft.be-blog.conf /etc/nginx/conf.d/default.conf

RUN find /usr/share/nginx/html

