import os


class Config():
    DEBUG = True
    SECRET_KEY = 'secret key'
    USERNAME = 'user'
    PASSWORD = 'password'


class DevelopmentConfig(Config):
    pass


class ProductionConfig(Config):
    DEBUG = False
    SECRET_KEY = os.environ.get('SERVERLESS_SECRET_KEY')
    USERNAME = 'john'
    PASSWORD = os.environ.get('SERVERLESS_USER_PW')
