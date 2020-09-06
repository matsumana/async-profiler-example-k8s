FROM adoptopenjdk:11.0.8_10-jdk-hotspot as builder

# async-profiler
RUN cd /tmp && \
    curl -L -O https://github.com/jvm-profiling-tools/async-profiler/releases/download/v1.8.1/async-profiler-1.8.1-linux-x64.tar.gz && \
    mkdir /tmp/async-profiler && \
    tar xvf async-profiler-1.8.1-linux-x64.tar.gz -C /tmp/async-profiler


# --------------------------------------
FROM adoptopenjdk:11.0.8_10-jdk-hotspot

RUN useradd app
RUN mkdir /app
RUN chown -R app:app /app

USER app

COPY --chown=app:app ./build/libs/*.jar /app/app.jar
COPY --from=builder --chown=app:app /tmp/async-profiler /async-profiler

CMD ["java", "-jar", "/app/app.jar"]
