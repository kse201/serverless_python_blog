import os

from datetime import datetime
from pynamodb.models import Model
from pynamodb.attributes import (
    UnicodeAttribute,
    NumberAttribute,
    UTCDateTimeAttribute
)

from flask_blog.libs.utils import is_production


class Entry(Model):
    class Meta:
        if is_production():
            aws_access_key_id = os.environ.get('SERVERLESS_AWS_ACCESS_KEY_ID')
            aws_secret_access_key = os.environ.get('SERVERLESS_AWS_SECRET_KEY')
        else:
            aws_access_key_id = 'AWS_ACCESS_KEY_ID'
            aws_secret_access_key = 'AWS_SECRET_ACESS_KEY'
            host = 'http://localhost:8000'

        table_name = 'serverless_blog_entries'
        region = os.environ.get('SERVERLESS_REGION', 'ap-northeast-1')

    id = NumberAttribute(hash_key=True, null=False)
    title = UnicodeAttribute(null=True)
    text = UnicodeAttribute(null=True)
    created_at = UTCDateTimeAttribute(default=datetime.now)
