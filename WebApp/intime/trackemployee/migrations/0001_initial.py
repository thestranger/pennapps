# -*- coding: utf-8 -*-
from south.utils import datetime_utils as datetime
from south.db import db
from south.v2 import SchemaMigration
from django.db import models


class Migration(SchemaMigration):

    def forwards(self, orm):
        # Adding model 'Employee'
        db.create_table(u'trackemployee_employee', (
            ('present', self.gf('django.db.models.fields.BooleanField')()),
            ('first_name', self.gf('django.db.models.fields.CharField')(max_length=100)),
            ('last_name', self.gf('django.db.models.fields.CharField')(max_length=100)),
            ('uid', self.gf('django.db.models.fields.CharField')(max_length=100, primary_key=True)),
            ('email', self.gf('django.db.models.fields.EmailField')(max_length=75)),
            ('phone', self.gf('django.db.models.fields.IntegerField')(unique=True, max_length=10)),
        ))
        db.send_create_signal(u'trackemployee', ['Employee'])

        # Adding model 'TimeLog'
        db.create_table(u'trackemployee_timelog', (
            (u'id', self.gf('django.db.models.fields.AutoField')(primary_key=True)),
            ('employee', self.gf('django.db.models.fields.related.ForeignKey')(to=orm['trackemployee.Employee'])),
            ('time_in', self.gf('django.db.models.fields.DateTimeField')()),
            ('time_out', self.gf('django.db.models.fields.DateTimeField')()),
        ))
        db.send_create_signal(u'trackemployee', ['TimeLog'])


    def backwards(self, orm):
        # Deleting model 'Employee'
        db.delete_table(u'trackemployee_employee')

        # Deleting model 'TimeLog'
        db.delete_table(u'trackemployee_timelog')


    models = {
        u'trackemployee.employee': {
            'Meta': {'object_name': 'Employee'},
            'email': ('django.db.models.fields.EmailField', [], {'max_length': '75'}),
            'first_name': ('django.db.models.fields.CharField', [], {'max_length': '100'}),
            'last_name': ('django.db.models.fields.CharField', [], {'max_length': '100'}),
            'phone': ('django.db.models.fields.IntegerField', [], {'unique': 'True', 'max_length': '10'}),
            'present': ('django.db.models.fields.BooleanField', [], {}),
            'uid': ('django.db.models.fields.CharField', [], {'max_length': '100', 'primary_key': 'True'})
        },
        u'trackemployee.timelog': {
            'Meta': {'object_name': 'TimeLog'},
            'employee': ('django.db.models.fields.related.ForeignKey', [], {'to': u"orm['trackemployee.Employee']"}),
            u'id': ('django.db.models.fields.AutoField', [], {'primary_key': 'True'}),
            'time_in': ('django.db.models.fields.DateTimeField', [], {}),
            'time_out': ('django.db.models.fields.DateTimeField', [], {})
        }
    }

    complete_apps = ['trackemployee']