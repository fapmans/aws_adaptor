# -*- coding: utf-8 -*-
from __future__ import unicode_literals

from django.db import models, migrations


class Migration(migrations.Migration):

    dependencies = [
        ('adaptor', '0001_initial'),
    ]

    operations = [
        migrations.RemoveField(
            model_name='operator',
            name='apf',
        ),
        migrations.RemoveField(
            model_name='operator',
            name='tenant',
        ),
    ]
