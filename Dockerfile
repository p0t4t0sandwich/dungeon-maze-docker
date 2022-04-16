FROM ubuntu:latest
RUN apt-get update && apt-get install -y\
    openjdk-8-jre-headless\
    screen\
  && rm -rf /var/lib/apt/lists/*\
  && mkdir /output
ENV MEM=${variable:-1024} RADIUS=${variable:-1000} OUTPUT_DIR=${variable:-world_file}
COPY server/ ./
CMD /start.sh ${MEM} ${RADIUS} ${OUTPUT_DIR}
