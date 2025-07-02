LOG_FILE="/var/log/cloud-init.log"
CONFIG_FILE="../configs/s3_config.json"

BUCKET=$(cat $CONFIG_FILE | jq -r '.bucket_name')
REGION=$(cat $CONFIG_FILE | jq -r '.region')

TIMESTAMP=$(date +%Y%m%d_%H%M%S)
aws s3 cp $LOG_FILE s3://$BUCKET/cloud-init-$TIMESTAMP.log --region $REGION

echo "✅ Log uploaded to S3"
