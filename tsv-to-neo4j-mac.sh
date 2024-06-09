set -o nounset -o pipefail -o errexit

neo4j-admin database import full --nodes "${tsv_dir}/nodes_header.tsv,${tsv_dir}/nodes.tsv" \
    --relationships "${tsv_dir}/edges_header.tsv,${tsv_dir}/edges.tsv" \
    --multiline-fields=true --delimiter "\009" \
    --array-delimiter=";" --report-file="${tsv_dir}/import.report" \
    --overwrite-destination=true \
    --skip-bad-relationships=true

neo4j start

echo "create indexes"
python -u create_indexes_constraints.py --user neo4j --password $neo4j_password
