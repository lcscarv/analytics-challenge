dbt deps

set +e
dbt $@
code=$?

if [[ "$@" == *"run"* ]]; then
    edr send-report --aws-access-key-id ${AWS_ACCESS_KEY_ID} --aws-secret-access-key ${AWS_SECRET_ACCESS_KEY} \
        --s3-bucket-name ${S3_ELEMENTARY_BUCKET_NAME} --bucket-file-path ${S3_ELEMENTARY_BUCKET_PATH}/elementary_report.html

    aws s3 cp ./elementary_output.json s3://${S3_ELEMENTARY_BUCKET_NAME}/${S3_ELEMENTARY_BUCKET_PATH}/elementary_output.json
fi

exit $code