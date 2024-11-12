# Version number, normally provided by Docker build command, otherwise use default
ARG sw_version=1.9.3

FROM ubuntu:latest

# Consume the build argument in the build stage (without this, it's unknown bolow)
ARG sw_version

RUN apt-get update && apt-get install -y \
    pipx

# Install word_cloud

RUN pipx install wordcloud==${sw_version}

# Move the wordcloud_cli to bin
RUN mv /root/.local/bin/wordcloud_cli /bin

# Make sure all files and folders under /root are readable by all, because the python packages are installed there
# Add read and execute permissions to all files and folders under /root
RUN find /root -type d -exec chmod a+rx {} \;
RUN find /root -type f -exec chmod a+r {} \;

# Set the working directory
WORKDIR /bin

# What the container should run when it is started.
CMD ["/bin/wordcloud_cli"]


