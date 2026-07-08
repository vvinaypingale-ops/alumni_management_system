FROM tomcat:9-jre11

# Remove default ROOT application to avoid conflicts
RUN rm -rf /usr/local/tomcat/webapps/ROOT

# Copy the entire WebContent directory to the ROOT application
COPY WebContent /usr/local/tomcat/webapps/ROOT/

EXPOSE 8080

CMD ["catalina.sh", "run"]
