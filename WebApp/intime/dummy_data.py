from faker import Factory
from datetime import date, datetime, timedelta
from django.contrib.auth.models import User
from trackemployee.models import Employee, TimeLog
fake = Factory.create()


def gen_dummy_time_logs(user_id):

    year = date.today().year
    month = date.today().month
    day = date.today().day

    d = datetime(year, month, day, 0, 0, 0 , 0)

    curr = d - timedelta(days=7)

    while curr < d:
        t1_lb = curr+timedelta(hours=6)
        t1_up = curr+timedelta(hours=11)
        t2_lb = curr+timedelta(hours=15)
        t2_up = curr+timedelta(hours=20)

        time_in = fake.date_time_between(t1_lb, t1_up)
        time_out = fake.date_time_between(t2_lb, t2_up)

        TimeLog.objects.create(employee_id=user_id, time_in=time_in, time_out=time_out)
        curr += timedelta(days=1)

def gen_dummy_users(num):
    for i in range(num):
        first_name = fake.first_name()
        last_name = fake.last_name()
        email = fake.email()
        password = "password"
        username = fake.user_name()
        phone = fake.phone_number()
        present = False
        uid = fake.word()

        user = User.objects.create_user(username=username, email=email,
                                                password=password, first_name=first_name,
                                                last_name=last_name)


        employee = Employee.objects.create(user_id=user.id, phone=phone,
                                             present=present, uid=uid)

        gen_dummy_time_logs(user.id)