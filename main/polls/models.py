import datetime
from django.db import models
from django.utils import timezone

class Question(models.Model):
    question_text = models.CharField(max_length=200)
    pub_date = models.DateTimeField("date published")

    def __str__(self):
        return self.question_text
    
    def was_published_recently(self):
        return self.pub_date >= timezone.now() - datetime.timedelta(days=1)    

class Choice(models.Model):
    question = models.ForeignKey(Question, on_delete=models.CASCADE)
    choice_text = models.CharField(max_length=200)
    votes = models.IntegerField(default=0)
    
    def __str__(self):
        return self.choice_text

from django.conf import settings
from django.db import models
from django.contrib.auth import get_user_model

class BlogPost(models.Model):
    author = models.ForeignKey(get_user_model(), on_delete=models.CASCADE)
    date = models.DateField()
    title = models.CharField(max_length=100)
    post = models.TextField()
        