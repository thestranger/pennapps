from django.shortcuts import render

from trackemployee.models import Employee

# Create your views here.
def login(request):
    context = {}
    return render(request, 'trackemployee/login.html', context)
    
def index(request):
    context = {}
    context['employees'] = Employee.objects.order_by('last_name')
    print context['employees']
    return render(request, 'trackemployee/index.html', context)
    
def employees(request):
    context = {}
    return render(request, 'trackemployee/employees.html', context)
    
def workplace(request):
    context = {}
    return render(request, 'trackemployee/workplace.html', context)
    
def test():