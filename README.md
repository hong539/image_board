# image_board

## To-do-list

* reference implementation
    * [pinry](https://github.com/pinry/pinry)
    * [Boorunaut](https://pypi.org/project/Boorunaut/)
    * [forked from gnstaxo/imageboard](https://github.com/hong539/imageboard)
    * [szurubooru](https://github.com/rr-/szurubooru)
        * Image board engine, Danbooru-style.
    * [A Complete Beginner's Guide to Django - Part 1](https://simpleisbetterthancomplex.com/series/2017/09/04/a-complete-beginners-guide-to-django-part-1.html)
* app post:
    * How to render images/video Thumbnail?
    * edit views/PostDetail to make query for two models(Post/Comment) or even combine them into one to render template post_detail.html
        * [ForeignKey.related_name](https://docs.djangoproject.com/en/4.2/ref/models/fields/#django.db.models.ForeignKey.related_name)
            * edit/checkt post_detail.html
            * To display the comments associated with the post, you can use the related_name attribute in the ForeignKey field of the Comment model. Here’s an example:
            * post is the Post object that we want to display comments for, and comments is the related_name that we defined in the ForeignKey field of the Comment model.
* app accounts:
    * custom login/logged out page
    * user permission relations

## Prerequisites

* Linux host such as Arch Linux, Debian, Ubuntu, RHEL ...etc
* Python >= 3.10
* [pyenv+poetry](https://github.com/hong539/setup_dev_environment/blob/main/programming_languages/python/python.md#usage-with-pyenvpoetry)
    * pyenv for Python versions control
    * poetry for Project dependency control
    * Project dependcy detialls will be in pyproject.toml/poetry.lock
* MySQL
    * [docker hub/MySQL](https://hub.docker.com/_/mysql)
    * [MySQL 8.0 Reference Manual](https://dev.mysql.com/doc/refman/8.0/en/)
    * [教學課程：使用 MySQL 和 Docker Compose 建立多容器應用程式](https://learn.microsoft.com/zh-tw/visualstudio/docker/tutorials/tutorial-multi-container-app-mysql)
* tree
    * a CLI tools to list contents of directories in a tree-like format.
* docker/podman (just pickup one to do conatiner image building and running)

## Quick Start

```shell
#spawns a virtual environment
poetry shell

#add packages
#src: https://python-poetry.org/docs/cli/#add
poetry add django
poetry add gunicorn
poetry add diagrams -G dev
poetry add django-environ==0.10.0

#remove packages
poetry remove diagrams
poetry remove django-environ

#for help
python3 manage.py help

#Creating a superuser for Django CMS system
python3 manage.py createsuperuser

#run devserver
python manage.py runserver 8080


#check gunicorn
gunicorn --version
#run with gunicorn
#some test codes in misc
gunicorn --workers=2 test_gunicorn01:app
#run with django project
#src: https://docs.djangoproject.com/en/4.2/howto/deployment/wsgi/gunicorn/
gunicorn locallibrary.wsgi


#Warning: You'll need to run these commands every time your models change in a way that will affect the structure of the data that needs to be stored (including both addition and removal of whole models and individual fields).
python3 manage.py makemigrations
python3 manage.py migrate

python3 manage.py sqlmigrate posts 0001

#run test
python3 manage.py test
#Showing more test information
python3 manage.py test --verbosity 2
#Speeding things up
python3 manage.py test --parallel auto
#Running specific tests
python3 manage.py test catalog.tests.test_models
python3 manage.py test catalog.tests.test_views
python3 manage.py test catalog.tests.test_forms

#deploy check
python3 manage.py check --deploy

#Starts the Python interactive interpreter
python3 manage.py shell

#src: https://docs.python.org/3.8/library/sys.html#sys.path
#A list of strings that specifies the search path for modules. 
#Initialized from the environment variable PYTHONPATH, plus an installation-dependent default.
python -c "import sys; print(sys.path)"

#add env PYTHONPATH
export PYTHONPATH=/path/to/your/module:$PYTHONPATH

#add packages by poetry
poetry add "psycopg[binary,pool]"
poetry add django-environ

#add packages by poetry to extras section
poetry add diagrams --optional --extras diagrams

#export requirements.txt if needed
poetry export -f requirements.txt --output requirements.txt
poetry export -f requirements.txt --output requirements.txt --without-hashes
```

## Test

* [django / pass multiple models to my ListView](https://stackoverflow.com/questions/67223248/django-pass-multiple-models-to-my-listview)
* table join
* [Changing to a custom user model mid-project](https://docs.djangoproject.com/en/4.2/topics/auth/customizing/#changing-to-a-custom-user-model-mid-project)
* [Writing your first Django app, part 2](https://docs.djangoproject.com/en/4.2/intro/tutorial02/)
* [Playing with the API](https://docs.djangoproject.com/en/4.2/intro/tutorial02/#playing-with-the-api)
* [get_user_model()](https://docs.djangoproject.com/en/4.2/topics/auth/customizing/#django.contrib.auth.get_user_model)
* [[Day24] - Django-REST-Framework User Management](https://ithelp.ithome.com.tw/articles/10278976)
* [django.contrib.auth](https://docs.djangoproject.com/en/4.2/ref/contrib/auth/)
* [Django_BBS](https://github.com/devbruce/Django_BBS)

```shell
$ python manage.py shell
>>> from django.contrib.auth import get_user_model
>>> from myapp.models import BlogPost
>>> user = get_user_model().objects.create_user(username='testuser', password='12345')
>>> post = BlogPost.objects.create(author=user, date='2023-11-16', title='Test Post', post='This is a test post.')
>>> post.author.username
'testuser'
```

## Misc

* [chatgpt-line-bot](https://github.com/Lin-jun-xiang/chatgpt-line-bot)
* [gpt4free](https://github.com/xtekky/gpt4free)