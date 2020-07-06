from flask import (
    request,
    redirect,
    url_for,
    flash,
    render_template
)

from flask_login import login_user, logout_user

from flask_blog import app
from flask_blog.models.users import User


@app.route('/login', methods=['GET', 'POST'])
def login():
    if request.method == 'POST':
        if (request.form['username'] != app.config['USERNAME']
                or request.form['password'] != app.config['PASSWORD']):
            flash('Wrong username or password')
        else:
            login_user(User("request.form['username']"))
            flash('Logined')
            return redirect(url_for('show_entries'))
    return render_template('login.html')


@app.route('/logout')
def logout():
    logout_user()
    flash('Logout.')
    return redirect(url_for('login'))


@app.errorhandler(404)
def non_existant_route(error):
    return redirect(url_for('login'))
