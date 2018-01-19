FROM ruby:2.5-slim

RUN mkdir /app

WORKDIR /app

RUN cd /app

RUN echo "Hello, World" > index.html

CMD ruby -rwebrick -e 'WEBrick::HTTPServer.new(:Port => 80, :DocumentRoot => "index.html").start'
