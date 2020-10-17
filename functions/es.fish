function es --description "Query Elasticsearch" --argument endpoint
    test -n "$ES_URL"
    or set -l ES_URL "http://127.0.0.1:9200"
    
    test -n "$ES_USER"
    or set -l ES_USER elastic

    test -n "$ES_PASSWORD"
    and set -l auth_args --insecure --user "$ES_USER:$ES_PASSWORD"

    command curl --silent --show-error \
        -H 'Content-Type: application/json' \
        -H 'Accept: application/json' \
        $auth_args \
        "$ES_URL/$endpoint" \
        $argv[2..-1] \
        | jq
end
