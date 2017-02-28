FROM websphere-liberty:webProfile7
MAINTAINER Steven Tobias <stobias@harborfreight.com>

LABEL io.k8s.description="Platform for serving Websphere Liberty Applications" \
      io.k8s.display-name="Websphere Liberty webProfile7 1.01" \
      io.openshift.expose-services="9080:http,9443:https" \
      io.openshift.tags="builder,html,websphere-liberty-openshift"

# Defines the location of the S2I
LABEL io.openshift.s2i.scripts-url=image:///usr/local/s2i
# Copy the S2I scripts from ./.s2i/bin/ to /usr/local/s2i when making the builder image
COPY ./.s2i/bin/ /usr/local/s2i


RUN useradd websphere \
    && mkdir -p /config/jvm /config/dropins /config/lib \
    && chown -R websphere.websphere /opt/ibm/wlp /logs /config

USER websphere

# Specify the ports the final image will expose
# These are already exposed in websphere-liberty:kernel. Added here for clarity
EXPOSE 8080 9443

# Set the default CMD to print the usage of the image, if somebody does docker run
CMD ["usage"]
