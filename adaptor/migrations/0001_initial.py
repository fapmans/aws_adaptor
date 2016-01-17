# -*- coding: utf-8 -*-
from __future__ import unicode_literals

from django.db import models, migrations


class Migration(migrations.Migration):

    dependencies = [
    ]

    operations = [
        migrations.CreateModel(
            name='Apf',
            fields=[
                ('id', models.AutoField(primary_key=True, serialize=False, verbose_name='ID', auto_created=True)),
                ('name', models.CharField(max_length=255)),
                ('description', models.CharField(max_length=255)),
            ],
        ),
        migrations.CreateModel(
            name='Attribute',
            fields=[
                ('id', models.AutoField(primary_key=True, serialize=False, verbose_name='ID', auto_created=True)),
                ('name', models.CharField(max_length=255)),
                ('description', models.CharField(max_length=255)),
                ('ontology', models.BooleanField(default=False)),
                ('enumerated', models.BooleanField(default=False)),
                ('apf', models.ForeignKey(to='adaptor.Apf', null=True)),
            ],
        ),
        migrations.CreateModel(
            name='AttributeMapping',
            fields=[
                ('id', models.AutoField(primary_key=True, serialize=False, verbose_name='ID', auto_created=True)),
                ('apf_attribute', models.ForeignKey(to='adaptor.Attribute', related_name='apf_attribute')),
                ('local_attribute', models.ForeignKey(to='adaptor.Attribute', related_name='local_attribute')),
            ],
        ),
        migrations.CreateModel(
            name='Hierarchy',
            fields=[
                ('id', models.AutoField(primary_key=True, serialize=False, verbose_name='ID', auto_created=True)),
            ],
        ),
        migrations.CreateModel(
            name='Operator',
            fields=[
                ('id', models.AutoField(primary_key=True, serialize=False, verbose_name='ID', auto_created=True)),
                ('name', models.CharField(max_length=255)),
                ('description', models.CharField(max_length=255)),
                ('ontology', models.BooleanField(default=False)),
                ('apf', models.ForeignKey(to='adaptor.Apf', null=True)),
            ],
        ),
        migrations.CreateModel(
            name='OperatorMapping',
            fields=[
                ('id', models.AutoField(primary_key=True, serialize=False, verbose_name='ID', auto_created=True)),
                ('apf_operator', models.ForeignKey(to='adaptor.Operator', related_name='apf_operator')),
                ('local_operator', models.ForeignKey(to='adaptor.Operator', related_name='local_operator')),
            ],
        ),
        migrations.CreateModel(
            name='Tenant',
            fields=[
                ('id', models.AutoField(primary_key=True, serialize=False, verbose_name='ID', auto_created=True)),
                ('name', models.CharField(max_length=255)),
                ('description', models.CharField(max_length=255)),
            ],
        ),
        migrations.CreateModel(
            name='Value',
            fields=[
                ('id', models.AutoField(primary_key=True, serialize=False, verbose_name='ID', auto_created=True)),
                ('name', models.CharField(max_length=255)),
                ('description', models.CharField(max_length=255)),
                ('attribute', models.ForeignKey(to='adaptor.Attribute')),
            ],
        ),
        migrations.CreateModel(
            name='ValueMapping',
            fields=[
                ('id', models.AutoField(primary_key=True, serialize=False, verbose_name='ID', auto_created=True)),
                ('apf_value', models.ForeignKey(to='adaptor.Value', related_name='apf_value')),
                ('local_value', models.ForeignKey(to='adaptor.Value', related_name='local_value')),
            ],
        ),
        migrations.AddField(
            model_name='operator',
            name='tenant',
            field=models.ForeignKey(to='adaptor.Tenant', null=True),
        ),
        migrations.AddField(
            model_name='hierarchy',
            name='child',
            field=models.ForeignKey(to='adaptor.Value', related_name='child'),
        ),
        migrations.AddField(
            model_name='hierarchy',
            name='parent',
            field=models.ForeignKey(to='adaptor.Value', related_name='parent'),
        ),
        migrations.AddField(
            model_name='attribute',
            name='tenant',
            field=models.ForeignKey(to='adaptor.Tenant', null=True),
        ),
    ]
