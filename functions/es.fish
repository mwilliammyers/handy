function es --description "Query Elasticsearch" --argument url
    set -l db_url "$ES_URL"

    test -n "$db_url"
    or set -l db_url "http://127.0.0.1:9200"

    command curl -sS \
        -H 'Content-Type: application/json' \
        -H 'Accept: application/json' \
        "$db_url/$url" \
        $argv[2..-1] \
        | jq
end
