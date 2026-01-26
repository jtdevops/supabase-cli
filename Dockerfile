FROM alpine:latest
ARG version
ENV version=${version}
RUN apk add --no-cache libc6-compat && \
    wget https://github.com/supabase/cli/releases/download/v${version}/supabase_${version}_linux_amd64.apk && \
    apk add --no-cache --allow-untrusted supabase_${version}_linux_amd64.apk && \
    rm supabase_${version}_linux_amd64.apk