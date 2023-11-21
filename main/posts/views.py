from typing import Any
from django.shortcuts import render, get_object_or_404
from django.views.generic import ListView, DetailView, CreateView, DeleteView
from .models import Post, Comment
from django.contrib.auth.mixins import LoginRequiredMixin
from django.urls import reverse_lazy

class IndexView(ListView):
    model = Post
    ordering = ['-id']
    
class PostDetail(DetailView):
    model = Post
    template_name = 'posts/post_detail.html'

# 新增留言
class PostCreate(CreateView):
    model = Post
    fields = ['user', 'subject', 'content']     # 僅顯示 user, subject, content 這 3 個欄位
    success_url = '/posts/'                   # 新增成功後，導向留言列表
    template_name = 'posts/post_create.html'                 # 指定欲使用的頁面範本

# 刪除留言
class PostDelete(LoginRequiredMixin, DeleteView):
    model = Post
    success_url = '/posts/'                # 刪除成功返回留言列表
    template_name = 'posts/post_delete.html'

class CommentCreate(CreateView):
    model = Comment
    fields = ['user', 'post', 'content']
    success_url = '/posts/'
    # success_url = reverse_lazy('detail')
    template_name = 'posts/comment_creat.html'
    
    # def form_valid(self, form):
    #     form.instance.user = self.request.user
    #     form.instance.post_id = self.kwargs['post']
    #     return super().form_valid(form)    