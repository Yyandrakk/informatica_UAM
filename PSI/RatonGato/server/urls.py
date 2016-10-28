from django.conf.urls import patterns, url, include
from django.contrib import admin
admin.autodiscover()
from tastypie.api import Api # modulo webservices
from api import UserResource # clase en api.py con informacion sobre url
import views
user_api=Api(api_name='v1')       # v1 es una etiqueta para identificar el recurso
user_api.register(UserResource()) # registrar  api.UserResource

urlpatterns = patterns('',
        url(r'^register/$', views.register, name='register'),
        url(r'^login/$', views.login, name='login'),
        url(r'^api/',include(user_api.urls)),# agnadir los urls contenidas en api.Userresource.prepend_urls
                       )