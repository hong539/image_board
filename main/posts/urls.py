from django.urls import path

from . import views

app_name = "posts"
urlpatterns = [
    path("", views.IndexView.as_view(), name="index"),
    path("<int:pk>/", views.PostDetail.as_view(), name="detail"),
    path("create/", views.PostCreate.as_view(), name="create" ),
    path("<int:pk>/delete/", views.PostDelete.as_view(), name="delete"),
    path("reply/", views.CommentCreate.as_view(), name="reply"),
]