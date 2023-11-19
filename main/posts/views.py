from typing import Any
from django.shortcuts import render, get_object_or_404
from django.views.generic import ListView, DetailView, CreateView, DeleteView
from .models import Post, Comment
from django.contrib.auth.mixins import LoginRequiredMixin

class IndexView(ListView):
    model = Post
    ordering = ['-id']
    # template_name = "index.html"
    # context_object_name = "posts_list"
    
    # def get_queryset(self):
    #     """Return the last five."""
    #     return Post.objects.order_by("-subject")

# # 留言列表
# class PostList(ListView):
#     model = Post
#     ordering = ['-id']      # 以 id 欄位值由大至小反向排序

# 留言檢視
# class PostDetail(DetailView):
#     model = Post, Comment
#     template_name = 'posts/post_detail.html'
    
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
    fields = ['post', 'user', 'content']     # 僅顯示 post, subject, content 這 3 個欄位
    success_url = '/posts/'                   # 新增成功後，導向留言列表
    template_name = 'posts/comment_creat.html'                 # 指定欲使用的頁面範本        