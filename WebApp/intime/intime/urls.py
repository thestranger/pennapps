from django.conf.urls import patterns, include, url
from trackemployee import views

from django.contrib import admin
admin.autodiscover()

urlpatterns = patterns('',
    # Examples:
    # url(r'^$', 'intime.views.home', name='home'),
    # url(r'^blog/', include('blog.urls')),

    url(r'^admin/', include(admin.site.urls)),
    url(r'^$', views.login, name='login'),
    #The main page should check to see if the user is authenticated, if s/he is. Direct to login, otherwise direct to main.
    url(r'^index$', views.index, name='index'),
    url(r'^employees$', views.employees, name='employees'),
    url(r'^workplace$', views.employees, name='workplace'),
)
