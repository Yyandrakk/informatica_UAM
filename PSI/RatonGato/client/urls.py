from django.conf.urls import patterns, url, include
from django.contrib import admin
admin.autodiscover()
import views

urlpatterns = patterns('',
        url(r'^register/$', views.register, name='register'),
        url(r'^login/$', views.login, name='login'),
        url(r'^$', views.login, name='login'),
        url(r'^counter/$', views.counter, name='counter'),
        url(r'^move/$', views.move, name='move'),
        url(r'^logout/$', views.logout, name='logout'),
                       )



