function es --argument url --description "Query Elasticsearch"

    set -l db_url "$ES_URL"

    test -n "$db_url"
    or set -l db_url "http://localhost:9200"

    command curl -sS \
        -H 'Content-Type: application/json' \
        "$db_url/$url" \
        $argv[2..-1] \
        | jq
end
