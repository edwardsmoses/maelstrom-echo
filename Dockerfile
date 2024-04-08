# Start from the Microsoft Go devcontainer base image
FROM mcr.microsoft.com/devcontainers/go:1-1.22-bookworm

# Set the working directory in the container
WORKDIR /usr/src/app

# Install JDK, Graphviz, and Gnuplot
RUN apt-get update && apt-get install -y --fix-missing \
    openjdk-17-jdk \
    graphviz \
    gnuplot \
    && rm -rf /var/lib/apt/lists/*

# Download Maelstrom (Replace the URL with the actual download link for the latest version)
ADD https://github.com/jepsen-io/maelstrom/releases/download/v0.2.3/maelstrom.tar.bz2 /usr/src/app

# Unpack Maelstrom and cleanup
RUN tar -xjf maelstrom.tar.bz2 && rm maelstrom.tar.bz2

# Define environment variable for Java Home (Adjust if needed based on the JDK version installed)
ENV JAVA_HOME /usr/lib/jvm/java-11-openjdk-amd64

# The base image already exposes common ports and sets up the Go environment, so you may not need to repeat those steps unless you have specific needs

# Optionally define a command to run Maelstrom or any other service
CMD ["./maelstrom"]

