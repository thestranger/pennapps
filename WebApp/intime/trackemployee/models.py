from django.db import models


class Employee(models.Model):
    """docstring for Employee"""
    present = models.BooleanField()
    first_name = models.CharField(max_length=100)
    last_name = models.CharField(max_length=100)
    uid = models.CharField(max_length=100, primary_key=True)
    email = models.EmailField(max_length=75)
    phone = models.CharField(max_length=12, unique=True)


class TimeLog(models.Model):
    employee = models.ForeignKey(Employee)
    time_in = models.DateTimeField()
    time_out = models.DateTimeField()