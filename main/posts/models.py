from django.db import models
from django.conf import settings
# Create your models here.
class Post(models.Model):
    user = models.ForeignKey(settings.AUTH_USER_MODEL, on_delete=models.CASCADE)
    subject = models.CharField("標題", max_length=200)
    content = models.TextField("內容")
    created_date = models.DateTimeField("發文日期", auto_now_add=True)
    
    def __str__(self):
        return self.subject

class Comment(models.Model):
    post = models.ForeignKey(Post, on_delete=models.CASCADE, related_name='comments')
    user = models.ForeignKey(settings.AUTH_USER_MODEL, on_delete=models.CASCADE)
    content = models.TextField("內容")
    created_date = models.DateTimeField("留言日期", auto_now_add=True)
    
    def __str__(self):
        return self.content