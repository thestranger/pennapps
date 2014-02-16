from django.db import models
from django.contrib.auth.models import User


class Employee(models.Model):
    """docstring for Employee"""
    user = models.OneToOneField(User)
    # from User have first_name, last_name, 
    # email, username, password
    present = models.BooleanField()
    uid = models.CharField(max_length=100)
    phone = models.CharField(max_length=12)


class TimeLog(models.Model):
    employee = models.ForeignKey(Employee)
    time_in = models.DateTimeField(null=True, blank=True)
    time_out = models.DateTimeField(null=True, blank=True)
