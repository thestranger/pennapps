import re

from django.contrib.auth import authenticate, login
from django.contrib.auth.models import User
from django.shortcuts import render
from trackemployee.models import Employee
from django.http import HttpResponseRedirect
from django.db.models import Q

# Create your views here.


def query_request(request):
    queries = re.sub(' ', '+', request.POST['query'])
    return HttpResponseRedirect('/search/'+queries)


def login(request):
    context = {}
    if request.method == 'POST':    
        username = request.POST['username']
        password = request.POST['password']
        user = authenticate(username=username, password=password)
        if user is not None:
            if user.is_active:
                login(request, user)

            else:
                return
                # Account is disabled
        else:
            return
            # Invalid Login
    return render(request, 'trackemployee/login.html', context)
    
def index(request):
    context = {}
    if request.method == 'POST':
        if 'employee_filter' in request.POST.viewkeys():
            filter = request.POST['employee_filter']
            context['filter'] = filter
            if filter == 'present':
                context['employees'] = Employee.objects.filter(present=1).order_by('last_name')
            elif filter == 'absent':
                context['employees'] = Employee.objects.filter(present=0).order_by('last_name')
            else:
                context['employees'] = Employee.objects.all().order_by('last_name')
        elif 'query' in request.POST.viewkeys():
            return query_request(request)
    else:
        context['employees'] = User.objects.all().order_by('last_name')    
    return render(request, 'trackemployee/index.html', context)
    
    
def workplace(request):
    context = {}
    return render(request, 'trackemployee/workplace.html', context)

def search(request, query):
    if request.method == 'POST':
       return query_request(request)
    context = {}
    search_words = query.split('+')
    results = set()
    for word in search_words:
        results.update(Employee.objects.filter(Q(first_name__contains=word) | Q(last_name__contains=word)).order_by('last_name'))
    context['employees'] = list(results)
    return render(request, 'trackemployee/search.html', context)

def employee(request, employee_uid):
    if request.method == 'POST':
       return query_request(request)
    context = {}
    context['employee'] = Employee.objects.get(uid=employee_uid)
    return render(request, 'trackemployee/employee.html', context)

    
