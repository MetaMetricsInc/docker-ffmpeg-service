FROM jrottenberg/ffmpeg:centos

MAINTAINER Paul Visco <paul.visco@gmail.com>

#####################################################################
#
# A Docker image to convert audio and video for web using web API
#
#   with
#     - Latest FFMPEG (built)
#     - NodeJS
#     - fluent-ffmpeg
#
#   For more on Fluent-FFMPEG, see 
#
#            https://github.com/fluent-ffmpeg/node-fluent-ffmpeg
#
#####################################################################

# Add the following two dependencies for nodejs
RUN yum install -y git https://dl.fedoraproject.org/pub/epel/epel-release-latest-7.noarch.rpm && yum clean all
RUN yum install -y nodejs npm --enablerepo=epel && yum clean all

# Custom Builds go here
RUN npm install -g fluent-ffmpeg

#Create app dir
RUN mkdir -p /usr/src/app/uploads
WORKDIR /usr/src/app

#Install Dependencies
COPY package.json /usr/src/app
RUN npm install

#Bundle app source
COPY . /usr/src/app

EXPOSE 3000
ENTRYPOINT []
CMD [ "node", "app.js" ]
