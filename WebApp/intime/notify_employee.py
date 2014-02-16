#TODO: set the from email for sendgrid

from trackemployee.models import Employee
from twilio.rest import TwilioRestClient
import sendgrid


TWILIO_ACCOUNT_SID = 'AC73992cc65e96edadd5692aa2bc715641'
TWILIO_AUTH_TOKEN = 'dd65afd716e2ee1589e6de3f9136724b'
client = TwilioRestClient(TWILIO_ACCOUNT_SID, TWILIO_AUTH_TOKEN)
sg = sendgrid.SendGridClient('sawsym', 'qwertyuiop')


def send_text(employee):
    name = employee.first_name
    message = client.sms.messages.create(body=
                                         "%s, you are late for work, "
                                         "please come now" % (name),
                                         to="+1%d" % (employee.phone),
                                         from_="+12407433278")
    print message.sid


def send_email(employee):
    message = sendgrid.Mail()
    message.add_to('%s <%s>' % (employee.name, employee.email))
    message.set_subject('Late For Work')
    message.set_html('''<body><p>Hi %s<br/>It appears you are late
                        for work. Please attempt to be more punctual
                        in the future.</p></body>
                     ''' % (employee.name))
    message.set_text('''
                    Hi %s\nIt appears you are late
                        for work. Please attempt to be more punctual
                        in the future.
                    ''' % (employee.name))
    message.set_from('The Boss <doe@email.com>')
    sg.send(message)


if __name__ == '__main__':
    e = Employee(first_name="Sawyer", last_name="Symington",
                 present=False, uid="1234341", phone=12408994271,
                 email="sawsym@hotmail.com")
    # send_text(e)
