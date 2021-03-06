from django.forms import widgets
from rest_framework import serializers
from trackemployee.models import Employee
from pygments.lexers import get_all_lexers
from pygments.styles import get_all_styles

LEXERS = [item for item in get_all_lexers() if item[1]]
LANGUAGE_CHOICES = sorted([(item[1][0], item[0]) for item in LEXERS])
STYLE_CHOICES = sorted((item, item) for item in get_all_styles())

class EmployeeSerializer(serializers.Serializer):
    pk = serializers.Field()
    present = serializers.BooleanField()
    first_name = serializers.CharField(max_length=100)
    last_name = serializers.CharField(max_length=100)
    uid = serializers.CharField(max_length=100)
    email = serializers.EmailField(max_length=75)
    phone = serializers.CharField(max_length=12)
    def restore_object(self, attrs, instance=None):
        """
        Create or update a new snippet instance, given a dictionary
        of deserialized field values.

        Note that if we don't define this method, then deserializing
        data will simply return a dictionary of items.
        """
        if instance:
            # Update existing instance
            instance.title = attrs.get('title', instance.title)
            instance.code = attrs.get('code', instance.code)
            instance.linenos = attrs.get('linenos', instance.linenos)
            instance.language = attrs.get('language', instance.language)
            instance.style = attrs.get('style', instance.style)
            return instance

        # Create new instance
        return Employee(**attrs)
