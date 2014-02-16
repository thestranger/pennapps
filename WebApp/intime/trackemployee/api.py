from trackemployee.models import Employee, TimeLog
from django.contrib.auth.models import User
from django.contrib.auth import authenticate, login, logout
from tastypie.http import HttpUnauthorized, HttpForbidden
from django.conf.urls import url
from tastypie.utils import trailing_slash
from tastypie.resources import ModelResource
import logging
import datetime

logger = logging.getLogger(__name__)

class StatusResource(ModelResource):
    class Meta:
        queryset = Employee.objects.all()
        resource_name = 'status'
    def prepend_urls(self):
        return [
            url(r"^(?P<resource_name>%s)/change_status%s$" %
                (self._meta.resource_name, trailing_slash()),
                self.wrap_view('change_status'), name="change_status")]
                
    def change_status(self, request, **kwargs):
        self.method_check(request, allowed=['post'])
        data = self.deserialize(request, request.body, format=request.META.get('CONTENT_TYPE', 'application/json'))
        uid = data.get('uid', '')
        status = data.get('status', '')
        time = datetime.datetime.now()
        if not Employee.objects.filter(user_id=uid):
            return self.create_response(request, {
                    'success' : False,
                    'reason' : 'uid does not exist',
                    }, HttpUnauthorized)
        elif Employee.objects.filter(user_id=uid, present=status):
            return self.create_response(request, {
                    'success' : False,
                    'reason' : 'Status has not been changed',
                    }, HttpUnauthorized)
        
        employee = Employee.objects.get(user_=uid)
        employee.present = status
        employee.save()
        logger.info(type(uid))
        if status:
            timelog = TimeLog.objects.create(employee_id=uid, time_in=time.strftime('%Y-%m-%d %H:%M:%S'), time_out=None)
        else:
            timelog = TimeLog.objects.get(employee_id=uid, time_out=None)
            timelog.time_out=time.strftime('%Y-%m-%d %H:%M:%S')
            timelog.save()
        return self.create_response(request, {
                'success' : True,
                'uid' : uid,
                })
            
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
            url(r'^(?P<resource_name>%s)/create%s$' %
                (self._meta.resource_name, trailing_slash()),
                self.wrap_view('create'), name='api_create'),
        ]

    def create(self, request, **kwargs):
        logger.info("Creating new User")
        self.method_check(request, allowed=['post'])

        data = self.deserialize(request, request.body, format=request.META.get('CONTENT_TYPE', 'application/json'))

        username = data.get('username', '')
        password = data.get('password', '')
        email = data.get('email', '')
        first_name = data.get('first_name', '')
        last_name = data.get('last_name', '')
        uid = data.get('uid', '')
        phone = data.get('phone', '')
        present = False

        if User.objects.filter(username=username):
            return self.create_response(request, {
                    'success' : False,
                    'reason' : 'uid already in use',
                    }, HttpUnauthorized)
        else:
            user = User.objects.create_user(username=username, email=email,
                                            password=password, first_name=first_name,
                                            last_name=last_name)
            user.phone = phone
            user.present = present
            user.uid = uid
            user.save()
            logger.info("successful user creation")
            return self.create_response(request, {
                'success' : True,
                'uid' : user.id,
                })

    def login(self, request, **kwargs):
        logger.info("login started")
        self.method_check(request, allowed=['post'])
       
        data = self.deserialize(request, request.body, format=request.META.get('CONTENT_TYPE', 'application/json'))
    

        username = data.get('username', '')
        password = data.get('password', '')


        user = authenticate(username=username, password=password)
        if user:
            if user.is_active:
                login(request, user)
                logger.info("Login Successful")
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
      


    def logout(self, request, **kwargs):
        self.method_check(request, allowed=['get'])
        if request.user and request.user.is_authenticated():
            logout(request)
            return self.create_response(request, { 'success': True })
        else:
            return self.create_response(request, { 'success': False }, HttpUnauthorized)