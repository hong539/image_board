from django.conf import settings
from django.db import models
from django.contrib.auth import get_user_model

class BlogPost(models.Model):
    author = models.ForeignKey(get_user_model(), on_delete=models.CASCADE)
    date = models.DateField()
    title = models.CharField(max_length=100)
    post = models.TextField()