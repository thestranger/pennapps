from trackemployee.models import Employee
from django.contrib.auth import authenticate, login, logout
from tastypie.http import HttpUnauthorized, HttpForbidden
from django.conf.urls import url
from tastypie.utils import trailing_slash
from tastypie.resources import ModelResource
import logging

logger = logging.getLogger(__name__)


class EmployeeResource(ModelResource):
    class Meta:
        queryset = Employee.objects.all()
        fields = ['phone']
        allowed_methods = ['get', 'post']
        resource_name = 'employee'

    def prepend_urls(self):
        return [
            url(r"^(?P<resource_name>%s)/login%s$" %
                (self._meta.resource_name, trailing_slash()),
                self.wrap_view('login'), name="api_login"),
            url(r'^(?P<resource_name>%s)/logout%s$' %
                (self._meta.resource_name, trailing_slash()),
                self.wrap_view('logout'), name='api_logout'),
        ]

    def login(self, request, **kwargs):
        logger.info("login started")
        self.method_check(request, allowed=['post'])

        logger.info(request.body)
       
        try:
            data = self.deserialize(request, request.body, format=request.META.get('CONTENT_TYPE', 'application/json'))
        
            logger.info("getting data")

            username = data.get('username', '')
            password = data.get('password', '')

            logger.info(username)

            user = authenticate(username=username, password=password)
            if user:
                if user.is_active:
                    login(request, user)
                    return self.create_response(request, {
                        'success': True
                    })
                else:
                    # Account disabled
                    return self.create_response(request, {
                        'success': False,
                        'reason': 'disabled',
                        }, HttpForbidden )
            else:
                # Invalid login
                return self.create_response(request, {
                    'success': False,
                    'reason': 'incorrect',
                    }, HttpUnauthorized )
        except Exception as e:
            logger.error(repr(e))
            return self.create_response(request, {"Well": e})


    def logout(self, request, **kwargs):
        self.method_check(request, allowed=['get'])
        if request.user and request.user.is_authenticated():
            logout(request)
            return self.create_response(request, { 'success': True })
        else:
            return self.create_response(request, { 'success': False }, HttpUnauthorized)