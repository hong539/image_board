from typing import Any
from django.shortcuts import render, get_object_or_404
from django.views.generic import ListView, DetailView, CreateView, DeleteView
from .models import Post, Comment
from django.contrib.auth.mixins import LoginRequiredMixin
from django.urls import reverse

class IndexView(ListView):
    model = Post
    ordering = ['-id']
    
class PostDetail(DetailView):
    model = Post
    template_name = 'posts/post_detail.html'

# 新增留言
class PostCreate(CreateView):
    model = Post
    fields = ['subject', 'content']     
    success_url = '/posts/'                   
    template_name = 'posts/post_create.html'

    def form_valid(self, form):
        form.instance.user = self.request.user        
        return super().form_valid(form)

# 刪除留言
class PostDelete(LoginRequiredMixin, DeleteView):
    model = Post
    success_url = '/posts/'                
    template_name = 'posts/post_delete.html'

class CommentCreate(CreateView):
    model = Comment
    fields = ['content']
    template_name = 'posts/comment_creat.html'

    def form_valid(self, form):
        form.instance.user = self.request.user
        form.instance.post = Post.objects.get(pk=self.kwargs.get('pk'))
        return super().form_valid(form)
    
    def get_success_url(self):
        return reverse('posts:detail', kwargs={'pk': self.kwargs.get('pk')})