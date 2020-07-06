# pylint: disable=E402
import os

from flask import Flask
from flask_login import LoginManager


config = {
    'default': 'flask_blog.config.DevelopmentConfig',
    'development': 'flask_blog.config.DevelopmentConfig',
    'production': 'flask_blog.config.ProductionConfig'
}

app = Flask(__name__)
config_name = os.getenv('SERVERLESS_BLOG_CONFIG', 'default')
app.config.from_object(config[config_name])

login_manager = LoginManager()
login_manager.init_app(app)

from flask_blog.libs.utils import setup_auth
setup_auth(app, login_manager)

from flask_blog.views import views, entries
from flask_blog.views.views import login

login_manager.login_view = 'login'
login_manager.login_message = 'Please Login.'
