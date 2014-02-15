from django.shortcuts import render

from trackemployee.models import Employee
# Create your views here.
def login(request):
    context = {}
    return render(request, 'trackemployee/login.html', context)
    
def index(request):
    context = {}
    if request.method == 'POST':
        filter = request.POST['employee_filter']
        if filter == 'present':
            context['employees'] = Employee.objects.filter(present=1).order_by('last_name')
        elif filter == 'absent':
            context['employees'] = Employee.objects.filter(present=0).order_by('last_name')
        else:
            context['employees'] = Employee.objects.all().order_by('last_name')
    else:
        context['employees'] = Employee.objects.all().order_by('last_name')    
    return render(request, 'trackemployee/index.html', context)
    
    
def workplace(request):
    context = {}
    return render(request, 'trackemployee/workplace.html', context)

def search(request):
    context = {}
    return render(request, 'trackemployee/workplace.html', context)

def employee(request, employee_uid):
    context = {}
    return render(request, 'trackemployee/workplace.html', context)

    
